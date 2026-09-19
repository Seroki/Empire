const pool = require('../database/db');
const cityService = require('./city.service');

// Barracks gets special treatment in requirement rows below: its level check
// uses the SPECIFIC selected facility (barracksLevel), not a city-wide max,
// since that's the whole point of the per-facility tab redesign. Every other
// building type in a requirement row checks against the max level of that
// type anywhere in the city.
const BARRACKS_BUILDING_TYPE_ID = 13;

// Building-name keys come from two different sources that don't agree on
// separators: city_buildings/building_types gives "Beacon Tower" (space,
// via UPPER(bt.name)), while unit_types.req_building_code gives
// "BEACON_TOWER" (underscore). Comparing them directly always misses for
// any multi-word building name — every such unit reads as locked at
// Lv 0 regardless of the real level. Strip everything but letters/digits
// on both sides before comparing so "BEACON TOWER" and "BEACON_TOWER"
// resolve to the same key.
function normalizeBuildingKey(raw) {
  return (raw || '').toUpperCase().replace(/[^A-Z0-9]/g, '');
}

// Every requirement row a unit has, keyed by unit_type_id. Each row is
// EITHER a research requirement (research_id set) OR a building requirement
// (requires_building_id + requires_building_level set) — same either/or
// pattern as research_node_prerequisites. A unit with multiple rows needs
// ALL of them satisfied (AND semantics). This replaced the old
// research-only getUnitResearchRequirements() once unit_research_requirements
// was extended to also hold building rows (the real Troops Matrix).
async function getUnitRequirements(client = pool) {
  const result = await client.query(
    `SELECT unit_type_id, research_id, requires_building_id, requires_building_level
     FROM unit_research_requirements`
  );
  const map = {};
  result.rows.forEach(r => {
    if (!map[r.unit_type_id]) map[r.unit_type_id] = [];
    map[r.unit_type_id].push(r);
  });
  return map;
}

async function getPlayerCompletedNodeSet(playerId, client = pool) {
  const result = await client.query(
    `SELECT research_node_id FROM player_completed_research_nodes WHERE player_id = $1`,
    [playerId]
  );
  return new Set(result.rows.map(r => r.research_node_id));
}

// Global (NOT city-scoped) name lookups — same pattern research_service.js
// already uses correctly. These previously came from a city-scoped
// building_types JOIN (only buildings the city already owns), which meant
// looking up the name of a MISSING building — exactly the case a locked
// unit's tooltip needs — always missed and fell back to "Building #22".
// A static, unconditional map has no such gap: the name exists whether or
// not the city has built one yet.
async function getBuildingNameMap(client = pool) {
  const result = await client.query(`SELECT id, name FROM building_types`);
  const map = {};
  result.rows.forEach(r => { map[r.id] = r.name; });
  return map;
}

async function getResearchNameMap(client = pool) {
  const result = await client.query(`SELECT id, name FROM research_nodes`);
  const map = {};
  result.rows.forEach(r => { map[r.id] = r.name; });
  return map;
}

// How much Levy is currently tied up in this city's active recruitment
// queue, across ALL barracks facilities — the Levy Pool is a shared city
// resource regardless of which building is training. Computed on the fly
// from the queue itself (same pattern as getReservedWorkers() for
// construction) instead of a running counter column, so it never needs to
// be manually decremented when training finishes. population_cost is the
// Levy Cost per unit (repurposed directly, per design decision).
async function getReservedLevy(cityId, client = pool) {
  const result = await client.query(`
    SELECT rq.quantity, ut.population_cost
    FROM recruitment_queue rq
    JOIN unit_types ut ON rq.unit_type_id = ut.id
    WHERE rq.city_id = $1 AND rq.finish_at > NOW()
  `, [cityId]);

  return result.rows.reduce((total, row) => {
    const cost = Number(row.population_cost || 1);
    return total + cost * Number(row.quantity);
  }, 0);
}

