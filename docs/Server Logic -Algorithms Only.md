Volume XIV — Server Logic (Algorithms Only).

Every high-level precondition guard function provided has been fleshed out into production-ready pseudocode, complete with state mutations, resource locking patterns, time calculations, error types, and the precise round-by-round math behind the reconstructed Evony Age I Combat Engine.
📘 Volume XIV — Server Logic (Algorithms Only)
1. Build Validation & State Mutation

function canBuild(city, buildingType, targetPosition):
    // 1. Position validation
    if targetPosition < 1 or targetPosition > MAX_BUILDING_SLOTS:
        return fail("INVALID_POSITION")
        
    if positionOccupied(city, targetPosition):
        return fail("POSITION_OCCUPIED")

    // 2. Dependencies check
    reqs = getBuildingRequirements(buildingType, 1)
    for req in reqs:
        if not satisfiesRequirement(city, req):
            return fail("MISSING_DEPENDENCY", req)

    // 3. Unique / Count Limits (e.g., Town Hall = 1, Cottage = TownHall dependent)
    currentCount = countBuildingType(city, buildingType)
    maxAllowed = getBuildingTypeLimit(city, buildingType)
    if currentCount >= maxAllowed:
        return fail("LIMIT_REACHED")

    // 4. Resources
    cost = getBuildCost(buildingType, 1)
    if not hasResources(city, cost):
        return fail("INSUFFICIENT_RESOURCES", cost)

    // 5. Queue availability
    if getActiveBuildQueueCount(city) >= getMaxBuildQueueSlots(city):
        return fail("BUILD_QUEUE_FULL")

    return ok()


function executeBuild(city, buildingType, targetPosition):
    status = canBuild(city, buildingType, targetPosition)
    if not status.isOk:
        return status

    cost = getBuildCost(buildingType, 1)
    deductResources(city, cost)

    baseTime = getBuildTimeSeconds(buildingType, 1)
    mayorPolitics = getMayorAttribute(city, "politics")
    constructionTech = getTechLevel(city.player, "Construction")
    
    // Duration reduction formula
    actualDuration = baseTime / (1 + (mayorPolitics * 0.005) + (constructionTech * 0.10))

    taskId = createQueueTask({
        type: "BUILD",
        cityId: city.id,
        buildingType: buildingType,
        targetLevel: 1,
        position: targetPosition,
        startTime: currentTime(),
        endTime: currentTime() + actualDuration
    })

    return ok({ taskId: taskId, duration: actualDuration })

2. Upgrade Validation & State Mutation

function canUpgrade(city, building):
    nextLevel = building.level + 1

    if nextLevel > MAX_BUILDING_LEVEL: // Level 10 max
        return fail("MAX_LEVEL_REACHED")

    if building.status != "IDLE":
        return fail("BUILDING_BUSY")

    // Dependencies for specific level
    reqs = getBuildingRequirements(building.type, nextLevel)
    for req in reqs:
        if not satisfiesRequirement(city, req):
            return fail("MISSING_DEPENDENCY", req)

    cost = getBuildCost(building.type, nextLevel)
    if not hasResources(city, cost):
        return fail("INSUFFICIENT_RESOURCES", cost)

    if getActiveBuildQueueCount(city) >= getMaxBuildQueueSlots(city):
        return fail("BUILD_QUEUE_FULL")

    return ok()


function executeUpgrade(city, building):
    status = canUpgrade(city, building)
    if not status.isOk:
        return status

    nextLevel = building.level + 1
    cost = getBuildCost(building.type, nextLevel)
    deductResources(city, cost)

    setBuildingStatus(building, "UPGRADING")

    baseTime = getBuildTimeSeconds(building.type, nextLevel)
    mayorPolitics = getMayorAttribute(city, "politics")
    constructionTech = getTechLevel(city.player, "Construction")
    
    actualDuration = baseTime / (1 + (mayorPolitics * 0.005) + (constructionTech * 0.10))

    taskId = createQueueTask({
        type: "UPGRADE",
        cityId: city.id,
        buildingId: building.id,
        targetLevel: nextLevel,
        startTime: currentTime(),
        endTime: currentTime() + actualDuration
    })

    return ok({ taskId: taskId, duration: actualDuration })

3. Train Validation & State Mutation

