// ============================================================================
// FILE: src/services/valley.service.js
// WORLD VALLEY SERVICE
// ============================================================================

const pool = require("../database/db");
const npcService = require("./npc.service");
const heroXpService = require("./heroXp.service");

const FIELD_TYPE_TO_RESOURCE = {
  Lake: "food",
  Forest: "wood",
  Hill: "stone",
  Desert: "iron"
};
const FIELD_TYPES = Object.keys(FIELD_TYPE_TO_RESOURCE);

const RECALL_DURATION_SECONDS = 30;
const MAX_LEVEL_FOR_BONUS = 10;
const LEVEL_BONUS_PER_LEVEL = 0.03;

const GARRISON_CODES = ["warrior", "pikeman", "swordsman", "archer", "cavalry"];
const ATTACKER_UNIT_CODES = [
  "warrior", "pikeman", "swordsman", "archer", "cavalry", "cataphract",
  "ballista", "battering_ram", "catapult", "scout", "transporter"
];
const STATIONABLE_CODES = [
  "warrior", "pikeman", "swordsman", "archer", "cavalry", "cataphract",
  "ballista", "battering_ram", "catapult", "scout", "transporter"
];

const GUARD_SCALE = 0.10;
function getGuardForLevel(level) {
  const npcTroops = npcService.NPC_TROOPS_BY_LEVEL[level];
  return {
    warrior: Math.round(npcTroops.warrior * GUARD_SCALE),
    pikeman: Math.round(npcTroops.pikeman * GUARD_SCALE),
    swordsman: Math.round(npcTroops.swordsman * GUARD_SCALE),
    archer: Math.round(npcTroops.archer * GUARD_SCALE),
    cavalry: Math.round(npcTroops.cavalry * GUARD_SCALE)
  };
}

function levelBonusMultiplier(level) {
  const cappedLevel = Math.min(Number(level) || 0, MAX_LEVEL_FOR_BONUS);
  return cappedLevel * LEVEL_BONUS_PER_LEVEL;
}

/**
 * Atomic helper to credit troops back into city_units global roster.
 */
async function creditTroopsToCity(client, cityId, troopsMap) {
  for (const [code, count] of Object.entries(troopsMap)) {
    const qty = Math.max(0, Number(count || 0));
    if (qty === 0) continue;

    await client.query(`
      INSERT INTO city_units (city_id, unit_type_id, amount)
      SELECT $1, ut.id, $2
      FROM unit_types ut
      WHERE LOWER(ut.code) = LOWER($3)
      ON CONFLICT (city_id, unit_type_id)
      DO UPDATE SET amount = city_units.amount + EXCLUDED.amount;
    `, [cityId, qty, code]);
  }
}

async function seedValleysFromMap() {
  const tilesResult = await pool.query(`
    SELECT mt.x, mt.y, mt.name
    FROM map_tiles mt
    LEFT JOIN world_valleys wv ON wv.x = mt.x AND wv.y = mt.y
    WHERE mt.tile_type = 'VALLEY' AND wv.id IS NULL
  `);

  let created = 0;
  for (const tile of tilesResult.rows) {
    const fieldType = FIELD_TYPES[Math.floor(Math.random() * FIELD_TYPES.length)];
    const level = Math.floor(Math.random() * 10) + 1;
    const guard = getGuardForLevel(level);

    // BUGFIX: previously omitted `name` (NOT NULL, no default) — every
    // insert failed outright. Reuses the name map.service.js already
    // generated for this tile at world-generation time ("Valley (x, y)"),
    // same pattern as resourceField.service.js's seed fix (pull tile-
    // sourced data rather than invent it here).
    await pool.query(`
      INSERT INTO world_valleys (x, y, name, field_type, level, warrior, pikeman, swordsman, archer, cavalry)
      VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10)
      ON CONFLICT (x, y) DO NOTHING
    `, [tile.x, tile.y, tile.name, fieldType, level, guard.warrior, guard.pikeman, guard.swordsman, guard.archer, guard.cavalry]);
    created++;
  }

  return { valleysCreated: created };
}

/**
 * Resolve pending recall(s): credits troops back to city_units,
 * releases hero to IDLE, and clears valley state.
 * UPDATED: Accepts either a valley object OR a cityId to sweep all expired recalls for a city.
 */
