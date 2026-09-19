// ============================================================================
// FILE: src/services/defense.service.js
// WALL DEFENSE & FORTIFICATION SERVICE
// ============================================================================

const pool = require("../database/db"); //[cite: 2]
const unitsService = require("./units.service");

/**
 * Retrieves the current capacity, built units, per-defense requirements,
 * and active queue for a city's wall.
 *
 * Previously this only returned a flat wallLevel + metalCastingLevel, and
 * wall.html compensated with its own hardcoded `defensesCatalog` array
 * (reqWall/reqMetal thresholds, fixed costs) — completely disconnected
 * from the real unit_research_requirements prerequisite system built for
 * these same 5 items (Trap Factory levels, Iron Working tiers, Barracks
 * Lv4 for Archer's Tower, Forge Lv5 for Rolling Log, Engineering tier 3
 * for Defensive Trebuchet). Since these fortifications are already
 * unit_types rows (category='fortification'), this now reuses the exact
 * same evaluatePrerequisites() engine units.service.js uses for troops —
 * one prerequisite engine, not two that can drift apart.
 */
async function getWallState(cityId) {
  // 1. Get City Owner & Wall Level
  const cityRes = await pool.query(
    `SELECT c.owner_id, COALESCE(cb.level, 0) AS wall_level
     FROM cities c
     LEFT JOIN city_buildings cb ON cb.city_id = c.id
       AND cb.building_type_id = (SELECT id FROM building_types WHERE name = 'Walls')
     WHERE c.id = $1`,
    [cityId]
  );
  if (cityRes.rows.length === 0) throw new Error("City not found.");
  const { owner_id: playerId, wall_level } = cityRes.rows[0];
  const wallLevel = Number(wall_level);

  // wall_fortification_capacity is keyed by city_id, with columns
  // current_capacity / max_capacity (confirmed via \d) — NOT wall_level /
  // capacity. This reads max_capacity per-city.
  const maxSpaceRes = await pool.query(
    `SELECT COALESCE(max_capacity, 0) AS max_space FROM wall_fortification_capacity WHERE city_id = $1`,
    [cityId]
  );
  const maxSpace = Number(maxSpaceRes.rows[0]?.max_space || 0);

  // 2. City Resources
  const resRes = await pool.query(
    `SELECT food, wood, stone, iron FROM city_resources WHERE city_id = $1`,
    [cityId]
  );
  const resources = resRes.rows[0] || { food: 0, wood: 0, stone: 0, iron: 0 };

  // 3. Building levels for THIS city (same shape units.service.js builds
  // for troops) — needed by evaluatePrerequisites for the matrix building
  // rows (Trap Factory, Forge, Barracks levels).
  const buildingRes = await pool.query(`
    SELECT cb.building_type_id, cb.level
    FROM city_buildings cb
    WHERE cb.city_id = $1
  `, [cityId]);
  const buildingLevelsByType = {};
  let barracksLevel = 0;
  const barracksTypeIdRes = await pool.query(`SELECT id FROM building_types WHERE name = 'Barracks'`);
  const barracksTypeId = barracksTypeIdRes.rows[0]?.id;
  buildingRes.rows.forEach(b => {
    if (!(b.building_type_id in buildingLevelsByType) || b.level > buildingLevelsByType[b.building_type_id]) {
      buildingLevelsByType[b.building_type_id] = b.level;
    }
    if (b.building_type_id === barracksTypeId && b.level > barracksLevel) {
      barracksLevel = b.level;
    }
  });

  // 4. Fortification unit_types + built counts + queue
  const fortTypesRes = await pool.query(
    `SELECT * FROM unit_types WHERE category = 'fortification' ORDER BY id ASC`
  );
  const unitsRes = await pool.query(
    `SELECT ut.code, cu.amount 
     FROM city_units cu
     JOIN unit_types ut ON ut.id = cu.unit_type_id
     WHERE cu.city_id = $1 AND ut.category = 'fortification'`,
    [cityId]
  );
  const builtCounts = {};
  unitsRes.rows.forEach(row => { builtCounts[row.code] = row.amount; });

  const queueRes = await pool.query(
    `SELECT ut.name, rq.quantity, rq.finish_at
     FROM recruitment_queue rq
     JOIN unit_types ut ON ut.id = rq.unit_type_id
     WHERE rq.city_id = $1 AND ut.category = 'fortification'
     ORDER BY rq.finish_at ASC`,
    [cityId]
  );

  // 5. Evaluate real requirements for each fortification, same engine as troops.
  const completedNodeSet = await unitsService.getPlayerCompletedNodeSet(playerId);
  const requirementsByUnitId = await unitsService.getUnitRequirements();
  const buildingNamesByType = await unitsService.getBuildingNameMap();
  const researchNameMap = await unitsService.getResearchNameMap();

  const defenses = fortTypesRes.rows.map(unit => {
    const check = unitsService.evaluatePrerequisites(
      unit,
      {}, // buildingLevels (legacy normalized-name map) — fortifications
          // don't use the dedicated-column checks (Workshop/Stable/generic
          // req_building_code), only the matrix building rows below.
      completedNodeSet,
      requirementsByUnitId[unit.id],
      barracksLevel,
      buildingLevelsByType,
      buildingNamesByType,
      researchNameMap
    );

    return {
      ...unit,
      built: builtCounts[unit.code] || 0,
      unlocked: check.passed,
      requirements: check.requirements
    };
  });

  return {
    wallLevel,
    maxSpace,
    resources,
    defenses,
    queue: queueRes.rows
  };
}