// Move any recruitment orders whose timer has already elapsed into
// city_units, and clear them out of the queue. Mirrors
// processCompletedConstruction() in building.service.js.
async function processCompletedRecruitment(cityId) {
  const completedResult = await pool.query(`
    SELECT * FROM recruitment_queue
    WHERE city_id = $1 AND finish_at <= NOW()
  `, [cityId]);

  for (const item of completedResult.rows) {
    await pool.query(`
      INSERT INTO city_units (city_id, unit_type_id, amount)
      VALUES ($1, $2, $3)
      ON CONFLICT (city_id, unit_type_id)
      DO UPDATE SET amount = city_units.amount + EXCLUDED.amount
    `, [cityId, item.unit_type_id, item.quantity]);

    await pool.query(`DELETE FROM recruitment_queue WHERE id = $1`, [item.id]);
  }
}

/**
 * Evaluates unit training requirements.
 *
 * Previously this returned as soon as ANY single check failed, so a unit
 * with multiple unmet requirements only ever showed one of them — no way
 * to build a real "here's everything you need" tooltip from that. Now it
 * evaluates every requirement, met or not, and returns the full list —
 * same shape research_service.js already uses for research node
 * prerequisites ({ type, name, met }) — so both places can share one
 * tooltip format. `passed`/`reason` are kept for existing callers that
 * only care about the pass/fail outcome (e.g. the training-order guard).
 *
 * requires researchNameMap (research_id -> name) and buildingNamesByType
 * (building_type_id -> name) to be GLOBAL lookups (see getBuildingNameMap /
 * getResearchNameMap above) — not scoped to what the city currently owns,
 * since a locked requirement is precisely the case where the city doesn't
 * have that building/research yet.
 */
function evaluatePrerequisites(unit, buildingLevels, completedNodeSet, requirementRows, barracksLevel, buildingLevelsByType, buildingNamesByType, researchNameMap) {
  const rows = requirementRows || [];
  const requirements = [];

  // 1. Dedicated research rows (unit_research_requirements, research_id set)
  rows.filter(r => r.research_id).forEach(r => {
    const name = researchNameMap?.[r.research_id] || r.research_id;
    requirements.push({
      type: 'RESEARCH',
      id: r.research_id,
      name,
      met: completedNodeSet.has(r.research_id)
    });
  });

  // 2. Barracks Level Check (dedicated column, unchanged logic — now just
  // recorded as a requirement entry instead of an early return)
  const reqBarracks = Number(unit.min_barracks_level || unit.required_barracks_level || 1);
  requirements.push({
    type: 'BUILDING',
    id: BARRACKS_BUILDING_TYPE_ID,
    name: `Barracks Lv ${reqBarracks}`,
    requiredLevel: reqBarracks,
    currentLevel: barracksLevel || 0,
    met: (barracksLevel || 0) >= reqBarracks
  });

  // 3. Workshop & Stable Checks (dedicated columns, unchanged logic) —
  // only listed when actually required by this unit.
  const reqWorkshop = Number(unit.required_workshop_level || 0);
  if (reqWorkshop > 0) {
    const currentWorkshopLv = buildingLevels[normalizeBuildingKey('WORKSHOP')] || 0;
    requirements.push({
      type: 'BUILDING',
      id: null,
      name: `Workshop Lv ${reqWorkshop}`,
      requiredLevel: reqWorkshop,
      currentLevel: currentWorkshopLv,
      met: currentWorkshopLv >= reqWorkshop
    });
  }

  const reqStable = Number(unit.required_stable_level || 0);
  if (reqStable > 0) {
    const currentStableLv = buildingLevels[normalizeBuildingKey('STABLE')] || 0;
    requirements.push({
      type: 'BUILDING',
      id: null,
      name: `Stable Lv ${reqStable}`,
      requiredLevel: reqStable,
      currentLevel: currentStableLv,
      met: currentStableLv >= reqStable
    });
  }

  // 4. Generic Building Check (req_building_code & req_building_level)
  if (unit.req_building_code) {
    const buildingKey = normalizeBuildingKey(unit.req_building_code);
    const currentBuildingLv = buildingLevels[buildingKey] || 0;
    const requiredBuildingLv = Number(unit.req_building_level || 1);
    const friendlyBuildingName = unit.req_building_code.replace(/_/g, ' ');
    requirements.push({
      type: 'BUILDING',
      id: null,
      name: `${friendlyBuildingName} Lv ${requiredBuildingLv}`,
      requiredLevel: requiredBuildingLv,
      currentLevel: currentBuildingLv,
      met: currentBuildingLv >= requiredBuildingLv
    });
  }

  // 5. Matrix building requirements (the real Troops Matrix — Iron Mine,
  // Academy, Cottage, Farm, Sawmill, Beacon Tower, Trap Factory, Walls,
  // Forge, and any Barracks/Workshop/Stable rows beyond the dedicated
  // columns above).
  rows.filter(r => r.requires_building_id).forEach(r => {
    const currentLevel = r.requires_building_id === BARRACKS_BUILDING_TYPE_ID
      ? (barracksLevel || 0)
      : (buildingLevelsByType?.[r.requires_building_id] || 0);
    const name = buildingNamesByType?.[r.requires_building_id] || `Building #${r.requires_building_id}`;
    requirements.push({
      type: 'BUILDING',
      id: r.requires_building_id,
      name: `${name} Lv ${r.requires_building_level}`,
      requiredLevel: r.requires_building_level,
      currentLevel,
      met: currentLevel >= r.requires_building_level
    });
  });

  const passed = requirements.every(r => r.met);
  const firstUnmet = requirements.find(r => !r.met);

  return {
    passed,
    reason: firstUnmet ? `Req. ${firstUnmet.name}` : null,
    requirements
  };
}