async function resolvePendingRecall(target, db = pool) {
  if (!target) return target;

  // If passed a cityId (number/numeric string), find and resolve all expired recalls for that city
  if (typeof target === 'number' || (typeof target === 'string' && !isNaN(target) && target.trim() !== '')) {
    const cityId = Number(target);
    const expiredRes = await db.query(`
      SELECT * FROM world_valleys
      WHERE owner_city_id = $1 AND recall_at IS NOT NULL AND recall_at <= NOW()
    `, [cityId]);

    for (const row of expiredRes.rows) {
      await resolvePendingRecall(row, db);
    }
    return;
  }

  // Target is a single valley row object
  const valley = target;
  if (!valley.recall_at) return valley;

  // Reliable timestamp comparison avoiding timezone parsing mismatch
  const recallTime = new Date(valley.recall_at).getTime();
  if (isNaN(recallTime) || recallTime > Date.now()) {
    return valley;
  }

  // 1. Map all 11 possible returning troop types
  const returningTroops = {
    warrior: valley.warrior || 0,
    pikeman: valley.pikeman || 0,
    swordsman: valley.swordsman || 0,
    archer: valley.archer || 0,
    cavalry: valley.cavalry || 0,
    cataphract: valley.cataphract || 0,
    ballista: valley.ballista || 0,
    battering_ram: valley.battering_ram || 0,
    catapult: valley.catapult || 0,
    scout: valley.scout || 0,
    transporter: valley.transporter || 0
  };

  // 2. Credit troops to city roster
  if (valley.owner_city_id) {
    await creditTroopsToCity(db, valley.owner_city_id, returningTroops);
  }

  // 3. Free Hero to IDLE
  if (valley.hero_id) {
    await db.query(`UPDATE heroes SET status = 'IDLE' WHERE id = $1`, [valley.hero_id]);
  }

  // 4. Reset valley state and zero out all troop columns
  const result = await db.query(`
    UPDATE world_valleys
    SET owner_city_id = NULL, occupied_at = NULL, recall_at = NULL, hero_id = NULL,
        warrior = 0, pikeman = 0, swordsman = 0, archer = 0, cavalry = 0,
        cataphract = 0, ballista = 0, battering_ram = 0, catapult = 0, scout = 0, transporter = 0
    WHERE id = $1
    RETURNING *
  `, [valley.id]);

  return result.rows[0];
}

async function getValley(x, y) {
  const result = await pool.query(`SELECT * FROM world_valleys WHERE x = $1 AND y = $2`, [x, y]);
  if (result.rows.length === 0) {
    throw new Error(`No valley at (${x}, ${y}).`);
  }
  return resolvePendingRecall(result.rows[0]);
}

async function getValleyProductionBonusForCity(cityId) {
  await resolvePendingRecall(cityId); // UPDATED: Sweep expired recalls first

  const result = await pool.query(
    `SELECT field_type, level, recall_at FROM world_valleys WHERE owner_city_id = $1`,
    [cityId]
  );
  const bonusByResource = { food: 0, wood: 0, stone: 0, iron: 0 };
  const now = Date.now();
  result.rows.forEach(row => {
    if (row.recall_at && new Date(row.recall_at).getTime() <= now) return;
    const resourceType = FIELD_TYPE_TO_RESOURCE[row.field_type];
    if (!resourceType) return;
    bonusByResource[resourceType] += levelBonusMultiplier(row.level);
  });
  return bonusByResource;
}

async function creditSurvivorsHome(client, cityId, codes, survivingByCode, unitTypeByCode) {
  const troopsMap = {};
  codes.forEach(code => {
    if (survivingByCode[code] > 0) {
      troopsMap[code] = survivingByCode[code];
    }
  });
  await creditTroopsToCity(client, cityId, troopsMap);
}

// Valley (and resource-field) combat losses recover in FULL, up to whatever
// the city's hospital can hold right now — unlike NPC/PvP combat, which
// only saves a research-gated % (see npc.service.js's attackNpcCity).
// Called with the pre-loss sentTroops so we know exactly how many of each
// code were lost, same subtraction npc.service.js uses (sent - surviving).
async function queueValleyWounded(cityId, codes, sentTroops, survivingByCode, unitTypeByCode, source) {
  const hospitalService = require("./hospital.service");
  for (const code of codes) {
    const sentQty = Number(sentTroops[code] || 0);
    if (sentQty <= 0) continue;
    const lost = sentQty - (survivingByCode[code] || 0);
    if (lost <= 0) continue;
    const ut = unitTypeByCode[code];
    if (!ut) continue;
    await hospitalService.queueWounded(cityId, ut.id, lost, source);
  }
  // Same reasoning as npc.service.js: resolve immediately so an
  // empty/low-occupancy hospital doesn't force an unnecessary wait.
  await hospitalService.resolveHospitalQueue(cityId);
}

