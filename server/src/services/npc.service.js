// ============================================================================
// FILE: src/services/npc.service.js
// NPC CITY SERVICE
// Source: GDS Vol 2 — World System, Solution 3 (NPC City System — Complete
// Tables), cross-referenced Evony Wiki / iGaming Age.
//
// NPCs are static: a Level N NPC always has the exact same baseline troop
// count, fortifications, resources, and wall level (= N). They never grow.
// What changes over time is only how DEPLETED they currently are relative
// to that fixed baseline, after being farmed/attacked — that's what
// npc_cities (the DB table) tracks. This file holds the baseline itself.
// ============================================================================

const pool = require("../database/db");
const plunderService = require("./plunder.service");
const heroXpService = require("./heroXp.service");
const hospitalService = require("./hospital.service");

// Troop compositions by level: Warrior, Pikeman, Swordsman, Archer, Cavalry
// Level 10 is Warriors only — no other troop types (per doc).
const NPC_TROOPS_BY_LEVEL = {
  1:  { warrior: 50,     pikeman: 40,    swordsman: 35,   archer: 15,   cavalry: 8 },
  2:  { warrior: 50,     pikeman: 45,    swordsman: 40,   archer: 30,   cavalry: 25 },
  3:  { warrior: 200,    pikeman: 160,   swordsman: 65,   archer: 40,   cavalry: 60 },
  4:  { warrior: 400,    pikeman: 400,   swordsman: 100,  archer: 100,  cavalry: 150 },
  5:  { warrior: 750,    pikeman: 1000,  swordsman: 350,  archer: 250,  cavalry: 200 },
  6:  { warrior: 4000,   pikeman: 750,   swordsman: 550,  archer: 500,  cavalry: 450 },
  7:  { warrior: 12000,  pikeman: 3000,  swordsman: 750,  archer: 800,  cavalry: 750 },
  8:  { warrior: 15000,  pikeman: 6750,  swordsman: 4000, archer: 3000, cavalry: 2000 },
  9:  { warrior: 60000,  pikeman: 18000, swordsman: 2000, archer: 6750, cavalry: 2500 },
  10: { warrior: 400000, pikeman: 0,     swordsman: 0,    archer: 0,    cavalry: 0 }
};

// Fortifications by level: Traps, Abatis, Archer Towers, Rolling Logs, Defensive Trebuchets
// Levels 1-5 have zero Defensive Trebuchets — zero-loss farming is possible
// there. Level 6+ always inflicts casualties.
const NPC_FORTIFICATIONS_BY_LEVEL = {
  1:  { traps: 1000,  abatis: 0,    archer_tower: 0,    rolling_log: 0,    defensive_trebuchet: 0 },
  2:  { traps: 1850,  abatis: 550,  archer_tower: 0,    rolling_log: 0,    defensive_trebuchet: 0 },
  3:  { traps: 2000,  abatis: 1000, archer_tower: 650,  rolling_log: 0,    defensive_trebuchet: 0 },
  4:  { traps: 4500,  abatis: 1875, archer_tower: 550,  rolling_log: 0,    defensive_trebuchet: 0 },
  5:  { traps: 3750,  abatis: 1875, archer_tower: 1250, rolling_log: 750,  defensive_trebuchet: 0 },
  6:  { traps: 4250,  abatis: 1500, archer_tower: 1500, rolling_log: 950,  defensive_trebuchet: 400 },
  7:  { traps: 5600,  abatis: 2800, archer_tower: 1850, rolling_log: 1100, defensive_trebuchet: 700 },
  8:  { traps: 7200,  abatis: 3600, archer_tower: 2400, rolling_log: 1440, defensive_trebuchet: 900 },
  9:  { traps: 9000,  abatis: 4500, archer_tower: 3000, rolling_log: 1800, defensive_trebuchet: 1150 },
  10: { traps: 11000, abatis: 5500, archer_tower: 3666, rolling_log: 2200, defensive_trebuchet: 1375 }
};