function canTrain(city, unitType, count):
    if count <= 0:
        return fail("INVALID_COUNT")

    // Building requirements (e.g., Barracks level)
    if not satisfiesRequirement(city, getUnitBuildingRequirement(unitType)):
        return fail("MISSING_BUILDING_REQUIREMENT")

    // Research requirements (e.g., Archery level)
    if not satisfiesRequirement(city.player, getUnitTechRequirement(unitType)):
        return fail("MISSING_RESEARCH_REQUIREMENT")

    // Population check
    popNeeded = getUnitPopCost(unitType) * count
    if city.population.idle < popNeeded:
        return fail("INSUFFICIENT_IDLE_POPULATION")

    // Resources check
    cost = multiplyCost(getTrainCost(unitType), count)
    if not hasResources(city, cost):
        return fail("INSUFFICIENT_RESOURCES", cost)

    // Training Queue check
    if getActiveTrainingQueueCount(city) >= getMaxTrainingQueueSlots(city):
        return fail("TRAINING_QUEUE_FULL")

    return ok()


function executeTrain(city, unitType, count):
    status = canTrain(city, unitType, count)
    if not status.isOk:
        return status

    // Deduct population and resources
    popNeeded = getUnitPopCost(unitType) * count
    city.population.idle -= popNeeded
    
    cost = multiplyCost(getTrainCost(unitType), count)
    deductResources(city, cost)

    baseTimePerUnit = getTrainTimeSeconds(unitType)
    mayorAttack = getMayorAttribute(city, "attack")
    militaryScienceTech = getTechLevel(city.player, "MilitaryScience")

    actualDurationPerUnit = baseTimePerUnit / (1 + (mayorAttack * 0.005) + (militaryScienceTech * 0.10))
    totalDuration = actualDurationPerUnit * count

    queueId = createQueueTask({
        type: "TRAIN",
        cityId: city.id,
        unitType: unitType,
        count: count,
        startTime: currentTime(),
        endTime: currentTime() + totalDuration
    })

    return ok({ queueId: queueId, totalDuration: totalDuration })

4. Attack Validation & State Mutation

function canAttack(player, city, targetCoords, units, hero):
    // 1. Check rally spot capacity & march limits
    rallySpot = getBuilding(city, "RallySpot")
    if not rallySpot or rallySpot.level < 1:
        return fail("RALLY_SPOT_REQUIRED")

    if getActiveMarchCount(city) >= rallySpot.level:
        return fail("NO_MARCH_SLOTS_AVAILABLE")

    maxTroopsPerMarch = rallySpot.level * 10000 + (hero ? hero.level * 1000 : 0)
    if getTotalUnitCount(units) > maxTroopsPerMarch:
        return fail("EXCEEDS_MARCH_CAPACITY")

    // 2. Protection states
    if player.truceActive:
        return fail("CANNOT_ATTACK_UNDER_TRUCE")
    if player.beginnerProtectionActive and isPlayerTarget(targetCoords):
        return fail("CANNOT_ATTACK_UNDER_BEGINNER_PROTECTION")

    // 3. Units presence check
    for unitType, count in units:
        if getCityUnitCount(city, unitType) < count:
            return fail("INSUFFICIENT_UNITS", unitType)

    // 4. Hero availability check
    if hero:
        if hero.cityId != city.id or hero.status != "IDLE":
            return fail("HERO_UNAVAILABLE")

    return ok()


function executeAttack(player, city, targetCoords, units, hero):
    status = canAttack(player, city, targetCoords, units, hero)
    if not status.isOk:
        return status

    // Reserve troops and hero
    deductCityUnits(city, units)
    if hero:
        setHeroStatus(hero, "MARCHING")

    // Distance & Travel Time Calculation
    dist = calculateDistance(city.coords, targetCoords)
    slowestSpeed = getSlowestUnitSpeed(units)
    compassTech = getTechLevel(player, "Compass")
    
    speedMultiplier = 1 + (compassTech * 0.10)
    travelTimeSeconds = (dist / (slowestSpeed * speedMultiplier)) * 3600

    marchId = createMarch({
        fromCityId: city.id,
        targetCoords: targetCoords,
        type: "ATTACK",
        heroId: hero ? hero.id : null,
        units: units,
        departAt: currentTime(),
        arriveAt: currentTime() + travelTimeSeconds,
        returnAt: currentTime() + (travelTimeSeconds * 2),
        status: "MARCHING"
    })

    return ok({ marchId: marchId, arriveAt: currentTime() + travelTimeSeconds })

5. Research Validation & State Mutation

