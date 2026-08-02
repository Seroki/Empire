const pool = require('../database/db');
const researchService = require('./research.service');

// How much population is currently tied up in this city's active recruitment
// queue, across ALL barracks facilities — population is a shared city
// resource regardless of which building is training. Computed on the fly
// from the queue itself (same pattern as getReservedWorkers() for
// construction) instead of a running counter column, so it never needs to
// be manually decremented when training finishes.
async function getReservedPopulation(cityId, client = pool) {
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

function evaluatePrerequisites(unit, buildings, research, barracksLevel) {
  if ((barracksLevel || 0) < unit.required_barracks_level) {
    return {
      passed: false,
      reason: `Requires Barracks Level ${unit.required_barracks_level}`
    };
  }

  if ((buildings.WORKSHOP || 0) < (unit.required_workshop_level || 0)) {
    return {
      passed: false,
      reason: `Requires Workshop Level ${unit.required_workshop_level}`
    };
  }

  if ((buildings.STABLE || 0) < (unit.required_stable_level || 0)) {
    return {
      passed: false,
      reason: `Requires Stable Level ${unit.required_stable_level}`
    };
  }

  if (unit.required_research_code) {
    const level = research[unit.required_research_code] || 0;
    if (level < unit.required_research_level) {
      return {
        passed: false,
        reason: `Requires ${unit.required_research_code} Level ${unit.required_research_level}`
      };
    }
  }

  return {
    passed: true,
    reason: null
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

  const resResult = await pool.query(`SELECT * FROM city_resources WHERE city_id = $1`, [cityId]);
  const resources = resResult.rows[0] || {};
  const totalPopulation = resources.population || resources.workers || 0;
  const reservedPopulation = await getReservedPopulation(cityId);
  const availablePopulation = Math.max(0, totalPopulation - reservedPopulation);

  // 1. Get building levels for city
  const buildingRes = await pool.query(`
    SELECT cb.id AS building_id, UPPER(bt.name) AS code, cb.level 
    FROM city_buildings cb
    JOIN building_types bt ON cb.building_type_id = bt.id
    WHERE cb.city_id = $1
  `, [cityId]);

  const buildingLevels = {};
  const barracksList = [];

  buildingRes.rows.forEach(b => {
    // Keep the highest level seen for non-Barracks prerequisite buildings
    // (Workshop/Stable). Assumes one of each per city; if you add multiples
    // of those too, they'll need the same per-facility treatment as Barracks.
    if (!(b.code in buildingLevels) || b.level > buildingLevels[b.code]) {
      buildingLevels[b.code] = b.level;
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

  // Resolve which specific facility we're showing. Each Barracks has its
  // own level and its own independent queue.
  const selectedBarracks = barracksList.find(b => b.id == barracksId) || barracksList[0];
  const selectedBarracksLevel = selectedBarracks.level;

  // 2. Fetch unit types
  const unitsRes = await pool.query(`SELECT * FROM unit_types ORDER BY required_barracks_level ASC`);

  // 3. Fetch active recruitment queue for THIS facility only, so parallel
  // Barracks each show and run their own queue.
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
  const research = await researchService.getPlayerResearchLevels(playerId);

  const trainableUnits = [];
  const lockedUnits = [];

  unitsRes.rows.forEach(unit => {
    const check = evaluatePrerequisites(unit, buildingLevels, research, selectedBarracksLevel);
    const popCost = unit.population_cost || unit.pop_cost || 1;
    const maxTrainable = Math.floor(availablePopulation / popCost);

    const item = {
      ...unit,
      owned: cityUnits[unit.code] || 0,
      isAvailable: check.passed,
      canTrain: check.passed,
      reason: check.reason,
      maxTrainable
    };

    if (check.passed) {
      trainableUnits.push(item);
    } else {
      lockedUnits.push(item);
    }
  });

  // ADD THE RETURN STATEMENT HERE (AT THE END OF getBarracksData):
  return {
    barracks: barracksList,
    availablePopulation,
    trainableUnits,
    lockedUnits,
    units: [...trainableUnits, ...lockedUnits], // Merged for front-ends expecting data.units
    queue: queueRes.rows
  };
}

/**
 * Start recruiting troops with Population Cap enforcement
 */
/**
 * Start recruiting troops with Population Cap & Research Prerequisite enforcement
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

    // 0b. Confirm the selected facility is actually a Barracks belonging to
    // this city, and get ITS level (not some other Barracks in the city).
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

    // 2. Get city resources & population (Locked for update)
    const resResult = await client.query(`SELECT * FROM city_resources WHERE city_id = $1 FOR UPDATE`, [cityId]);
    if (resResult.rows.length === 0) throw new Error("City resources not found.");
    const resources = resResult.rows[0];

    // Calculate idle population
    const totalPopulation = resources.population || resources.workers || 0;
    const reservedPopulation = await getReservedPopulation(cityId, client);
    const availablePopulation = Math.max(0, totalPopulation - reservedPopulation);

    // Enforce Population Limit
    const unitPopCost = unit.population_cost || unit.pop_cost || 1;
    const totalPopRequired = unitPopCost * quantity;

    if (totalPopRequired > availablePopulation) {
      const maxPossible = Math.floor(availablePopulation / unitPopCost);
      throw new Error(`Insufficient population! Required: ${totalPopRequired}, Available: ${availablePopulation}. Max trainable: ${maxPossible}`);
    }

    // 3. Validate Building & Research Prerequisites
    const buildingRes = await client.query(`
      SELECT UPPER(bt.name) AS code, cb.level 
      FROM city_buildings cb
      JOIN building_types bt ON cb.building_type_id = bt.id
      WHERE cb.city_id = $1
    `, [cityId]);

    const buildingLevels = {};
    buildingRes.rows.forEach(b => {
      if (!(b.code in buildingLevels) || b.level > buildingLevels[b.code]) {
        buildingLevels[b.code] = b.level;
      }
    });

    const research = await researchService.getPlayerResearchLevels(playerId);

    const check = evaluatePrerequisites(
      unit,
      buildingLevels,
      research,
      barracksLevel
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

    // 5. Deduct Resources (population is reserved implicitly by the
    // recruitment_queue row inserted below — see getReservedPopulation)
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
    // Chained off THIS facility's own queue, not the whole city's — that's
    // what lets multiple Barracks train in parallel instead of one shared line.
    const totalSeconds = (unit.base_build_seconds || 10) * quantity;

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

module.exports = { getBarracksData, startRecruitment, processCompletedRecruitment, getReservedPopulation };