async function resolveCombat(client, cityId, valley, sentTroops) {
  const ALL_LOOKUP_CODES = [...new Set([...ATTACKER_UNIT_CODES, ...GARRISON_CODES])];
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

    const ownedRes = await client.query(
      `SELECT cu.amount FROM city_units cu WHERE cu.city_id = $1 AND cu.unit_type_id = $2`,
      [cityId, ut.id]
    );
    const owned = ownedRes.rows[0]?.amount || 0;
    if (owned < qty) {
      throw new Error(`Not enough ${code} — have ${owned}, tried to send ${qty}.`);
    }
  }

  for (const code of ATTACKER_UNIT_CODES) {
    const qty = Number(sentTroops[code] || 0);
    if (qty <= 0) continue;
    const ut = unitTypeByCode[code];
    await client.query(
      `UPDATE city_units SET amount = amount - $1 WHERE city_id = $2 AND unit_type_id = $3`,
      [qty, cityId, ut.id]
    );
  }

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
    const defQty = Number(valley[code] || 0);
    defenderPower += defQty * Number(ut?.defense || 0);
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

  return { unitTypeByCode, totalSent, attackerPower, defenderPower, attackerWins, attackerLosses, survivingByCode };
}

async function startHarvest(cityId, x, y, sentTroops, heroId) {
  if (!heroId) throw new Error("Harvest requires a hero to lead it.");

  const client = await pool.connect();
  try {
    await client.query("BEGIN");

    const valleyRes = await client.query(`SELECT * FROM world_valleys WHERE x = $1 AND y = $2 FOR UPDATE`, [x, y]);
    if (valleyRes.rows.length === 0) throw new Error(`No valley at (${x}, ${y}).`);
    let valley = await resolvePendingRecall(valleyRes.rows[0], client);

    if (valley.owner_city_id === cityId) {
      throw new Error("You're already harvesting this valley.");
    }

    const heroRes = await client.query(`SELECT * FROM heroes WHERE id = $1 FOR UPDATE`, [heroId]);
    if (heroRes.rows.length === 0) throw new Error(`No hero with id ${heroId}.`);
    const hero = heroRes.rows[0];
    if (hero.city_id !== cityId) throw new Error(`Hero ${hero.name} does not belong to this city.`);
    // BUGFIX: was comparing against uppercase 'IDLE' only. Hero rows as
    // actually created come back lowercase ('idle') — other parts of this
    // codebase (valley recall, releaseHero) write uppercase 'IDLE' when
    // transitioning a hero back, so the column ends up mixed-case depending
    // on a hero's history. Compare case-insensitively rather than assume one.
    if ((hero.status || '').toLowerCase() !== 'idle') throw new Error(`Hero ${hero.name} is not available (status: ${hero.status}).`);

    const combat = await resolveCombat(client, cityId, valley, sentTroops);
    const { unitTypeByCode, attackerWins, attackerLosses, survivingByCode } = combat;

    let result;
    if (attackerWins) {
      await client.query(`UPDATE heroes SET status = 'MARCHING' WHERE id = $1`, [heroId]);

      result = await client.query(`
        UPDATE world_valleys
        SET owner_city_id = $1, occupied_at = NOW(), recall_at = NULL, hero_id = $2,
            warrior = $3, pikeman = $4, swordsman = $5, archer = $6, cavalry = $7,
            cataphract = $8, ballista = $9, battering_ram = $10, catapult = $11, scout = $12, transporter = $13
        WHERE id = $14
        RETURNING *
      `, [
        cityId, heroId,
        survivingByCode.warrior || 0, survivingByCode.pikeman || 0, survivingByCode.swordsman || 0,
        survivingByCode.archer || 0, survivingByCode.cavalry || 0, survivingByCode.cataphract || 0,
        survivingByCode.ballista || 0, survivingByCode.battering_ram || 0, survivingByCode.catapult || 0,
        survivingByCode.scout || 0, survivingByCode.transporter || 0, valley.id
      ]);

      const nonStationable = ATTACKER_UNIT_CODES.filter(c => !STATIONABLE_CODES.includes(c));
      await creditSurvivorsHome(client, cityId, nonStationable, survivingByCode, unitTypeByCode);
      // Losses apply to the whole sent force regardless of which surviving
      // troops went home vs. stayed stationed at the valley — station status
      // doesn't affect who was lost.
      await queueValleyWounded(cityId, ATTACKER_UNIT_CODES, sentTroops, survivingByCode, unitTypeByCode, 'VALLEY');
    } else {
      const defenderLosses = Math.min(combat.totalSent, Math.floor(combat.attackerPower / Math.max(1, 1)));
      const newGuard = {};
      const defenderTotal = GARRISON_CODES.reduce((sum, c) => sum + Number(valley[c] || 0), 0);
      GARRISON_CODES.forEach(code => {
        const defQty = Number(valley[code] || 0);
        const lossShare = defenderTotal > 0 ? defenderLosses * (defQty / defenderTotal) : 0;
        newGuard[code] = Math.max(0, Math.round(defQty - lossShare));
      });
      result = await client.query(`
        UPDATE world_valleys
        SET warrior = $1, pikeman = $2, swordsman = $3, archer = $4, cavalry = $5
        WHERE id = $6
        RETURNING *
      `, [newGuard.warrior, newGuard.pikeman, newGuard.swordsman, newGuard.archer, newGuard.cavalry, valley.id]);

      await creditSurvivorsHome(client, cityId, ATTACKER_UNIT_CODES, survivingByCode, unitTypeByCode);
      await queueValleyWounded(cityId, ATTACKER_UNIT_CODES, sentTroops, survivingByCode, unitTypeByCode, 'VALLEY');
    }

    await client.query("COMMIT");
    return { won: attackerWins, valley: result.rows[0], attackerLosses, survivingByCode };

  } catch (err) {
    await client.query("ROLLBACK");
    throw err;
  } finally {
    client.release();
  }
}