/**
 * Fetch available units, current army, and facility specific barracks data
 */
async function getBarracksData(cityId, barracksId = null) {
  // Settle any recruitment orders whose timer has already elapsed before
  // reading anything, so owned counts and available population are current.
  await processCompletedRecruitment(cityId);

  // 0. Get city owner (playerId) & city resources for population check
  const cityRes = await pool.query(`SELECT owner_id FROM cities WHERE id = $1`, [cityId]);
  if (cityRes.rows.length === 0) throw new Error("City not found");
  const playerId = cityRes.rows[0].owner_id;

  // Levy Pool System: training gates off the refillable Levy Pool, not raw
  // Population directly. Resolve it fresh (same lazy-tick pattern as
  // resolveMorale) before reading. Response field is still named
  // availablePopulation for frontend compatibility — it now represents
  // available Levy, not raw population. Frontend label ("Idle Pop") is a
  // known follow-up to retitle.
  const cityResourcesRow = await cityService.resolveLevyPool(cityId);
  const currentLevyPool = Number(cityResourcesRow?.levy_pool || 0);
  const reservedLevy = await getReservedLevy(cityId);
  const availablePopulation = Math.max(0, currentLevyPool - reservedLevy);

  // 1. Get building levels for city — both the legacy normalized-name map
  // (buildingLevels, used by the dedicated-column checks) and the new
  // building_type_id-keyed map (buildingLevelsByType, used by the matrix
  // building rows). building_type_id is the max level of that type anywhere
  // in the city (correct for e.g. multiple Farms/Iron Mines as outer fields).
  const buildingRes = await pool.query(`
    SELECT cb.id AS building_id, cb.building_type_id, UPPER(bt.name) AS code, bt.name AS building_name, cb.level 
    FROM city_buildings cb
    JOIN building_types bt ON cb.building_type_id = bt.id
    WHERE cb.city_id = $1
  `, [cityId]);

  const buildingLevels = {};
  const buildingLevelsByType = {};
  const barracksList = [];

  buildingRes.rows.forEach(b => {
    const key = normalizeBuildingKey(b.code);
    if (!(key in buildingLevels) || b.level > buildingLevels[key]) {
      buildingLevels[key] = b.level;
    }
    if (!(b.building_type_id in buildingLevelsByType) || b.level > buildingLevelsByType[b.building_type_id]) {
      buildingLevelsByType[b.building_type_id] = b.level;
    }

    if (b.code === 'BARRACKS') {
      barracksList.push({ id: b.building_id, name: 'Barracks', level: b.level });
    }
  });

  if (barracksList.length === 0) {
    return {
      barracks: [],
      availablePopulation,
      trainableUnits: [],
      lockedUnits: [],
      units: [],
      queue: []
    };
  }

  // Resolve which specific facility we're showing.
  const selectedBarracks = barracksList.find(b => b.id == barracksId) || barracksList[0];
  const selectedBarracksLevel = selectedBarracks.level;

  // 2. Fetch unit types
 
  const unitsRes = await pool.query(`SELECT * FROM unit_types WHERE category = 'troop' AND is_npc_only = false AND code != 'LEVY' ORDER BY min_barracks_level ASC, id ASC`);
  // 3. Fetch active recruitment queue for THIS facility only
  const queueRes = await pool.query(`
    SELECT rq.*, ut.name, ut.code 
    FROM recruitment_queue rq
    JOIN unit_types ut ON rq.unit_type_id = ut.id
    WHERE rq.building_id = $1 AND rq.finish_at > NOW()
    ORDER BY rq.started_at ASC
  `, [selectedBarracks.id]);

  // 4. Fetch current city units
  const currentUnitsRes = await pool.query(`
    SELECT ut.code, cu.amount
    FROM city_units cu
    JOIN unit_types ut ON cu.unit_type_id = ut.id
    WHERE cu.city_id = $1
  `, [cityId]);

  const cityUnits = {};
  currentUnitsRes.rows.forEach(u => {
    cityUnits[u.code] = u.amount;
  });

  // 5. Process availability per unit
  const completedNodeSet = await getPlayerCompletedNodeSet(playerId);
  const requirementsByUnitId = await getUnitRequirements();
  const buildingNamesByType = await getBuildingNameMap();
  const researchNameMap = await getResearchNameMap();

  const trainableUnits = [];
  const lockedUnits = [];

  unitsRes.rows.forEach(unit => {
    const check = evaluatePrerequisites(
      unit,
      buildingLevels,
      completedNodeSet,
      requirementsByUnitId[unit.id],
      selectedBarracksLevel,
      buildingLevelsByType,
      buildingNamesByType,
      researchNameMap
    );
    const popCost = unit.population_cost || unit.pop_cost || 1;
    const maxTrainable = Math.floor(availablePopulation / popCost);

    const item = {
      ...unit,
      owned: cityUnits[unit.code] || 0,
      isAvailable: check.passed,
      canTrain: check.passed,
      reason: check.reason,
      requirements: check.requirements,
      maxTrainable
    };

    if (check.passed) {
      trainableUnits.push(item);
    } else {
      lockedUnits.push(item);
    }
  });

  return {
    barracks: barracksList,
    availablePopulation,
    trainableUnits,
    lockedUnits,
    units: [...trainableUnits, ...lockedUnits], // Merged for front-ends expecting data.units
    queue: queueRes.rows
  };
}