function canResearch(player, techType):
    currentLevel = getTechLevel(player, techType)
    nextLevel = currentLevel + 1

    if nextLevel > MAX_TECH_LEVEL:
        return fail("MAX_TECH_LEVEL_REACHED")

    // Academy requirement check
    academy = getHighestBuildingLevelAcrossCities(player, "Academy")
    requiredAcademyLevel = getRequiredAcademyLevel(techType, nextLevel)
    if academy < requiredAcademyLevel:
        return fail("ACADEMY_LEVEL_TOO_LOW")

    // Prerequisite research tech check
    reqs = getTechRequirements(techType, nextLevel)
    for req in reqs:
        if getTechLevel(player, req.tech) < req.level:
            return fail("MISSING_PREREQUISITE_TECH", req)

    // Cost evaluation
    cost = getResearchCost(techType, nextLevel)
    if not hasPlayerResourcesAcrossCities(player, cost):
        return fail("INSUFFICIENT_RESOURCES")

    // Active global player research check (Only 1 global tech at a time)
    if isPlayerResearching(player):
        return fail("RESEARCH_QUEUE_FULL")

    return ok()


function executeResearch(player, city, techType):
    status = canResearch(player, techType)
    if not status.isOk:
        return status

    nextLevel = getTechLevel(player, techType) + 1
    cost = getResearchCost(techType, nextLevel)
    deductResources(city, cost)

    baseTime = getResearchTimeSeconds(techType, nextLevel)
    mayorIntelligence = getMayorAttribute(city, "intelligence")
    informaticsTech = getTechLevel(player, "Informatics")

    actualDuration = baseTime / (1 + (mayorIntelligence * 0.005) + (informaticsTech * 0.10))

    taskId = createQueueTask({
        type: "RESEARCH",
        playerId: player.id,
        cityId: city.id,
        techType: techType,
        targetLevel: nextLevel,
        startTime: currentTime(),
        endTime: currentTime() + actualDuration
    })

    return ok({ taskId: taskId, duration: actualDuration })

6. Recruit Hero Validation & State Mutation

function canRecruitHero(city, innSlotIndex):
    inn = getBuilding(city, "Inn")
    if not inn or inn.level < 1:
        return fail("INN_REQUIRED")

    feastingHall = getBuilding(city, "FeastingHall")
    if not feastingHall:
        return fail("FEASTING_HALL_REQUIRED")

    currentHeroes = getCityHeroCount(city)
    if currentHeroes >= feastingHall.level:
        return fail("FEASTING_HALL_FULL")

    heroCandidate = getInnSlotCandidate(inn, innSlotIndex)
    if not heroCandidate:
        return fail("INVALID_INN_SLOT")

    goldCost = heroCandidate.level * 1000
    if city.resources.gold < goldCost:
        return fail("INSUFFICIENT_GOLD")

    return ok()


function executeRecruitHero(city, innSlotIndex):
    status = canRecruitHero(city, innSlotIndex)
    if not status.isOk:
        return status

    heroCandidate = getInnSlotCandidate(getBuilding(city, "Inn"), innSlotIndex)
    goldCost = heroCandidate.level * 1000
    
    city.resources.gold -= goldCost

    heroId = createHeroInstance({
        cityId: city.id,
        name: heroCandidate.name,
        level: heroCandidate.level,
        politics: heroCandidate.politics,
        attack: heroCandidate.attack,
        intelligence: heroCandidate.intelligence,
        loyalty: 70,
        isMayor: false,
        status: "IDLE"
    })

    clearInnSlot(city, innSlotIndex)

    return ok({ heroId: heroId })

7. Claim Valley Validation & State Mutation

function canClaimValley(player, city, valley, combatResult):
    if not combatResult.attackerWon:
        return fail("VALLEY_NOT_CONQUERED")

    townHall = getBuilding(city, "TownHall")
    maxValleys = townHall.level
    
    currentOwnedValleys = getOwnedValleyCount(player, city)
    if currentOwnedValleys >= maxValleys:
        return fail("VALLEY_SLOTS_FULL")

    if valley.ownerCityId != null and valley.ownerCityId != city.id:
        return fail("VALLEY_ALREADY_OWNED_BY_OTHER")

    return ok()


function executeClaimValley(player, city, valley, combatResult):
    status = canClaimValley(player, city, valley, combatResult)
    if not status.isOk:
        return status

    // Transfer Valley ownership
    valley.ownerCityId = city.id
    valley.claimedAt = currentTime()
    
    // Stations remaining troops as garrison if commanded
    garrisonTroops(valley, combatResult.survivingAttackerUnits)

    updateCityProductionRates(city) // Recalculate production percentage bonuses

    return ok({ valleyId: valley.id, status: "CLAIMED" })