// Resources by level: Food, Lumber, Stone, Iron, Gold.
// NPCs have no Warehouse — the entire listed amount is plunderable.
const NPC_RESOURCES_BY_LEVEL = {
  1:  { food: 100000,   lumber: 20000,  stone: 20000,  iron: 20000,  gold: 55000 },
  2:  { food: 200000,   lumber: 30000,  stone: 30000,  iron: 30000,  gold: 65000 },
  3:  { food: 900000,   lumber: 75000,  stone: 75000,  iron: 75000,  gold: 75000 },
  4:  { food: 1600000,  lumber: 120000, stone: 120000, iron: 120000, gold: 300000 },
  5:  { food: 3000000,  lumber: 180000, stone: 180000, iron: 180000, gold: 450000 },
  6:  { food: 4000000,  lumber: 200000, stone: 200000, iron: 200000, gold: 600000 },
  7:  { food: 4500000,  lumber: 500000, stone: 500000, iron: 500000, gold: 800000 },
  8:  { food: 8000000,  lumber: 800000, stone: 800000, iron: 800000, gold: 1000000 },
  9:  { food: 14000000, lumber: 550000, stone: 550000, iron: 550000, gold: 1200000 },
  10: { food: 19000000, lumber: 600000, stone: 600000, iron: 600000, gold: 1500000 }
};

// Regen timers (per doc)
const TROOP_FORT_REGEN_PCT_PER_TICK = 0.10;   // 10% per 6-minute tick -> full in 1 hour
const RESOURCE_REGEN_HOURS = 8;               // full regen in 8 hours
const LOYALTY_REGEN_PER_TICK = 3;             // +3 per 6-minute tick
const TICK_MINUTES = 6;
const STARTING_LOYALTY = 90;                  // doc: "starts ~90"

function getNpcBaseline(level) {
  const troops = NPC_TROOPS_BY_LEVEL[level];
  const fortifications = NPC_FORTIFICATIONS_BY_LEVEL[level];
  const resources = NPC_RESOURCES_BY_LEVEL[level];
  if (!troops || !fortifications || !resources) {
    throw new Error(`Invalid NPC level: ${level}. Must be 1-10.`);
  }
  return { troops, fortifications, resources, wallLevel: level };
}

/**
 * Create npc_cities rows, at full baseline strength, for every existing
 * map_tiles row with tile_type = 'NPC' that doesn't already have one.
 * Idempotent — safe to run again after generating more map tiles later.
 */
async function seedNpcCitiesFromMap() {
  const tilesResult = await pool.query(`
    SELECT mt.x, mt.y, mt.npc_level
    FROM map_tiles mt
    LEFT JOIN npc_cities nc ON nc.x = mt.x AND nc.y = mt.y
    WHERE mt.tile_type = 'NPC' AND nc.id IS NULL
  `);

  let created = 0;
  for (const tile of tilesResult.rows) {
    const level = tile.npc_level || 1;
    const baseline = getNpcBaseline(level);

    await pool.query(`
      INSERT INTO npc_cities (
        x, y, level,
        warrior, pikeman, swordsman, archer, cavalry,
        traps, abatis, archer_tower, rolling_log, defensive_trebuchet,
        food, lumber, stone, iron, gold,
        wall_level, loyalty
      ) VALUES (
        $1, $2, $3,
        $4, $5, $6, $7, $8,
        $9, $10, $11, $12, $13,
        $14, $15, $16, $17, $18,
        $19, $20
      )
      ON CONFLICT (x, y) DO NOTHING
    `, [
      tile.x, tile.y, level,
      baseline.troops.warrior, baseline.troops.pikeman, baseline.troops.swordsman, baseline.troops.archer, baseline.troops.cavalry,
      baseline.fortifications.traps, baseline.fortifications.abatis, baseline.fortifications.archer_tower, baseline.fortifications.rolling_log, baseline.fortifications.defensive_trebuchet,
      baseline.resources.food, baseline.resources.lumber, baseline.resources.stone, baseline.resources.iron, baseline.resources.gold,
      level, STARTING_LOYALTY
    ]);
    created++;
  }

  return { npcCitiesCreated: created };
}

async function getNpcCity(x, y) {
  const result = await pool.query(`SELECT * FROM npc_cities WHERE x = $1 AND y = $2`, [x, y]);
  if (result.rows.length === 0) {
    throw new Error(`No NPC city at (${x}, ${y}).`);
  }
  return result.rows[0];
}