/**
 * Validates resources and space, deducts costs, and queues a fortification build order.
 */
async function buildDefenses(cityId, defenseCode, quantity) {
  const qty = Math.max(1, parseInt(quantity, 10) || 1);
  const client = await pool.connect();

  try {
    await client.query("BEGIN");

    // Fetch unit info
    const unitRes = await client.query(
      `SELECT id, population_cost, food_cost, wood_cost, stone_cost, iron_cost, base_training_seconds
       FROM unit_types 
       WHERE code = $1 AND category = 'fortification'`,
      [defenseCode]
    );
    if (unitRes.rows.length === 0) throw new Error("Invalid defense unit type.");
    const unit = unitRes.rows[0];

    // Fetch capacity vs currently used & queued space.
    // wall_fortification_capacity is keyed by city_id, with columns
    // current_capacity / max_capacity (confirmed via \d).
    const capRes = await client.query(
      `SELECT max_capacity AS max_space, current_capacity AS used_space
       FROM wall_fortification_capacity
       WHERE city_id = $1`,
      [cityId]
    );

    if (capRes.rows.length === 0) throw new Error("Wall required.");
    const { max_space, used_space } = capRes.rows[0];
    const spaceNeeded = qty * unit.population_cost;

    if (max_space - used_space < spaceNeeded) throw new Error("Insufficient wall space.");

    // Lock and check resources
    const totalFood = unit.food_cost * qty;
    const totalWood = unit.wood_cost * qty;
    const totalStone = unit.stone_cost * qty;
    const totalIron = unit.iron_cost * qty;

    const resCheck = await client.query(
      `SELECT food, wood, stone, iron FROM city_resources WHERE city_id = $1 FOR UPDATE`,
      [cityId]
    );
    const r = resCheck.rows[0];

    if (r.food < totalFood || r.wood < totalWood || r.stone < totalStone || r.iron < totalIron) {
      throw new Error("Insufficient resources.");
    }

    // Deduct resources
    await client.query(
      `UPDATE city_resources 
       SET food = food - $1, wood = wood - $2, stone = stone - $3, iron = iron - $4, updated_at = NOW()
       WHERE city_id = $5`,
      [totalFood, totalWood, totalStone, totalIron, cityId]
    );

    // Calculate completion queue time
    // Filtered to category = 'fortification' to match getWallState()'s
    // displayed queue — previously this queried ALL recruitment_queue rows
    // for the city (troop training included), so a fortification order
    // could silently get queued behind an unrelated troop's finish_at that
    // never showed up anywhere in the wall UI.
    const lastQueue = await client.query(
      `SELECT rq.finish_at
       FROM recruitment_queue rq
       JOIN unit_types ut ON ut.id = rq.unit_type_id
       WHERE rq.city_id = $1 AND ut.category = 'fortification'
       ORDER BY rq.finish_at DESC LIMIT 1`,
      [cityId]
    );

    let startTime = Date.now();
    if (lastQueue.rows.length > 0) {
      const lastFinish = new Date(lastQueue.rows[0].finish_at).getTime();
      if (lastFinish > startTime) startTime = lastFinish;
    }

    const durationMs = (unit.base_training_seconds || 60) * qty * 1000;
    const finishAt = new Date(startTime + durationMs);

    // NOTE: this INSERT's column list has not been checked against the
    // actual recruitment_queue schema yet (units.service.js's own INSERT
    // uses a different column list including building_id and started_at).
    // Do not run this until `\d recruitment_queue` is confirmed.
    await client.query(
      `INSERT INTO recruitment_queue (city_id, unit_type_id, quantity, finish_at)
       VALUES ($1, $2, $3, $4)`,
      [cityId, unit.id, qty, finishAt]
    );

    await client.query("COMMIT");
    return { success: true, finishAt };
  } catch (err) {
    await client.query("ROLLBACK");
    throw err;
  } finally {
    client.release();
  }
}

module.exports = {
  getWallState,
  buildDefenses
}; //[cite: 2]
