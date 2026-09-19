// ============================================================================
// FILE: src/services/resourceField.service.js
// WILDERNESS RESOURCE FIELD SERVICE (world map RESOURCE tiles)
//
// Separate system from world_valleys, even though the shape looks similar.
// Key differences, per design direction:
//   - Guard troops are "forsaken troops": warrior/pikeman/swordsman/archer
//     only — no cavalry, no siege, ever.
//   - Harvest rate is NOT a flat level-based table like valleys. It's
//     computed from the OCCUPYING city's currently-stationed troops:
//         hourlyRate = Σ(garrison unit count × unit_types.attack)
//                      × (1 + min(resourceLevel, 10) × 0.03)
//     i.e. the same +3%/level (cap +30% at level 10) bonus shape already
//     used for valley ownership bonuses, applied on top of raw troop
//     attack power rather than a fixed table.
//   - resource_type/resource_level are NOT duplicated here — they already
//     live on map_tiles for RESOURCE tiles. This table only tracks
//     occupation state (garrison, ownership, harvest timing, recall).
//
// PLACEHOLDER: guard troop counts below reuse npc.service.js's
// NPC_TROOPS_BY_LEVEL table (cavalry stripped, since these guards never
// have cavalry) at a lighter scale than NPC cities or Valleys — these are
// meant to be the easiest fights on the map. Replace GUARD_SCALE with a
// real balance number when one exists; nothing else needs to change shape.
// ============================================================================

const pool = require("../database/db");
const npcService = require("./npc.service");

const RECALL_DURATION_SECONDS = 5 * 60; // 5 minutes — same placeholder as valleys, no march system yet
const FIELD_STORAGE_HOURS = 16;          // same convention as valleys / in-city fields
const MAX_LEVEL_FOR_BONUS = 10;
const LEVEL_BONUS_PER_LEVEL = 0.03;      // +3%/level, capped +30% at level 10 — same shape as valley ownership bonus

const GARRISON_CODES = ["warrior", "pikeman", "swordsman", "archer"]; // no cavalry, ever, on these tiles

// Guard force per level — deliberately the lightest of the three guard
// tables (NPC cities, Valleys, this). Cavalry stripped from the shared
// baseline since resource-field guards never have any.
const GUARD_SCALE = 0.05;
function getGuardForLevel(level) {
  const npcTroops = npcService.NPC_TROOPS_BY_LEVEL[level] || npcService.NPC_TROOPS_BY_LEVEL[1];
  return {
    warrior: Math.round(npcTroops.warrior * GUARD_SCALE),
    pikeman: Math.round(npcTroops.pikeman * GUARD_SCALE),
    swordsman: Math.round(npcTroops.swordsman * GUARD_SCALE),
    archer: Math.round(npcTroops.archer * GUARD_SCALE)
    // cavalry intentionally omitted — not a valid garrison type here
  };
}

function levelBonusMultiplier(level) {
  const cappedLevel = Math.min(Number(level) || 0, MAX_LEVEL_FOR_BONUS);
  return 1 + cappedLevel * LEVEL_BONUS_PER_LEVEL;
}

/**
 * Seed world_resource_fields rows for every map_tiles row with
 * tile_type = 'RESOURCE' that doesn't have one yet. Idempotent — same
 * pattern as seedValleysFromMap / seedNpcCitiesFromMap.
 */