/**
 * Applies elapsed regen ticks to a single NPC: troops/fortifications climb
 * 10%/6-min tick back toward baseline, resources refill linearly over 8
 * hours back toward baseline, loyalty climbs +3/tick toward 100. Called
 * lazily whenever an NPC is read/attacked rather than on a global
 * scheduler — the scheduler itself is part of the later server-tick phase.
 */
async function applyNpcRegen(npc, db = pool) {
  const baseline = getNpcBaseline(npc.level);
  const now = new Date();
  const last = new Date(npc.last_regen_tick_at);
  const minutesElapsed = Math.max(0, (now - last) / 60000);
  const ticksElapsed = Math.floor(minutesElapsed / TICK_MINUTES);

  if (ticksElapsed <= 0) return npc;

  const regenField = (current, max) => {
    if (current >= max) return max;
    const perTick = max * TROOP_FORT_REGEN_PCT_PER_TICK;
    return Math.min(max, Math.round(current + perTick * ticksElapsed));
  };

  const hoursElapsed = minutesElapsed / 60;
  const regenResource = (current, max) => {
    if (current >= max) return max;
    const perHour = max / RESOURCE_REGEN_HOURS;
    return Math.min(max, Math.round(current + perHour * hoursElapsed));
  };

  const updated = {
    warrior: regenField(npc.warrior, baseline.troops.warrior),
    pikeman: regenField(npc.pikeman, baseline.troops.pikeman),
    swordsman: regenField(npc.swordsman, baseline.troops.swordsman),
    archer: regenField(npc.archer, baseline.troops.archer),
    cavalry: regenField(npc.cavalry, baseline.troops.cavalry),
    traps: regenField(npc.traps, baseline.fortifications.traps),
    abatis: regenField(npc.abatis, baseline.fortifications.abatis),
    archer_tower: regenField(npc.archer_tower, baseline.fortifications.archer_tower),
    rolling_log: regenField(npc.rolling_log, baseline.fortifications.rolling_log),
    defensive_trebuchet: regenField(npc.defensive_trebuchet, baseline.fortifications.defensive_trebuchet),
    food: regenResource(Number(npc.food), baseline.resources.food),
    lumber: regenResource(Number(npc.lumber), baseline.resources.lumber),
    stone: regenResource(Number(npc.stone), baseline.resources.stone),
    iron: regenResource(Number(npc.iron), baseline.resources.iron),
    gold: regenResource(Number(npc.gold), baseline.resources.gold),
    loyalty: Math.min(100, npc.loyalty + LOYALTY_REGEN_PER_TICK * ticksElapsed)
  };

  const result = await db.query(`
    UPDATE npc_cities
    SET warrior = $1, pikeman = $2, swordsman = $3, archer = $4, cavalry = $5,
        traps = $6, abatis = $7, archer_tower = $8, rolling_log = $9, defensive_trebuchet = $10,
        food = $11, lumber = $12, stone = $13, iron = $14, gold = $15,
        loyalty = $16, last_regen_tick_at = NOW()
    WHERE id = $17
    RETURNING *
  `, [
    updated.warrior, updated.pikeman, updated.swordsman, updated.archer, updated.cavalry,
    updated.traps, updated.abatis, updated.archer_tower, updated.rolling_log, updated.defensive_trebuchet,
    updated.food, updated.lumber, updated.stone, updated.iron, updated.gold,
    updated.loyalty, npc.id
  ]);

  return result.rows[0];
}

async function getNpcCityWithRegen(x, y) {
  const npc = await getNpcCity(x, y);
  return applyNpcRegen(npc);
}

function getValleyNpcDefenders(level) {
  const lvl = Math.max(1, Math.min(10, parseInt(level, 10) || 1));
  return {
    warrior: lvl * 100,
    pikeman: lvl * 50,
    archer: lvl * 25,
    cavalry: lvl * 10,
    swordsman: 0 // Optional: explicit 0 for uniform troop objects
  };
}