/**            troop unlocks must always be considered
Warrior	(blg) Barracks 1—(blg) Cottage 1 – (blg)Farm 1 = troop Warrior opened
Pikeman	(blg) Iron-mine 1 – (blg) Academy 1 (rec) troop 1 (footman) -- (rec) craftsmen 1-- (rec) general 1
Swordsmen	(blg)Iron mine 2- (blg)barracks 2-(rec)Ore production 1 – (rec)blacksmithing 1 – (rec)weapons 1—(rec)swordsmen = troop swordsmen opened
Scouts	(blg)Barracks 2-(blg)beacon tower 2 – (rec)academy 2-(rec) horse husbandry 1 (rec)1-speed 1-(rec)scouts = troop scout opened
Archer	(blg)Barracks 3 – (blg) sawmill 3 – (rec) troop 1 (archers) -- (rec) troop improvement 1-(rec) weapons 1-(rec) Bowery and Fletching 1 –(rec) general 2 = troop Archer opened
Long bowmen	(blg)Barracks 6 – (blg) sawmill 6 – (rec) troop 1 (archers) -- (rec) troop improvement 3-(rec) weapons 3-(rec) Bowery and Fletching 2 –(rec) general 5 = troop long bowmen opened
Cross bowmen	(blg)Barracks 8– (blg) sawmill 8– (rec) troop 1 (archers) -- (rec) troop improvement 4-(rec) weapons 4-(rec) Bowery and Fletching 3 –(rec) general 7 = troop crossbowmen opened
Light Calvary	(blg) Barracks 4 – (blg) stable 4 – (rec) horse husbandry 1-- (rec) general 4-(rec) weapons 2 –(rec) speed 2 = troop Light Calvary opened
Transporters	(blg) Work shop 5 – (blg) Stables 5 – (rec)horse husbandry 2 –(rec) armor 2 – (rec) Mechanisms 1 = troop Transporters opened
Cataphracts	(blg) Barracks 6 – (blg) Stables 6 – (blg) work shop 6 – (rec) speed 3 -- (rec) horse husbandry 3 -(rec) general 6 – (rec) farm production 6 = Troop Cataphract opened
Battering rams	(blg) Barracks 7 – (blg) sawmill 7 – (blg) workshop 7 – (rec) woodworking 3 – (rec) troop 4 (siege) – (rec)  Engineering 2 – (rec) Mechanisms 2 = Troop Battering ram opened
Catapults	(blg) Barracks 9 – (blg) sawmill 9 – (blg) workshop 9 – (rec) weapons 4 – (rec) troop 4 (siege) – (rec)  Engineering 3 – (rec) Mechanisms 3 = Troop Catapults opened
Barista	(blg) Barracks 10 – (blg) sawmill 10 – (blg) workshop 10 – (rec) weapons 4 – (rec) troop 4 (siege) – (rec)  Engineering 4 – (rec) Mechanisms 4 = Troop Balista opened

 */