async function raidValley(cityId, x, y, sentTroops, heroId = null) {
  const client = await pool.connect();
  try {
    await client.query("BEGIN");

    const valleyRes = await client.query(`SELECT * FROM world_valleys WHERE x = $1 AND y = $2 FOR UPDATE`, [x, y]);
    if (valleyRes.rows.length === 0) throw new Error(`No valley at (${x}, ${y}).`);
    let valley = await resolvePendingRecall(valleyRes.rows[0], client);

    if (valley.owner_city_id === cityId) {
      throw new Error("You already hold this valley — recall instead of raiding your own.");
    }

    let hero = null;
    if (heroId) {
      hero = await heroXpService.lockAndValidateHero(heroId, cityId, client);
    }

    const combat = await resolveCombat(client, cityId, valley, sentTroops);
    const { unitTypeByCode, attackerWins, attackerLosses, survivingByCode } = combat;

    await creditSurvivorsHome(client, cityId, ATTACKER_UNIT_CODES, survivingByCode, unitTypeByCode);
    await queueValleyWounded(cityId, ATTACKER_UNIT_CODES, sentTroops, survivingByCode, unitTypeByCode, 'VALLEY');

    let evicted = null;
    let heroXpResult = null;

    if (attackerWins) {
      if (valley.owner_city_id && valley.hero_id) {
        await client.query(`UPDATE heroes SET status = 'IDLE' WHERE id = $1`, [valley.hero_id]);
        evicted = { previousOwnerCityId: valley.owner_city_id, heroFreed: valley.hero_id };
      }
      if (valley.owner_city_id) {
        const evictedTroops = {
          warrior: valley.warrior || 0, pikeman: valley.pikeman || 0, swordsman: valley.swordsman || 0,
          archer: valley.archer || 0, cavalry: valley.cavalry || 0, cataphract: valley.cataphract || 0,
          ballista: valley.ballista || 0, battering_ram: valley.battering_ram || 0, catapult: valley.catapult || 0,
          scout: valley.scout || 0, transporter: valley.transporter || 0
        };
        await creditTroopsToCity(client, valley.owner_city_id, evictedTroops);
      }

      const result = await client.query(`
        UPDATE world_valleys
        SET owner_city_id = NULL, occupied_at = NULL, recall_at = NULL, hero_id = NULL,
            warrior = 0, pikeman = 0, swordsman = 0, archer = 0, cavalry = 0,
            cataphract = 0, ballista = 0, battering_ram = 0, catapult = 0, scout = 0, transporter = 0
        WHERE id = $1
        RETURNING *
      `, [valley.id]);
      valley = result.rows[0];

      if (hero) {
        const PLACEHOLDER_RAID_WIN_XP = 25;
        heroXpResult = await heroXpService.awardCombatXp(hero, PLACEHOLDER_RAID_WIN_XP, client);
      }
    } else {
      const defenderLosses = Math.min(combat.totalSent, Math.floor(combat.attackerPower / Math.max(1, 1)));
      const newGuard = {};
      const defenderTotal = GARRISON_CODES.reduce((sum, c) => sum + Number(valley[c] || 0), 0);
      GARRISON_CODES.forEach(code => {
        const defQty = Number(valley[code] || 0);
        const lossShare = defenderTotal > 0 ? defenderLosses * (defQty / defenderTotal) : 0;
        newGuard[code] = Math.max(0, Math.round(defQty - lossShare));
      });
      const result = await client.query(`
        UPDATE world_valleys
        SET warrior = $1, pikeman = $2, swordsman = $3, archer = $4, cavalry = $5
        WHERE id = $6
        RETURNING *
      `, [newGuard.warrior, newGuard.pikeman, newGuard.swordsman, newGuard.archer, newGuard.cavalry, valley.id]);
      valley = result.rows[0];
    }

    await client.query("COMMIT");
    return { won: attackerWins, valley, attackerLosses, survivingByCode, evicted, heroXp: heroXpResult };

  } catch (err) {
    await client.query("ROLLBACK");
    throw err;
  } finally {
    client.release();
  }
}