// Same roster split used in valley.service.js: the full player-mobile
// roster can attack; NPC garrisons only ever use the 5 classic troop
// types (matching npc_cities' actual columns).
const ATTACKER_UNIT_CODES = [
  "pikeman", "swordsman", "archer", "cavalry", "cataphract",
  "ballista", "battering_ram", "catapult", "scout", "transporter"
];
const GARRISON_CODES = ["warrior", "pikeman", "swordsman", "archer", "cavalry"];
const ALL_LOOKUP_CODES = [...new Set([...ATTACKER_UNIT_CODES, ...GARRISON_CODES])];

// Fortification defense contribution — only Archer Tower/Rolling
// Log/Defensive Trebuchet have confirmed attack values (GDS Vol 2,
// Solution 6). Traps and Abatis are deliberately excluded: their attack
// value is marked "n.a." (unconfirmed) in that same source, and guessing
// a number here would be inventing balance data, not implementing it.
const FORTIFICATION_DEFENSE_VALUE = {
  archer_tower: 300,
  rolling_log: 500,
  defensive_trebuchet: 800
};

const NPC_LOYALTY_LOSS_PER_ATTACK = 5;  // placeholder — no confirmed formula
const NPC_LOYALTY_FLOOR = 5;            // GDS: "Gates open at loyalty 5" — full
                                         // conquest below this isn't implemented yet

/**
 * Attack an NPC city. Simplified flat power-sum combat (same tier as
 * valley.service.js's placeholder, NOT the full GDS round-based formula —
 * that's a separate, larger piece of work). On win: partial loyalty
 * reduction (floored at 5) and a flat percentage plunder of current NPC
 * resources. Full conquest (loyalty to 0, ownership transfer) is
 * explicitly NOT implemented — this only ever weakens/plunders an NPC.
 */