async function startRecruitment(cityId, unitCode, quantity, barracksId = null) {
  if (!quantity || quantity <= 0) throw new Error("Invalid training quantity.");
  if (!barracksId) throw new Error("No Barracks facility selected.");

  const client = await pool.connect();
  try {
    await client.query('BEGIN');

    // 0. Get city owner (playerId) to inspect research levels
    const cityRes = await client.query(`SELECT owner_id FROM cities WHERE id = $1`, [cityId]);
    if (cityRes.rows.length === 0) throw new Error("City not found.");
    const playerId = cityRes.rows[0].owner_id;

    // 0b. Confirm facility & level
    const barracksRes = await client.query(`
      SELECT cb.level
      FROM city_buildings cb
      JOIN building_types bt ON cb.building_type_id = bt.id
      WHERE cb.id = $1 AND cb.city_id = $2 AND UPPER(bt.name) = 'BARRACKS'
    `, [barracksId, cityId]);
    if (barracksRes.rows.length === 0) {
      throw new Error("Selected Barracks facility not found in this city.");
    }
    const barracksLevel = barracksRes.rows[0].level;

    // 1. Get unit definition
    const unitRes = await client.query(`SELECT * FROM unit_types WHERE code = $1`, [unitCode]);
    if (unitRes.rows.length === 0) throw new Error("Unit type not found.");
    const unit = unitRes.rows[0];
    if (unit.is_npc_only) throw new Error(`${unit.name} cannot be trained by players.`);
    if (unit.code === 'LEVY') throw new Error(`Levy is a resource pool, not a trainable unit — see your Levy Pool on the City Stats panel.`);

    // 2. Get city resources & Levy Pool (Locked for update)
    const resResult = await client.query(`SELECT * FROM city_resources WHERE city_id = $1 FOR UPDATE`, [cityId]);
    if (resResult.rows.length === 0) throw new Error("City resources not found.");
    const resources = resResult.rows[0];

    // Read levy_pool directly off the already-locked row rather than calling
    // cityService.resolveLevyPool() here — that function uses the raw pool
    // internally, and calling it against a row this transaction already
    // holds FOR UPDATE risks the same self-deadlock pattern fixed in
    // valley.service.js's resolvePendingRecall. getBarracksData() already
    // resolves it fresh right before the player ever sees the Train button,
    // so staleness here is at most a few seconds.
    const currentLevyPool = Number(resources.levy_pool || 0);
    const reservedLevy = await getReservedLevy(cityId, client);
    const availablePopulation = Math.max(0, currentLevyPool - reservedLevy);

    const unitPopCost = unit.population_cost || unit.pop_cost || 1;
    const totalPopRequired = unitPopCost * quantity;

    if (totalPopRequired > availablePopulation) {
      const maxPossible = Math.floor(availablePopulation / unitPopCost);
      throw new Error(`Insufficient population! Required: ${totalPopRequired}, Available: ${availablePopulation}. Max trainable: ${maxPossible}`);
    }

    // 3. Validate Building & Research Prerequisites
    const buildingRes = await client.query(`
      SELECT cb.building_type_id, UPPER(bt.name) AS code, bt.name AS building_name, cb.level 
      FROM city_buildings cb
      JOIN building_types bt ON cb.building_type_id = bt.id
      WHERE cb.city_id = $1
    `, [cityId]);

    const buildingLevels = {};
    const buildingLevelsByType = {};
    buildingRes.rows.forEach(b => {
      const key = normalizeBuildingKey(b.code);
      if (!(key in buildingLevels) || b.level > buildingLevels[key]) {
        buildingLevels[key] = b.level;
      }
      if (!(b.building_type_id in buildingLevelsByType) || b.level > buildingLevelsByType[b.building_type_id]) {
        buildingLevelsByType[b.building_type_id] = b.level;
      }
    });

    const completedNodeSet = await getPlayerCompletedNodeSet(playerId, client);
    const requirementsByUnitId = await getUnitRequirements(client);
    const buildingNamesByType = await getBuildingNameMap(client);
    const researchNameMap = await getResearchNameMap(client);

    const check = evaluatePrerequisites(
      unit,
      buildingLevels,
      completedNodeSet,
      requirementsByUnitId[unit.id],
      barracksLevel,
      buildingLevelsByType,
      buildingNamesByType,
      researchNameMap
    );

    if (!check.passed) {
      throw new Error(check.reason);
    }

    // 4. Calculate Total Resource Costs & Verify
    const totalFood = (unit.food_cost || 0) * quantity;
    const totalWood = (unit.wood_cost || 0) * quantity;
    const totalStone = (unit.stone_cost || 0) * quantity;
    const totalIron = (unit.iron_cost || 0) * quantity;
    const totalGold = (unit.gold_cost || 0) * quantity;

    if (resources.food < totalFood || resources.wood < totalWood || 
        resources.stone < totalStone || resources.iron < totalIron || 
        resources.gold < totalGold) {
      throw new Error("Insufficient resources to train this quantity.");
    }

    // 5. Deduct Resources
    await client.query(`
      UPDATE city_resources 
      SET food = food - $1, 
          wood = wood - $2, 
          stone = stone - $3, 
          iron = iron - $4, 
          gold = gold - $5,
          updated_at = NOW()
      WHERE city_id = $6
    `, [totalFood, totalWood, totalStone, totalIron, totalGold, cityId]);

    // 6. Calculate Finish Time & Insert into Recruitment Queue
    const totalSeconds = (unit.base_training_seconds || unit.base_training_time || 10) * quantity;

    const lastInQueue = await client.query(`
      SELECT finish_at FROM recruitment_queue 
      WHERE building_id = $1 AND finish_at > NOW() 
      ORDER BY finish_at DESC LIMIT 1
    `, [barracksId]);

    const startTime = lastInQueue.rows.length > 0 ? new Date(lastInQueue.rows[0].finish_at) : new Date();
    const finishTime = new Date(startTime.getTime() + (totalSeconds * 1000));

    await client.query(`
      INSERT INTO recruitment_queue (city_id, building_id, unit_type_id, quantity, started_at, finish_at)
      VALUES ($1, $2, $3, $4, $5, $6)
    `, [cityId, barracksId, unit.id, quantity, startTime, finishTime]);

    await client.query('COMMIT');
    return { success: true, finishTime };

  } catch (err) {
    await client.query('ROLLBACK');
    throw err;
  } finally {
    client.release();
  }
}