async function recallFromValley(cityId, x, y) {
  const client = await pool.connect();
  try {
    await client.query("BEGIN");

    const valleyRes = await client.query(`SELECT * FROM world_valleys WHERE x = $1 AND y = $2 FOR UPDATE`, [x, y]);
    if (valleyRes.rows.length === 0) throw new Error(`No valley at (${x}, ${y}).`);
    const valley = await resolvePendingRecall(valleyRes.rows[0], client);

    if (valley.owner_city_id !== cityId) {
      throw new Error("You aren't harvesting this valley.");
    }
    if (valley.recall_at) {
      throw new Error("Recall already in progress.");
    }

    const recallAt = new Date(Date.now() + RECALL_DURATION_SECONDS * 1000);
    const result = await client.query(`
      UPDATE world_valleys
      SET recall_at = $1
      WHERE id = $2
      RETURNING *
    `, [recallAt, valley.id]);

    await client.query("COMMIT");
    return { valley: result.rows[0], recallAt };

  } catch (err) {
    await client.query("ROLLBACK");
    throw err;
  } finally {
    client.release();
  }
}

async function getHoldingsForCity(cityId) {
  await resolvePendingRecall(cityId); // UPDATED: Sweep expired recalls first

  const result = await pool.query(`SELECT * FROM world_valleys WHERE owner_city_id = $1`, [cityId]);
  const resolved = [];
  for (const row of result.rows) {
    const valley = await resolvePendingRecall(row);
    if (valley.owner_city_id !== cityId) continue;

    let heroName = null;
    if (valley.hero_id) {
      const heroRes = await pool.query(`SELECT name, level FROM heroes WHERE id = $1`, [valley.hero_id]);
      if (heroRes.rows[0]) heroName = `${heroRes.rows[0].name} (Lv ${heroRes.rows[0].level})`;
    }

    resolved.push({
      x: valley.x,
      y: valley.y,
      fieldType: valley.field_type,
      resourceType: FIELD_TYPE_TO_RESOURCE[valley.field_type],
      level: valley.level,
      garrison: {
        warrior: valley.warrior || 0, pikeman: valley.pikeman || 0, swordsman: valley.swordsman || 0,
        archer: valley.archer || 0, cavalry: valley.cavalry || 0, cataphract: valley.cataphract || 0,
        ballista: valley.ballista || 0, battering_ram: valley.battering_ram || 0, catapult: valley.catapult || 0,
        scout: valley.scout || 0, transporter: valley.transporter || 0
      },
      hero: heroName,
      productionBonusPct: Math.round(levelBonusMultiplier(valley.level) * 10000) / 100,
      recallAt: valley.recall_at
    });
  }
  return resolved;
}

module.exports = {
  FIELD_TYPE_TO_RESOURCE,
  FIELD_TYPES,
  RECALL_DURATION_SECONDS,
  GARRISON_CODES,
  getGuardForLevel,
  levelBonusMultiplier,
  seedValleysFromMap,
  getValley,
  getValleyProductionBonusForCity,
  startHarvest,
  raidValley,
  recallFromValley,
  getHoldingsForCity,
  creditTroopsToCity,
  resolvePendingRecall
};