async function seedResourceFieldsFromMap() {
  const tilesResult = await pool.query(`
    SELECT mt.x, mt.y, mt.resource_level, mt.resource_type
    FROM map_tiles mt
    LEFT JOIN world_resource_fields wrf ON wrf.x = mt.x AND wrf.y = mt.y
    WHERE mt.tile_type = 'RESOURCE' AND wrf.id IS NULL
  `);

  let created = 0;
  for (const tile of tilesResult.rows) {
    const level = tile.resource_level || 1;
    const guard = getGuardForLevel(level);

    // BUGFIX: previously omitted resource_type and resource_level entirely,
    // even though every other function in this file (getHourlyHarvestRate,
    // getHoldingsForCity, etc.) reads field.resource_type / field.resource_level
    // constantly — every seeded row was created with these NULL/missing.
    await pool.query(`
      INSERT INTO world_resource_fields (x, y, resource_type, resource_level, warrior, pikeman, swordsman, archer)
      VALUES ($1, $2, $3, $4, $5, $6, $7, $8)
      ON CONFLICT (x, y) DO NOTHING
    `, [tile.x, tile.y, tile.resource_type, level, guard.warrior, guard.pikeman, guard.swordsman, guard.archer]);
    created++;
  }

  return { resourceFieldsCreated: created };
}

/**
 * Resolve a pending recall if its timer has passed — same shape as
 * valley.service.js's resolvePendingRecall. Field goes unguarded on
 * departure; no regen modeled yet.
 */
async function resolvePendingRecall(field, db = pool) {
  if (!field.recall_at || new Date(field.recall_at) > new Date()) {
    return field;
  }
  const result = await db.query(`
    UPDATE world_resource_fields
    SET owner_city_id = NULL, occupied_at = NULL, recall_at = NULL,
        warrior = 0, pikeman = 0, swordsman = 0, archer = 0
    WHERE id = $1
    RETURNING *
  `, [field.id]);
  return result.rows[0];
}

/**
 * Fetch the field's occupation state joined with map_tiles' resource_type/
 * resource_level, since those live there and aren't duplicated here.
 */
async function getResourceField(x, y) {
  const result = await pool.query(`
    SELECT wrf.*, mt.resource_type, mt.resource_level
    FROM world_resource_fields wrf
    JOIN map_tiles mt ON mt.x = wrf.x AND mt.y = wrf.y
    WHERE wrf.x = $1 AND wrf.y = $2
  `, [x, y]);
  if (result.rows.length === 0) {
    throw new Error(`No resource field at (${x}, ${y}).`);
  }
  return resolvePendingRecall(result.rows[0]);
}

/**
 * Live hourly harvest rate from the OWNER's currently-stationed garrison —
 * not a flat level table. Recomputed fresh each call since garrison
 * composition can change (losses from a later attack, partial recall).
 */
async function getHourlyHarvestRate(field, db = pool) {
  if (!field.owner_city_id) return 0;

  const attackByCode = await getUnitAttackByCode(db);
  let rawPower = 0;
  GARRISON_CODES.forEach(code => {
    const count = Number(field[code] || 0);
    rawPower += count * Number(attackByCode[code] || 0);
  });

  return Math.round(rawPower * levelBonusMultiplier(field.resource_level));
}

async function getUnitAttackByCode(db = pool) {
  const result = await db.query(
    `SELECT code, attack FROM unit_types WHERE UPPER(code) = ANY($1)`,
    [GARRISON_CODES.map(c => c.toUpperCase())]
  );
  const map = {};
  result.rows.forEach(r => { map[r.code.toLowerCase()] = r.attack; });
  return map;
}

async function getUnitLoadCapacityByCode(db = pool) {
  const result = await db.query(
    `SELECT code, load_capacity FROM unit_types WHERE UPPER(code) = ANY($1)`,
    [GARRISON_CODES.map(c => c.toUpperCase())]
  );
  const map = {};
  result.rows.forEach(r => { map[r.code.toLowerCase()] = r.load_capacity; });
  return map;
}

/**
 * Currently-accrued, uncollected harvest since last_harvested_at, capped at
 * a 16-hour storage window — same convention as valleys and in-city fields.
 * Only meaningful while owner_city_id is set.
 */
async function getAccruedHarvest(field, db = pool) {
  if (!field.owner_city_id) return 0;
  const hourlyRate = await getHourlyHarvestRate(field, db);
  const hoursElapsed = Math.max(0, (Date.now() - new Date(field.last_harvested_at).getTime()) / 3600000);
  const cap = hourlyRate * FIELD_STORAGE_HOURS;
  return Math.min(cap, Math.round(hourlyRate * hoursElapsed));
}