async function attackNpcCity(cityId, x, y, sentTroops, heroId = null) {
  const client = await pool.connect();
  try {
    await client.query("BEGIN");

    const npcRes = await client.query(`SELECT * FROM npc_cities WHERE x = $1 AND y = $2 FOR UPDATE`, [x, y]);
    if (npcRes.rows.length === 0) throw new Error(`No NPC city at (${x}, ${y}).`);
    const npc = await applyNpcRegen(npcRes.rows[0], client);

    // Optional hero assignment — leading the attack, eligible for Combat
    // XP on a win. Validated and locked now so a bad heroId fails before
    // any troops are spent.
    let hero = null;
    if (heroId) {
      hero = await heroXpService.lockAndValidateHero(heroId, cityId, client);
    }

    const totalSent = ATTACKER_UNIT_CODES.reduce((sum, code) => sum + Number(sentTroops[code] || 0), 0);
    if (totalSent <= 0) throw new Error("You must send at least one troop.");

    const unitTypesRes = await client.query(
      `SELECT id, code, attack, defense, base_hp, load_capacity FROM unit_types WHERE UPPER(code) = ANY($1)`,
      [ALL_LOOKUP_CODES.map(c => c.toUpperCase())]
    );
    const unitTypeByCode = {};
    unitTypesRes.rows.forEach(u => { unitTypeByCode[u.code.toLowerCase()] = u; });

    for (const code of ATTACKER_UNIT_CODES) {
      const qty = Number(sentTroops[code] || 0);
      if (qty <= 0) continue;
      const ut = unitTypeByCode[code];
      if (!ut) throw new Error(`Unknown unit type: ${code}`);

      const ownedRes = await client.query(`
        SELECT cu.amount FROM city_units cu WHERE cu.city_id = $1 AND cu.unit_type_id = $2
      `, [cityId, ut.id]);
      const owned = ownedRes.rows[0]?.amount || 0;
      if (owned < qty) {
        throw new Error(`Not enough ${code} — have ${owned}, tried to send ${qty}.`);
      }
    }

    for (const code of ATTACKER_UNIT_CODES) {
      const qty = Number(sentTroops[code] || 0);
      if (qty <= 0) continue;
      const ut = unitTypeByCode[code];
      await client.query(`
        UPDATE city_units SET amount = amount - $1 WHERE city_id = $2 AND unit_type_id = $3
      `, [qty, cityId, ut.id]);
    }

    // Resolve combat.
    let attackerPower = 0, defenderPower = 0, avgAttackerHp = 0, hpSamples = 0;
    ATTACKER_UNIT_CODES.forEach(code => {
      const ut = unitTypeByCode[code];
      const sentQty = Number(sentTroops[code] || 0);
      attackerPower += sentQty * Number(ut?.attack || 0);
      if (sentQty > 0) {
        avgAttackerHp += Number(ut?.base_hp || 1) * sentQty;
        hpSamples += sentQty;
      }
    });
    GARRISON_CODES.forEach(code => {
      const ut = unitTypeByCode[code];
      const defQty = Number(npc[code] || 0);
      defenderPower += defQty * Number(ut?.defense || 0);
    });
    Object.entries(FORTIFICATION_DEFENSE_VALUE).forEach(([fortCode, value]) => {
      defenderPower += Number(npc[fortCode] || 0) * value;
    });
    const avgHp = hpSamples > 0 ? avgAttackerHp / hpSamples : 1;

    const attackerWins = attackerPower > defenderPower;
    const attackerLosses = Math.min(totalSent, Math.floor(defenderPower / Math.max(1, avgHp)));
    const survivingByCode = {};
    ATTACKER_UNIT_CODES.forEach(code => {
      const sentQty = Number(sentTroops[code] || 0);
      const lossShare = totalSent > 0 ? attackerLosses * (sentQty / totalSent) : 0;
      survivingByCode[code] = Math.max(0, Math.round(sentQty - lossShare));
    });

    // BUGFIX: survivingByCode was previously only used for the API response
    // — troops sent were deducted on the way out and never credited back,
    // regardless of outcome, contradicting the comment below and the
    // "Victory!" messaging (every attack cost the ENTIRE sent force, win
    // or lose). Surviving troops actually return home now, same no-march-
    // delay simplification as everywhere else in this codebase (instant,
    // not timed).
    for (const code of ATTACKER_UNIT_CODES) {
      const surviving = survivingByCode[code];
      if (surviving <= 0) continue;
      const ut = unitTypeByCode[code];
      await client.query(`
        INSERT INTO city_units (city_id, unit_type_id, amount)
        VALUES ($1, $2, $3)
        ON CONFLICT (city_id, unit_type_id)
        DO UPDATE SET amount = city_units.amount + EXCLUDED.amount
      `, [cityId, ut.id, surviving]);
    }

    // Hospital system: ALL of the troops that didn't survive an NPC fight
    // are wounded (queued for hospital recovery), not just a research-gated
    // percentage — same 100%-recoverable rule as Valley/resource-field
    // combat (see valley.service.js's queueValleyWounded). CASUALTY_SAVE_RATE
    // only applies to PvP city sieges, per design direction — NPC combat
    // doesn't use it at all.
    for (const code of ATTACKER_UNIT_CODES) {
      const sentQty = Number(sentTroops[code] || 0);
      if (sentQty <= 0) continue;
      const lost = sentQty - survivingByCode[code];
      if (lost <= 0) continue;
      const ut = unitTypeByCode[code];
      await hospitalService.queueWounded(cityId, ut.id, lost, 'NPC');
    }
    // An empty/low-occupancy hospital shouldn't force new wounded to sit in
    // the grace queue unnecessarily — resolve immediately so admission
    // happens the moment capacity allows, same lazy-resolve pattern used
    // elsewhere (resolveCompletedResearch, resolveLevyPool).
    await hospitalService.resolveHospitalQueue(cityId);

    let plunder = null;
    let newLoyalty = npc.loyalty;
    let result;
    let carryInfo = null;
    let heroXpResult = null;

    if (attackerWins) {
      newLoyalty = Math.max(NPC_LOYALTY_FLOOR, npc.loyalty - NPC_LOYALTY_LOSS_PER_ATTACK);

      const stockpile = { food: npc.food, lumber: npc.lumber, stone: npc.stone, iron: npc.iron, gold: npc.gold };
      const plunderResult = plunderService.calculatePlunder(stockpile, survivingByCode, unitTypeByCode);
      plunder = plunderResult.plunder;
      carryInfo = {
        totalCarryCapacity: plunderResult.totalCarryCapacity,
        totalAvailable: plunderResult.totalAvailable,
        cappedByCapacity: plunderResult.cappedByCapacity
      };

      const depositResult = await client.query(`
        UPDATE city_resources
        SET food = food + $1, wood = wood + $2, stone = stone + $3, iron = iron + $4, gold = gold + $5,
            updated_at = NOW()
        WHERE city_id = $6
      `, [plunder.food, plunder.lumber, plunder.stone, plunder.iron, plunder.gold, cityId]);

      // BUGFIX: this UPDATE was silently succeeding with 0 rows affected if
      // city_id didn't match any city_resources row — Postgres doesn't
      // error on a no-op UPDATE, so the attack reported victory/plunder
      // normally while the resources never actually landed anywhere. Now
      // fails loudly instead, so a real mismatch surfaces immediately
      // rather than looking like a working attack that just... doesn't
      // update the dashboard.
      if (depositResult.rowCount === 0) {
        throw new Error(`Plunder deposit failed: no city_resources row found for city_id ${cityId}.`);
      }

      // NPC's garrison and fortifications also take proportional losses on
      // a loss for them, same symmetric-loss convention as valley.service.js.
      const defenderLosses = Math.min(1, defenderPower > 0 ? attackerPower / defenderPower - 1 : 1);
      const lossRatio = Math.max(0, Math.min(1, defenderLosses));
      const newGarrison = {};
      GARRISON_CODES.forEach(code => {
        newGarrison[code] = Math.max(0, Math.round(Number(npc[code] || 0) * (1 - lossRatio)));
      });
      const newForts = {};
      Object.keys(FORTIFICATION_DEFENSE_VALUE).forEach(code => {
        newForts[code] = Math.max(0, Math.round(Number(npc[code] || 0) * (1 - lossRatio)));
      });

      // Combat XP — killed = pre-fight garrison/fortification counts minus
      // what's left, using the exact deltas already computed above.
      if (hero) {
        const killedByCode = {};
        GARRISON_CODES.forEach(code => {
          killedByCode[code] = Number(npc[code] || 0) - newGarrison[code];
        });
        Object.keys(FORTIFICATION_DEFENSE_VALUE).forEach(code => {
          killedByCode[code] = Number(npc[code] || 0) - newForts[code];
        });
        const combatXp = heroXpService.calculateCombatXp(killedByCode);
        if (combatXp > 0) {
          heroXpResult = await heroXpService.awardCombatXp(hero, combatXp, client);
        }
      }

      // NPC stockpile is debited by what was actually CARRIED, not the full
      // 10%-available figure — anything the force couldn't carry is left
      // behind at the NPC, not destroyed. This is the actual behavior change
      // from the old flat-plunder version.
      result = await client.query(`
        UPDATE npc_cities
        SET warrior = $1, pikeman = $2, swordsman = $3, archer = $4, cavalry = $5,
            archer_tower = $6, rolling_log = $7, defensive_trebuchet = $8,
            food = food - $9, lumber = lumber - $10, stone = stone - $11, iron = iron - $12, gold = gold - $13,
            loyalty = $14
        WHERE id = $15
        RETURNING *
      `, [
        newGarrison.warrior, newGarrison.pikeman, newGarrison.swordsman, newGarrison.archer, newGarrison.cavalry,
        newForts.archer_tower, newForts.rolling_log, newForts.defensive_trebuchet,
        plunder.food, plunder.lumber, plunder.stone, plunder.iron, plunder.gold,
        newLoyalty, npc.id
      ]);
    } else {
      // Defeat — no plunder, no loyalty change, NPC garrison untouched.
      // Attacker still takes losses (already deducted above via city_units).
      result = { rows: [npc] };
    }

    await client.query("COMMIT");
    return {
      won: attackerWins,
      npc: result.rows[0],
      attackerLosses,
      survivingByCode,
      plunder,
      carryInfo,
      heroXp: heroXpResult
    };

  } catch (err) {
    await client.query("ROLLBACK");
    throw err;
  } finally {
    client.release();
  }
}

// ... bottom of src/services/npc.service.js ...
module.exports = {
  NPC_TROOPS_BY_LEVEL,
  NPC_FORTIFICATIONS_BY_LEVEL,
  NPC_RESOURCES_BY_LEVEL,
  getNpcBaseline,
  seedNpcCitiesFromMap,
  getNpcCity,
  getNpcCityWithRegen,
  applyNpcRegen,
  getValleyNpcDefenders, // Export it here!
  attackNpcCity
};