/**
 * Aggregates standing forces in city vs assigned troops deployed in valleys
 */
async function getArmyOverview(cityId) {
  await processCompletedRecruitment(cityId);

  // 1. Fetch units in city
  const cityUnitsRes = await pool.query(`
    SELECT ut.code, ut.name, COALESCE(cu.amount, 0) AS in_city
    FROM unit_types ut
    LEFT JOIN city_units cu ON ut.id = cu.unit_type_id AND cu.city_id = $1
    WHERE ut.is_npc_only = false AND UPPER(ut.code) != 'LEVY'
    ORDER BY ut.id ASC
  `, [cityId]);

  // 2. Fetch deployed units in world_valleys (COALESCE handles empty sums)
  const fieldRes = await pool.query(`
    SELECT 
      COALESCE(SUM(warrior), 0) AS warrior, 
      COALESCE(SUM(pikeman), 0) AS pikeman, 
      COALESCE(SUM(swordsman), 0) AS swordsman,
      COALESCE(SUM(archer), 0) AS archer, 
      COALESCE(SUM(cavalry), 0) AS cavalry, 
      COALESCE(SUM(cataphract), 0) AS cataphract,
      COALESCE(SUM(ballista), 0) AS ballista, 
      COALESCE(SUM(battering_ram), 0) AS battering_ram,
      COALESCE(SUM(catapult), 0) AS catapult, 
      COALESCE(SUM(scout), 0) AS scout, 
      COALESCE(SUM(transporter), 0) AS transporter
    FROM world_valleys
    WHERE owner_city_id = $1 AND (recall_at IS NULL OR recall_at > NOW())
  `, [cityId]);

  const fieldTotals = fieldRes.rows[0] || {};

  // 3. Normalize unit code keys to lowercase to match SQL column names
  return cityUnitsRes.rows.map(unit => {
    const codeKey = (unit.code || '').toLowerCase();
    const fieldCount = Number(fieldTotals[codeKey] || 0);
    const inCityCount = Number(unit.in_city || 0);

    return {
      code: unit.code,
      name: unit.name,
      inCity: inCityCount,
      inField: fieldCount,
      total: inCityCount + fieldCount
    };
  });
}

module.exports = { 
  getBarracksData, 
  startRecruitment, 
  processCompletedRecruitment, 
  getReservedLevy,
  evaluatePrerequisites,
  getArmyOverview,
  getUnitRequirements,
  getPlayerCompletedNodeSet,
  getBuildingNameMap,
  getResearchNameMap,
  normalizeBuildingKey,
  BARRACKS_BUILDING_TYPE_ID
};