/**
 * Attack (occupy) a resource field. Combat model and transaction shape
 * mirror valley.service.js's attackValley exactly — same attacker roster,
 * same loss formula, same "no march system yet, survivors just don't come
 * home on a loss" simplification. The only real differences: defender
 * roster excludes cavalry entirely, and only warrior/pikeman/swordsman/
 * archer survivors can be garrisoned on a win (again, no cavalry column).
 */
async function attackResourceField(cityId, x, y, sentTroops) {
  const client = await pool.connect();
  try {
    await client.query("BEGIN");

    const fieldRes = await client.query(`
      SELECT wrf.*, mt.resource_type, mt.resource_level
      FROM world_resource_fields wrf
      JOIN map_tiles mt ON mt.x = wrf.x AND mt.y = wrf.y
      WHERE wrf.x = $1 AND wrf.y = $2
      FOR UPDATE OF wrf
    `, [x, y]);
    if (fieldRes.rows.length === 0) throw new Error(`No resource field at (${x}, ${y}).`);
    let field = fieldRes.rows[0];
    field = await resolvePendingRecall(field, client);

    if (field.owner_city_id === cityId) {
      throw new Error("You already hold this field.");
    }

    // Same attacker roster as valley/NPC attacks. LEVY and MILITIA excluded
    // (not deployable / garrison-only). Warrior excluded — NPC/field-guard
    // only, never player-sendable.
    const ATTACKER_UNIT_CODES = [
      "pikeman", "swordsman", "archer", "cavalry", "cataphract",
      "ballista", "battering_ram", "catapult", "scout", "transporter"
    ];
    const ALL_LOOKUP_CODES = [...new Set([...ATTACKER_UNIT_CODES, ...GARRISON_CODES])];

    const totalSent = ATTACKER_UNIT_CODES.reduce((sum, code) => sum + Number(sentTroops[code] || 0), 0);
    if (totalSent <= 0) throw new Error("You must send at least one troop.");

    const unitTypesRes = await client.query(
      `SELECT id, code, attack, defense, base_hp FROM unit_types WHERE UPPER(code) = ANY($1)`,
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

    // Resolve combat — identical shape to attackValley.
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
      const defQty = Number(field[code] || 0);
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

    let result;

    // Only pikeman/swordsman/archer can be stationed here — no cavalry
    // column exists on this table at all (see GARRISON_CODES). So cavalry
    // survivors ALWAYS return home, even on a win, alongside everything
    // else non-foot (cataphract/ballista/battering_ram/catapult/scout/
    // transporter).
    const STATIONABLE_CODES = ["pikeman", "swordsman", "archer"];

    async function creditSurvivorsHome(codes) {
      for (const code of codes) {
        const surviving = survivingByCode[code];
        if (!surviving || surviving <= 0) continue;
        const ut = unitTypeByCode[code];
        await client.query(`
          INSERT INTO city_units (city_id, unit_type_id, amount)
          VALUES ($1, $2, $3)
          ON CONFLICT (city_id, unit_type_id)
          DO UPDATE SET amount = city_units.amount + EXCLUDED.amount
        `, [cityId, ut.id, surviving]);
      }
    }

    if (attackerWins) {
      // Previous occupier's unclaimed accrued harvest is simply lost —
      // same risk-of-holding-a-field rule as valleys. Only pikeman/
      // swordsman/archer survivors can be garrisoned; no cavalry column
      // exists on this table.
      result = await client.query(`
        UPDATE world_resource_fields
        SET owner_city_id = $1, occupied_at = NOW(), recall_at = NULL,
            last_harvested_at = NOW(),
            warrior = 0, pikeman = $2, swordsman = $3, archer = $4
        WHERE id = $5
        RETURNING *
      `, [cityId, survivingByCode.pikeman || 0, survivingByCode.swordsman || 0,
          survivingByCode.archer || 0, field.id]);

      // BUGFIX: non-stationable survivors (including cavalry) used to just
      // disappear on a win. They now return home instead.
      const nonStationable = ATTACKER_UNIT_CODES.filter(c => !STATIONABLE_CODES.includes(c));
      await creditSurvivorsHome(nonStationable);
    } else {
      const defenderLosses = Math.min(totalSent, Math.floor(attackerPower / Math.max(1, avgHp)));
      const newGuard = {};
      const defenderTotal = GARRISON_CODES.reduce((sum, c) => sum + Number(field[c] || 0), 0);
      GARRISON_CODES.forEach(code => {
        const defQty = Number(field[code] || 0);
        const lossShare = defenderTotal > 0 ? defenderLosses * (defQty / defenderTotal) : 0;
        newGuard[code] = Math.max(0, Math.round(defQty - lossShare));
      });
      result = await client.query(`
        UPDATE world_resource_fields
        SET warrior = $1, pikeman = $2, swordsman = $3, archer = $4
        WHERE id = $5
        RETURNING *
      `, [newGuard.warrior, newGuard.pikeman, newGuard.swordsman, newGuard.archer, field.id]);

      // BUGFIX: on a loss, EVERY surviving attacker used to just vanish.
      // They come home now.
      await creditSurvivorsHome(ATTACKER_UNIT_CODES);
    }

    await client.query("COMMIT");
    return { won: attackerWins, field: result.rows[0], attackerLosses, survivingByCode };

  } catch (err) {
    await client.query("ROLLBACK");
    throw err;
  } finally {
    client.release();
  }
}

/**
 * Recall: deposit whatever's currently accrued immediately, then schedule
 * departure after RECALL_DURATION_SECONDS. Same shape as
 * valley.service.js's recallFromValley.
 */
async function recallFromResourceField(cityId, x, y) {
  const client = await pool.connect();
  try {
    await client.query("BEGIN");

    const fieldRes = await client.query(`
      SELECT wrf.*, mt.resource_type, mt.resource_level
      FROM world_resource_fields wrf
      JOIN map_tiles mt ON mt.x = wrf.x AND mt.y = wrf.y
      WHERE wrf.x = $1 AND wrf.y = $2
      FOR UPDATE OF wrf
    `, [x, y]);
    if (fieldRes.rows.length === 0) throw new Error(`No resource field at (${x}, ${y}).`);
    const field = await resolvePendingRecall(fieldRes.rows[0], client);

    if (field.owner_city_id !== cityId) {
      throw new Error("You don't hold this field.");
    }
    if (field.recall_at) {
      throw new Error("Recall already in progress.");
    }

    const accrued = await getAccruedHarvest(field, client);
    const resourceType = field.resource_type;

    // BUGFIX / FEATURE: Recall used to hand over the entire accrued amount
    // regardless of what's actually garrisoned there — no relationship to
    // the same carry-capacity concept already proven for NPC plunder
    // (plunder.service.js). Now capped by Σ(garrison count x
    // unit_types.load_capacity), same math, applied to a standing garrison
    // instead of a one-shot raid's survivors.
    const capacityByCode = await getUnitLoadCapacityByCode(client);
    let totalCarryCapacity = 0;
    GARRISON_CODES.forEach(code => {
      totalCarryCapacity += Number(field[code] || 0) * Number(capacityByCode[code] || 0);
    });
    const collected = Math.min(accrued, totalCarryCapacity);
    const cappedByCapacity = accrued > totalCarryCapacity;

    const ALLOWED_RESOURCE_COLUMNS = ["food", "wood", "stone", "iron"];
    if (collected > 0 && resourceType && ALLOWED_RESOURCE_COLUMNS.includes(resourceType)) {
      const depositResult = await client.query(`
        UPDATE city_resources SET ${resourceType} = ${resourceType} + $1, updated_at = NOW()
        WHERE city_id = $2
      `, [collected, cityId]);
      // BUGFIX: same silent-0-rows risk as npc.service.js's plunder deposit
      // — a city_id mismatch here previously would have reported a
      // successful Recall with a real "collected" number while nothing
      // actually landed in city_resources.
      if (depositResult.rowCount === 0) {
        throw new Error(`Recall deposit failed: no city_resources row found for city_id ${cityId}.`);
      }
    }

    // Same simplification already used elsewhere in this codebase (e.g.
    // valley capture: "unclaimed accrued harvest is simply lost"): anything
    // above carry capacity is forfeited on Recall, not bankable for next
    // time — the harvest clock resets regardless of whether the full
    // accrued amount was actually carried. Flagged as a deliberate choice,
    // not silently assumed — revisit if partial-collection banking is
    // wanted instead (would need a new column to track it).
    const recallAt = new Date(Date.now() + RECALL_DURATION_SECONDS * 1000);
    const result = await client.query(`
      UPDATE world_resource_fields
      SET recall_at = $1, last_harvested_at = NOW()
      WHERE id = $2
      RETURNING *
    `, [recallAt, field.id]);

    await client.query("COMMIT");
    return {
      collected,
      resourceType,
      field: result.rows[0],
      totalCarryCapacity,
      totalAvailable: accrued,
      cappedByCapacity
    };

  } catch (err) {
    await client.query("ROLLBACK");
    throw err;
  } finally {
    client.release();
  }
}

/**
 * All RESOURCE fields currently owned by a city, with live harvest rate,
 * accrued amount, and a breakdown of raw troop power vs. the level-bonus %
 * — unlike valleys, this bonus IS actually applied (it's baked into
 * getHourlyHarvestRate already), not just theoretical.
 */
async function getHoldingsForCity(cityId) {
  const result = await pool.query(`
    SELECT wrf.*, mt.resource_type, mt.resource_level
    FROM world_resource_fields wrf
    JOIN map_tiles mt ON mt.x = wrf.x AND mt.y = wrf.y
    WHERE wrf.owner_city_id = $1
  `, [cityId]);

  const resolved = [];
  for (const row of result.rows) {
    const field = await resolvePendingRecall(row);
    if (field.owner_city_id !== cityId) continue; // recall resolved mid-read

    const attackByCode = await getUnitAttackByCode();
    const capacityByCode = await getUnitLoadCapacityByCode();
    let rawPower = 0;
    let totalCarryCapacity = 0;
    GARRISON_CODES.forEach(code => {
      rawPower += Number(field[code] || 0) * Number(attackByCode[code] || 0);
      totalCarryCapacity += Number(field[code] || 0) * Number(capacityByCode[code] || 0);
    });
    const bonusMultiplier = levelBonusMultiplier(field.resource_level);
    const hourlyRate = await getHourlyHarvestRate(field);
    const accruedHarvest = await getAccruedHarvest(field);

    resolved.push({
      x: field.x,
      y: field.y,
      resourceType: field.resource_type,
      level: field.resource_level,
      garrison: {
        warrior: field.warrior, pikeman: field.pikeman,
        swordsman: field.swordsman, archer: field.archer
      },
      rawTroopPower: rawPower,
      levelBonusPct: Math.round((bonusMultiplier - 1) * 10000) / 100, // e.g. 15.00 for +15%
      hourlyRate,
      accruedHarvest,
      totalCarryCapacity,
      wouldBeCappedOnRecall: accruedHarvest > totalCarryCapacity,
      recallAt: field.recall_at
    });
  }
  return resolved;
}

/**
 * Collect: deposit whatever's currently accrued into city_resources WITHOUT
 * vacating the garrison — the missing counterpart to recallFromResourceField.
 * Previously the only way to ever get accrued harvest into city_resources
 * was to recall (which also sends the garrison home and drops ownership
 * risk). That meant a field's bonus displayed correctly in getHoldingsForCity
 * but never actually reached usable resources for a player who wanted to
 * keep holding the tile — same "computed but never applied" bug shape
 * flagged elsewhere this session, just one step further down the chain.
 *
 * Same accrual/capacity-cap math as recallFromResourceField, but leaves
 * owner_city_id, warrior/pikeman/swordsman/archer, and recall_at untouched.
 */
async function collectFromResourceField(cityId, x, y) {
  const client = await pool.connect();
  try {
    await client.query("BEGIN");

    const fieldRes = await client.query(`
      SELECT wrf.*, mt.resource_type, mt.resource_level
      FROM world_resource_fields wrf
      JOIN map_tiles mt ON mt.x = wrf.x AND mt.y = wrf.y
      WHERE wrf.x = $1 AND wrf.y = $2
      FOR UPDATE OF wrf
    `, [x, y]);
    if (fieldRes.rows.length === 0) throw new Error(`No resource field at (${x}, ${y}).`);
    const field = await resolvePendingRecall(fieldRes.rows[0], client);

    if (field.owner_city_id !== cityId) {
      throw new Error("You don't hold this field.");
    }
    if (field.recall_at) {
      throw new Error("A recall is already in progress — nothing to collect.");
    }

    const accrued = await getAccruedHarvest(field, client);
    const resourceType = field.resource_type;

    // Same carry-capacity cap as Recall — a garrison can only carry so much
    // at once, whether it's marching home or just running a supply relay.
    const capacityByCode = await getUnitLoadCapacityByCode(client);
    let totalCarryCapacity = 0;
    GARRISON_CODES.forEach(code => {
      totalCarryCapacity += Number(field[code] || 0) * Number(capacityByCode[code] || 0);
    });
    const collected = Math.min(accrued, totalCarryCapacity);
    const cappedByCapacity = accrued > totalCarryCapacity;

    if (collected <= 0) {
      throw new Error("No harvest available to collect yet.");
    }

    const ALLOWED_RESOURCE_COLUMNS = ["food", "wood", "stone", "iron"];
    if (!resourceType || !ALLOWED_RESOURCE_COLUMNS.includes(resourceType)) {
      throw new Error(`Field at (${x}, ${y}) has no valid resource type to collect.`);
    }

    const depositResult = await client.query(`
      UPDATE city_resources SET ${resourceType} = ${resourceType} + $1, updated_at = NOW()
      WHERE city_id = $2
    `, [collected, cityId]);
    // Same silent-0-rows guard used in recallFromResourceField / npc plunder —
    // a city_id mismatch here would otherwise report success with nothing
    // actually landing in city_resources.
    if (depositResult.rowCount === 0) {
      throw new Error(`Collect deposit failed: no city_resources row found for city_id ${cityId}.`);
    }

    // Anything above carry capacity is forfeited on collect too, same
    // deliberate simplification as Recall — the harvest clock resets
    // regardless of whether the full accrued amount was actually carried.
    // Garrison, ownership, and recall_at are left untouched — this is the
    // key difference from recallFromResourceField.
    const result = await client.query(`
      UPDATE world_resource_fields
      SET last_harvested_at = NOW()
      WHERE id = $1
      RETURNING *
    `, [field.id]);

    await client.query("COMMIT");
    return {
      collected,
      resourceType,
      field: result.rows[0],
      totalCarryCapacity,
      totalAvailable: accrued,
      cappedByCapacity
    };

  } catch (err) {
    await client.query("ROLLBACK");
    throw err;
  } finally {
    client.release();
  }
}

module.exports = {
  GARRISON_CODES,
  RECALL_DURATION_SECONDS,
  getGuardForLevel,
  levelBonusMultiplier,
  seedResourceFieldsFromMap,
  getResourceField,
  getHourlyHarvestRate,
  getAccruedHarvest,
  attackResourceField,
  recallFromResourceField,
  collectFromResourceField,
  getHoldingsForCity
};