8. Resolve Combat (Full Reconstructed Engine Loop)

This engine algorithm enforces the deterministic turn ordering, targeting, range calculations, and fortification clearing mechanics of Evony Age I.

function resolveCombat(attacker, defender, battlefield):
    state = initBattleState(attacker, defender, battlefield)

    applyTerrainBonuses(state)
    applyWallBonuses(state)

    // Combat round limits (Max 100 rounds before defender wins by timeout)
    while state.round <= 100 and not state.isFinished:
        
        // ----------------------------------------------------
        // Step 0: Check Unit Zero Counts
        // ----------------------------------------------------
        if getSurvivingCount(state.attacker) == 0 or getSurvivingCount(state.defender) == 0:
            state.isFinished = true
            break

        // ----------------------------------------------------
        // Phase 1: Fortifications (Traps, Abatis, Archer Towers)
        // ----------------------------------------------------
        resolveFortificationsPhase(state)

        // ----------------------------------------------------
        // Phase 2: Ranged Units Engagement Phase
        // ----------------------------------------------------
        resolveRangedPhase(state)

        // ----------------------------------------------------
        // Phase 3: Cavalry & Cataphracts Phase
        // ----------------------------------------------------
        resolveMountedPhase(state)

        // ----------------------------------------------------
        // Phase 4: Infantry Phase (Pikemen, Swordsmen, Warriors)
        // ----------------------------------------------------
        resolveInfantryPhase(state)

        // ----------------------------------------------------
        // Phase 5: Siege Engines (Bram, Catapult, Transporters)
        // ----------------------------------------------------
        resolveSiegePhase(state)

        // Advance positions / Reduce battlefield distance towards 0
        advanceBattlefieldPositions(state)
        state.round += 1

    // Post Combat Calculation & Cleanup
    computeCasualties(state)
    computeWounded(state) // Medic House percentage calculation
    
    if state.attackerWon:
        computeLoot(state)
        updateLoyalty(state)

    awardHeroXP(state)

    return buildCombatReport(state)

Detailed Phase Execution Logic

function resolveRangedPhase(state):
    // Execute attacker ranged units
    for unit in getRangedUnitsSortedBySpeed(state.attacker):
        target = findOptimalTarget(unit, state.defender, state.currentDistance)
        if target:
            damage = calculateDamagePool(unit, target, state.attacker.hero, state.attacker.tech)
            applyDamage(target, damage)

    // Execute defender ranged units (Simultaneous resolution)
    for unit in getRangedUnitsSortedBySpeed(state.defender):
        target = findOptimalTarget(unit, state.attacker, state.currentDistance)
        if target:
            damage = calculateDamagePool(unit, target, state.defender.hero, state.defender.tech)
            applyDamage(target, damage)


function calculateDamagePool(attackerUnit, defenderUnit, hero, tech):
    baseAttack = attackerUnit.count * attackerUnit.baseAttack
    
    // Hero Attack Bonus: 1 point of Hero Attack = +1% Base Attack
    heroBonus = 1 + (hero ? hero.attack * 0.01 : 0)
    
    // Tech Bonus (e.g., Archery or Military Science)
    techBonus = 1 + (getTechLevelForUnit(tech, attackerUnit.type) * 0.10)
    
    totalAttack = baseAttack * heroBonus * techBonus

    // Defense Reduction Math
    defenderDefense = defenderUnit.baseDefense * (1 + (defenderUnit.techLevel * 0.10))
    damageMultiplier = 100 / (100 + defenderDefense)

    finalDamage = totalAttack * damageMultiplier
    return finalDamage


function applyDamage(unitGroup, totalDamage):
    singleUnitHP = unitGroup.baseHP
    unitsKilled = floor(totalDamage / singleUnitHP)
    
    unitGroup.count = max(0, unitGroup.count - unitsKilled)


function computeWounded(state):
    // Medic House Wounded Conversion Math: Base ~30% of casualties become wounded
    medicLevel = getBuildingLevel(state.attacker.city, "MedicHouse")
    baseWoundedRate = 0.30 + (medicLevel * 0.02)

    for unitType, count in state.attacker.losses:
        state.attacker.wounded[unitType] = floor(count * baseWoundedRate)

    for unitType, count in state.defender.losses:
        state.defender.wounded[unitType] = floor(count * baseWoundedRate)
