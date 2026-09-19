Volume XVI — Scouting, Intelligence & Beacon Tower Engine
1. Core Scouting Mechanics & Rules
Informatics & Beacon Tower Requirement

Intelligence depth is determined by:

    Attacker’s Informatics Level

    Defender’s Informatics Level

    Defender’s Beacon Tower Level (for incoming march detection)

Scout Battle Triggering

Scout vs. Scout combat occurs only when:

    Defender has Scouts present, AND

    City Gates are OPEN,

    OR the target is an NPC/Valley

Information Tier Gating

A scout report never yields partial unit data.

It either reveals a full tier or returns Unknown, based on:
ΔInformatics=InformaticsAttacker−InformaticsDefender
2. Intelligence Visibility Tier Matrix

The depth of information revealed scales with ΔInformatics.
Tier	Required Δ Informatics	Information Unlocked
Tier 0	≤ -3	Mission failed; scouts intercepted or turned back
Tier 1	-2	Basic target resources (Food, Lumber, Stone, Iron, Gold)
Tier 2	-1	Exact resource counts + approximate troop estimates (“Thousands”)
Tier 3	0	Exact troop counts
Tier 4	+1	Exact wall fortification counts
Tier 5	+2	City building levels
Tier 6	+3	Detailed hero stats
Tier 7	+4	Complete player tech levels
Tier 8	+5	Valleys owned by the target
Tier 9	+6+	Reinforcements + incoming/outgoing march details
3. Scout Combat & Interception Engine Logic

When a scout march arrives, the server checks for scout combat before generating the report.
Server Logic
python

function processScoutArrival(attackerMarch, targetCity):
    # 1. Gates closed or no scouts = free intelligence gathering
    if not targetCity.gatesOpen or getUnitCount(targetCity, "Scout") == 0:
        return generateScoutReport(attackerMarch, targetCity, casualties = 0)

    # 2. Execute Scout vs. Scout Combat Loop
    combatResult = resolveScoutCombat(
        attackerScouts = attackerMarch.units["Scout"],
        attackerHero = attackerMarch.hero,
        attackerTech = attackerMarch.player.tech,
        defenderScouts = getUnitCount(targetCity, "Scout"),
        defenderHero = getMayorHero(targetCity),
        defenderTech = targetCity.player.tech
    )

    # 3. Update Defender Scout Troop Count
    setUnitCount(targetCity, "Scout", combatResult.survivingDefenderScouts)

    # 4. Determine Scouting Outcome
    if combatResult.survivingAttackerScouts > 0:
        attackerMarch.units["Scout"] = combatResult.survivingAttackerScouts
        
        notifyDefender(targetCity, "SCOUT_ATTEMPT_DETECTED", combatResult)

        return generateScoutReport(attackerMarch, targetCity, casualties = combatResult.attackerLosses)
    else:
        notifyDefender(targetCity, "SCOUT_REPELLED", combatResult)
        
        return createFailedScoutReport(attackerMarch)

Scout Combat Formula
AttackerPower=Natk_scouts⋅BaseAttackScout⋅(1+0.10⋅TechMilSci+0.01⋅HeroAtk)
DefenderPower=Ndef_scouts⋅BaseAttackScout⋅(1+0.10⋅TechMilSci+0.01⋅HeroAtk)
LossesAttacker=min⁡(Natk_scouts,⌊DefenderPowerBaseHPScout⌋)
LossesDefender=min⁡(Ndef_scouts,⌊AttackerPowerBaseHPScout⌋)
4. Beacon Tower Early Warning System

The Beacon Tower provides early detection of incoming marches.
Beacon Tower Level Unlocks
Beacon Level	Early Warning Capability
1	Alert when an enemy march is launched
2	Shows target destination (city/valley)
3	Shows ETA
4	Shows enemy player name + origin coordinates
5	Shows mission type (Attack, Scout, Transport, Reinforce)
6	Shows estimated troop count range
7	Shows exact total troop count
8	Shows troop type breakdown
9	Shows enemy hero details
10	Shows enemy tech levels + buff modifiers
5. Scout Report JSON Data Schema

(Volume XII Integration)

This is the dynamic payload returned by the server.
json

{
  "report_id": "rpt_scout_994821",
  "timestamp": 1784996701,
  "attacker": {
    "player_id": "p_104",
    "city_id": "c_501",
    "scouts_sent": 5000,
    "scouts_lost": 120
  },
  "target": {
    "player_name": "LordVapor",
    "city_name": "Ironhold",
    "coords": { "x": 245, "y": 182 }
  },
  "intelligence_tier": 6,
  "payload": {
    "resources": {
      "food": 14500000,
      "lumber": 8200000,
      "stone": 3100000,
      "iron": 6400000,
      "gold": 1200000
    },
    "units": {
      "Worker": 1000,
      "Warrior": 25000,
      "Scout": 0,
      "Pikeman": 12000,
      "Swordsman": 8000,
      "Archer": 45000,
      "Cavalry": 2000,
      "Ballista": 1500
    },
    "fortifications": {
      "Trap": 2000,
      "Abatis": 1000,
      "Archer Tower": 4500,
      "Rolling Log": 200
    },
    "buildings": {
      "Town Hall": 9,
      "Walls": 9,
      "Barracks": 12,
      "Rally Spot": 8
    },
    "hero": {
      "name": "Agamemnon",
      "level": 45,
      "politics": 22,
      "attack": 118,
      "intelligence": 35
    },
    "tech": null,
    "valleys": null
  }
}


