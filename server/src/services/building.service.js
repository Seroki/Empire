const pool = require("../database/db");
const valleyService = require("./valley.service");

// Mayor's Politics reduces construction/upgrade time, mirroring the
// established pattern in research.service.js (Intelligence reduces
// research time) and city.service.js's own getMayorPoliticsBuff (already
// used for Levy refill speed — same formula reused here rather than
// inventing a second, different Politics multiplier). Required lazily
// inside the function rather than at top-of-file, since city.service.js
// requires this file too — a top-level require would be circular.
async function applyMayorConstructionBuff(cityId, baseSeconds) {
  const cityService = require("./city.service");
  const mayorBuff = await cityService.getMayorPoliticsBuff(cityId); // 1 + politics/100
  const constructionResearchPct = await getResearchProductionBonusPct(cityId, 'CONSTRUCTION_SPEED'); // e.g. 0.45 for 45%
  // Stacks additively with the mayor's Politics buff, matching how research
  // bonuses of the same type already stack additively within player_bonus_totals
  // (resolveCompletedResearch sums bonus_value, never multiplies) — so combining
  // a second bonus SOURCE follows the same convention rather than compounding.
  const combinedBuff = mayorBuff + constructionResearchPct;
  return Math.round(baseSeconds / combinedBuff);
}

/**
 * Single source of truth for gold accrual — both getSettledResources (this
 * file) and computeLiveResources (city.service.js) call this so the formula
 * can never drift between the two again. No DB calls; caller supplies
 * everything it already has on hand.
 *
 * Returns { gold, goldRemainder } instead of a plain number: gold income is
 * fractional per-hour, but the gold column is a bigint, and truncating to a
 * whole number on every single save (every 5s poll from index.html) was
 * silently discarding the fractional remainder every time — a player
 * earning e.g. 1032/hour (1.433 gold per 5s tick) was actually only ever
 * accumulating 720/hour, because the 0.433 leftover never survived to the
 * next tick. goldRemainder banks that leftover so the caller can persist it
 * and feed it back in next time, instead of losing it.
 */
function computeGoldAccrual({ currentGold, goldRemainder, workers, taxRate, taxEfficiencyPct, hoursElapsed }) {
    const goldPerHour = workers * GOLD_PER_WORKER_PER_HOUR * (taxRate / 100) * (1 + (taxEfficiencyPct || 0));
    const earnedRaw = goldPerHour * hoursElapsed + Number(goldRemainder || 0);
    const earnedWhole = Math.trunc(earnedRaw);
    const newRemainder = earnedRaw - earnedWhole; // always in [0, 1) — banked for next tick
    return {
        gold: Number(currentGold) + earnedWhole,
        goldRemainder: newRemainder
    };
}

// Must match the same constants in city.service.js
const STARTING_POPULATION = 200;
const WORKER_RATIO = 0.6;
const GOLD_PER_WORKER_PER_HOUR = 10;
const FIELD_STORAGE_HOURS = 16; // Resource Field Storage & Collection GDS

// Rough placeholder: each unit of construction/upgrade level
// reserves this many workers until it completes.
const WORKERS_PER_LEVEL = 100;

async function getMayorProductionBonusPct(cityId) {
    const result = await pool.query(
        `SELECT politics FROM heroes WHERE city_id = $1 AND is_mayor = TRUE LIMIT 1`,
        [cityId]
    );
    const politics = Number(result.rows[0]?.politics ?? 0);
    // Returns decimal percentage (e.g., 10 politics = 0.05 bonus, or +5%)
    return politics * 0.005;
}

// Locks and returns city_resources with elapsed production applied.
async function getSettledResources(client, cityId) {
    const resourceResult = await client.query(
        `
        SELECT *
        FROM city_resources
        WHERE city_id = $1
        FOR UPDATE
        `,
        [cityId]
    );

    const resources = resourceResult.rows[0];

    const rateResult = await client.query(
        `
        SELECT
            COALESCE(SUM(bl.population_capacity), 0) AS cottages_population
        FROM city_buildings cb
        JOIN building_types bt ON bt.id = cb.building_type_id
        JOIN building_levels bl
            ON bl.building_type_id = cb.building_type_id
            AND bl.level = cb.level
        WHERE cb.city_id = $1
          AND bt.name = 'Cottage'
        `,
        [cityId]
    );

    const rates = rateResult.rows[0];

    const totalPopulation = STARTING_POPULATION + Number(rates.cottages_population);
    // The starting 200 is a fixed baseline that sits outside the worker
    // ratio entirely — fully counted as workers on its own. Only
    // Cottage-added population is subject to the 60% ratio.
    const workers = STARTING_POPULATION + Math.floor(Number(rates.cottages_population) * WORKER_RATIO);
    const taxRate = Number(resources.tax_rate) || 0;

    const now = Date.now();
    // Gold uses its own dedicated clock (gold_updated_at), NOT the generic
    // updated_at column — updated_at gets bumped by every unrelated
    // resource-spend (research, training, etc.), which would otherwise
    // silently reset gold's accrual window on actions that have nothing to
    // do with gold. See resolveGoldIncome() in city.service.js, which
    // settles this same clock on every dashboard poll — this function only
    // needs to account for whatever's accrued in the short gap since then.
    const last = new Date(resources.gold_updated_at).getTime();
    const hoursElapsed = Math.max(0, (now - last) / 3600000);
    const taxEfficiencyPct = await getResearchProductionBonusPct(cityId, 'TAX_EFFICIENCY');

    const { gold, goldRemainder } = computeGoldAccrual({
        currentGold: Number(resources.gold),
        goldRemainder: Number(resources.gold_remainder) || 0,
        workers,
        taxRate,
        taxEfficiencyPct,
        hoursElapsed
    });

    return {
        ...resources,
         food: Number(resources.food),
         wood: Number(resources.wood),
         stone: Number(resources.stone),
         iron: Number(resources.iron),
         gold,
         goldRemainder,
         workers,
         population: totalPopulation
      };
}

// How many workers are currently tied up in this city's active construction queue
async function getReservedWorkers(client, cityId) {
    const result = await client.query(
        `
        SELECT COALESCE(SUM(workers_used), 0) AS reserved
        FROM construction_queue
        WHERE city_id = $1
        `,
        [cityId]
    );
    return Number(result.rows[0].reserved);
}

function buildShortfallMessage(resources, cost, workerCost, availableWorkers) {
    const shortfalls = [];

    const checks = [
        ["food", "food"],
        ["wood", "wood"],
        ["stone", "stone"],
        ["iron", "iron"],
        ["gold", "gold"]
    ];

    for (const [costKey, label] of checks) {
        const need = Number(cost[`${costKey}_cost`]) || 0;
        const have = Number(resources[costKey]) || 0;
        if (have < need) {
            shortfalls.push(`${Math.ceil(need - have)} more ${label}`);
        }
    }

    if (availableWorkers < workerCost) {
        shortfalls.push(`${workerCost - availableWorkers} more workers (needs ${workerCost}, ${availableWorkers} available)`);
    }

    return `Not enough resources. Still need: ${shortfalls.join(", ")}.`;
}

async function startUpgrade(cityId, buildingId) {
    const client = await pool.connect();

    try {
        await client.query("BEGIN");

        const buildingResult = await client.query(
            `
            SELECT *
            FROM city_buildings
            WHERE id = $1
            AND city_id = $2
            `,
            [buildingId, cityId]
        );

        if (buildingResult.rows.length === 0) {
            throw new Error("Building not found");
        }

        const building = buildingResult.rows[0];
        const buildingTypeId = building.building_type_id;
        const nextLevel = building.level + 1;

        const levelResult = await client.query(
            `
            SELECT *
            FROM building_levels
            WHERE building_type_id = $1
            AND level = $2
            `,
            [buildingTypeId, nextLevel]
        );

        if (levelResult.rows.length === 0) {
            throw new Error("Maximum level reached");
        }

        if (buildingTypeId !== 1) { // 1 = Town Hall
            const thResult = await client.query(
                `SELECT level FROM city_buildings WHERE city_id = $1 AND building_type_id = 1`,
                [cityId]
            );
            const thLevel = thResult.rows.length > 0 ? thResult.rows[0].level : 1;

            if (nextLevel > thLevel) {
                throw new Error(`Cannot upgrade past Town Hall level (${thLevel}). Upgrade Town Hall first!`);
            }
        }

        const upgrade = levelResult.rows[0];
        const resources = await getSettledResources(client, cityId);

        const workerCost = WORKERS_PER_LEVEL * nextLevel;
        const reservedWorkers = await getReservedWorkers(client, cityId);
        const availableWorkers = resources.workers - reservedWorkers;

        if (
            resources.food < upgrade.food_cost ||
            resources.wood < upgrade.wood_cost ||
            resources.stone < upgrade.stone_cost ||
            resources.iron < upgrade.iron_cost ||
            resources.gold < upgrade.gold_cost ||
            availableWorkers < workerCost
        ) {
            throw new Error(buildShortfallMessage(resources, upgrade, workerCost, availableWorkers));
        }

        await client.query(
            `
            UPDATE city_resources
            SET
                food = $1,
                wood = $2,
                stone = $3,
                iron = $4,
                gold = $5,
                gold_remainder = $6,
                workers = $7,
                population = $8,
                updated_at = NOW(),
                gold_updated_at = NOW()
            WHERE city_id = $9
            `,
            [
                resources.food - upgrade.food_cost,
                resources.wood - upgrade.wood_cost,
                resources.stone - upgrade.stone_cost,
                resources.iron - upgrade.iron_cost,
                Math.floor(resources.gold - upgrade.gold_cost),
                resources.goldRemainder,
                resources.workers,
                resources.population,
                cityId
            ]
        );

        const actualBuildSeconds = await applyMayorConstructionBuff(cityId, upgrade.build_seconds);

        await client.query(
            `
            INSERT INTO construction_queue
            (
                city_id,
                building_id,
                target_level,
                finish_time,
                workers_used
            )
            VALUES
            (
                $1,
                $2,
                $3,
                NOW() + ($4 || ' seconds')::interval,
                $5
            )
            `,
            [
                cityId,
                building.id,
                nextLevel,
                actualBuildSeconds,
                workerCost
            ]
        );

        await client.query("COMMIT");

        return {
            building: buildingId,
            oldLevel: building.level,
            newLevel: nextLevel,
            finishesIn: actualBuildSeconds,
            workersReserved: workerCost
        };

    } catch(error) {
        await client.query("ROLLBACK");
        throw error;
    } finally {
        client.release();
    }
}

async function demolishBuilding(cityId, buildingId) {
    const PROTECTED_BUILDING_TYPE_IDS = [1, 2, 3]; // Town Hall, Keep, Walls — can never be demolished
    const REFUND_PERCENT = 0.5; // 50% of the building's current-level build cost
    const DEMOLISH_TIME_FRACTION = 0.5; // demolition takes half as long as that level's original build time

    const client = await pool.connect();
    try {
        await client.query("BEGIN");

        const buildingResult = await client.query(
            `SELECT * FROM city_buildings WHERE id = $1 AND city_id = $2 FOR UPDATE`,
            [buildingId, cityId]
        );
        if (buildingResult.rows.length === 0) {
            throw new Error("Building not found");
        }
        const building = buildingResult.rows[0];

        if (PROTECTED_BUILDING_TYPE_IDS.includes(building.building_type_id)) {
            throw new Error("This building cannot be deconstructed (Town Hall, Walls, and Keep are permanent).");
        }

        if (building.level < 1) {
            throw new Error("Cannot demolish a building that hasn't finished its initial construction yet.");
        }

        // Already mid-construction/upgrade/demolition? One action at a time per building.
        const activeQueueResult = await client.query(
            `SELECT 1 FROM construction_queue WHERE building_id = $1 LIMIT 1`,
            [buildingId]
        );
        if (activeQueueResult.rows.length > 0) {
            throw new Error("This building already has an order in progress.");
        }

        // Refund based on the CURRENT level's cost (what was actually spent
        // to reach this level), not the next level up.
        const levelResult = await client.query(
            `SELECT * FROM building_levels WHERE building_type_id = $1 AND level = $2`,
            [building.building_type_id, building.level]
        );
        const levelCost = levelResult.rows[0] || {
            food_cost: 0, wood_cost: 0, stone_cost: 0, iron_cost: 0, gold_cost: 0, build_seconds: 60
        };

        const refund = {
            food: Math.round((levelCost.food_cost || 0) * REFUND_PERCENT),
            wood: Math.round((levelCost.wood_cost || 0) * REFUND_PERCENT),
            stone: Math.round((levelCost.stone_cost || 0) * REFUND_PERCENT),
            iron: Math.round((levelCost.iron_cost || 0) * REFUND_PERCENT),
            gold: Math.round((levelCost.gold_cost || 0) * REFUND_PERCENT)
        };

        const demolishSeconds = Math.max(10, Math.round((levelCost.build_seconds || 60) * DEMOLISH_TIME_FRACTION));

        await client.query(
            `
            INSERT INTO construction_queue
            (city_id, building_id, target_level, finish_time, workers_used, is_demolition,
             refund_food, refund_wood, refund_stone, refund_iron, refund_gold)
            VALUES ($1, $2, 0, NOW() + ($3 || ' seconds')::interval, 0, true, $4, $5, $6, $7, $8)
            `,
            [cityId, buildingId, demolishSeconds, refund.food, refund.wood, refund.stone, refund.iron, refund.gold]
        );

        await client.query("COMMIT");

        return {
            building: buildingId,
            demolishingLevel: building.level,
            finishesIn: demolishSeconds,
            refund
        };

    } catch (error) {
        await client.query("ROLLBACK");
        throw error;
    } finally {
        client.release();
    }
}

async function constructBuilding(cityId, buildingTypeId) {
    const client = await pool.connect();

    try {
        await client.query("BEGIN");

        const typeResult = await client.query(
            `
            SELECT *
            FROM building_types
            WHERE id = $1
            `,
            [buildingTypeId]
        );

        if (typeResult.rows.length === 0) {
            throw new Error("Building type not found");
        }

        const buildingType = typeResult.rows[0];

        const existingResult = await client.query(
            `
            SELECT cb.*, bt.slot_pool
            FROM city_buildings cb
            JOIN building_types bt
                ON cb.building_type_id = bt.id
            WHERE cb.city_id = $1
            `,
            [cityId]
        );

        const existingBuildings = existingResult.rows;

        if (buildingType.is_unique) {
            const alreadyBuilt = existingBuildings.some(
                b => b.building_type_id === buildingType.id
            );
            if (alreadyBuilt) {
                throw new Error("This building is already built (only one allowed)");
            }
        }

        const townHall = existingBuildings.find(b => b.building_type_id === 1);
        const townHallLevel = townHall ? townHall.level : 1;

        if (buildingType.unlock_th_level && townHallLevel < buildingType.unlock_th_level) {
            throw new Error(`Requires Town Hall level ${buildingType.unlock_th_level}`);
        }

        // Real prerequisite system: building_prerequisites, keyed by
        // (building_type_id, target_level). For a brand-new construction
        // this is always target_level = 1. Each row requires EITHER a
        // building (req_building_type_id + req_building_level) OR research
        // (req_research_node_id) — a row can require both together (AND).
        // A building type can have multiple rows, all of which must pass.
        // Replaces the old single-column requires_building_id/
        // unlock_wall_level checks, which relied on columns that don't
        // exist on building_types — a wall-level requirement is just a
        // prerequisite row with req_building_type_id pointing at Walls.
        const prereqResult = await client.query(
            `
            SELECT bp.*, reqBt.name AS req_building_name
            FROM building_prerequisites bp
            LEFT JOIN building_types reqBt ON reqBt.id = bp.req_building_type_id
            WHERE bp.building_type_id = $1 AND bp.target_level = 1
            `,
            [buildingTypeId]
        );

        for (const prereq of prereqResult.rows) {
            if (prereq.req_building_type_id) {
                const match = existingBuildings.find(b => b.building_type_id === prereq.req_building_type_id);
                const haveLevel = match ? match.level : 0;
                const needLevel = prereq.req_building_level || 1;
                if (haveLevel < needLevel) {
                    throw new Error(`Requires ${prereq.req_building_name || `building #${prereq.req_building_type_id}`} level ${needLevel}`);
                }
            }
            if (prereq.req_research_node_id) {
                // Research-level prerequisites aren't enforced yet — the
                // per-node research-level system this depends on isn't
                // built (research_nodes currently has no level concept).
                // Flagged rather than silently skipped so this doesn't get
                // forgotten once that system exists.
                console.warn(`[constructBuilding] Skipping unenforced research prerequisite (research_node_id ${prereq.req_research_node_id}) for building_type_id ${buildingTypeId}`);
            }
        }

        if (buildingType.slot_pool === "inner") {
            const innerTotal = Math.min(32, townHallLevel * 4);
            const innerUsed = existingBuildings.filter(b => b.slot_pool === "inner").length;
            if (innerUsed >= innerTotal) {
                throw new Error(`No inner city slots available (${innerUsed}/${innerTotal} used at Town Hall Lv ${townHallLevel})`);
            }
        } else if (buildingType.slot_pool === "outer") {
            const outerTotal = Math.min(40, townHallLevel * 4);
            const outerUsed = existingBuildings.filter(b => b.slot_pool === "outer").length;
            if (outerUsed >= outerTotal) {
                throw new Error(`No outer field slots available (${outerUsed}/${outerTotal} used at Town Hall Lv ${townHallLevel})`);
            }
        }
        // NOTE: the old "wall_fortification" slot_pool branch was removed —
        // it queried wall_fortification_capacity with columns (wall_level,
        // capacity) that don't exist on that table, AND fortifications are
        // unit_types rows (category='fortification'), never building_types
        // rows, so no building_type would ever match this branch anyway.
        // Fortification construction is handled entirely by
        // defense.service.js's buildDefenses().

        // Note: the per-pool checks above (inner/outer, both using
        // Math.min(cap, townHallLevel * 4)) already correctly enforce the
        // TH1 case (4 inner slots including Town Hall = 3 buildable, 4
        // outer slots). A prior TH1-only special case here counted inner
        // and outer buildings against one shared limit of 3, which was
        // both redundant and wrong (it let outer construction block inner
        // construction and vice versa). Removed.

        const levelResult = await client.query(
            `
            SELECT *
            FROM building_levels
            WHERE building_type_id = $1
            AND level = 1
            `,
            [buildingTypeId]
        );

        if (levelResult.rows.length === 0) {
            throw new Error("Cost data not available for this building yet");
        }

        const cost = levelResult.rows[0];
        const resources = await getSettledResources(client, cityId);

        const workerCost = WORKERS_PER_LEVEL * 1;
        const reservedWorkers = await getReservedWorkers(client, cityId);
        const availableWorkers = resources.workers - reservedWorkers;

        if (
            resources.food < cost.food_cost ||
            resources.wood < cost.wood_cost ||
            resources.stone < cost.stone_cost ||
            resources.iron < cost.iron_cost ||
            resources.gold < cost.gold_cost ||
            availableWorkers < workerCost
        ) {
            throw new Error(buildShortfallMessage(resources, cost, workerCost, availableWorkers));
        }

        await client.query(
            `
            UPDATE city_resources
            SET
                food = $1,
                wood = $2,
                stone = $3,
                iron = $4,
                gold = $5,
                gold_remainder = $6,
                workers = $7,
                population = $8,
                updated_at = NOW(),
                gold_updated_at = NOW()
            WHERE city_id = $9
            `,
            [
                resources.food - cost.food_cost,
                resources.wood - cost.wood_cost,
                resources.stone - cost.stone_cost,
                resources.iron - cost.iron_cost,
                Math.floor(resources.gold - cost.gold_cost),
                resources.goldRemainder,
                resources.workers,
                resources.population,
                cityId
            ]
        );

        const newBuildingResult = await client.query(
            `
            INSERT INTO city_buildings
            (city_id, building_type_id, level, position_x, position_y)
            VALUES ($1, $2, 0, 0, 0)
            RETURNING *
            `,
            [cityId, buildingTypeId]
        );

        const newBuilding = newBuildingResult.rows[0];

        const actualBuildSeconds = await applyMayorConstructionBuff(cityId, cost.build_seconds);

        await client.query(
            `
            INSERT INTO construction_queue
            (city_id, building_id, target_level, finish_time, workers_used)
            VALUES ($1, $2, 1, NOW() + ($3 || ' seconds')::interval, $4)
            `,
            [
                cityId,
                newBuilding.id,
                actualBuildSeconds,
                workerCost
            ]
        );

        await client.query("COMMIT");

        return {
            building: newBuilding,
            name: buildingType.name,
            finishesIn: actualBuildSeconds,
            workersReserved: workerCost
        };

    } catch(error) {
        await client.query("ROLLBACK");
        throw error;
    } finally {
        client.release();
    }
}

async function processCompletedConstruction(cityId) {
    const completedResult = await pool.query(
        `
        SELECT *
        FROM construction_queue
        WHERE city_id = $1
        AND finish_time <= NOW()
        `,
        [cityId]
    );

    for (const item of completedResult.rows) {
        if (item.is_demolition) {
            // Demolition complete: remove the building entirely and credit
            // the refund that was calculated (and locked in) when the
            // player queued it — see demolishBuilding().
            await pool.query(
                `DELETE FROM city_buildings WHERE id = $1`,
                [item.building_id]
            );

            await pool.query(
                `
                UPDATE city_resources
                SET food = food + $1,
                    wood = wood + $2,
                    stone = stone + $3,
                    iron = iron + $4,
                    gold = gold + $5,
                    updated_at = NOW()
                WHERE city_id = $6
                `,
                [
                    item.refund_food || 0,
                    item.refund_wood || 0,
                    item.refund_stone || 0,
                    item.refund_iron || 0,
                    item.refund_gold || 0,
                    cityId
                ]
            );
        } else {
            await pool.query(
                `
                UPDATE city_buildings
                SET level = $1
                WHERE id = $2
                `,
                [
                    item.target_level,
                    item.building_id
                ]
            );
        }

        await pool.query(
            `
            DELETE FROM construction_queue
            WHERE id = $1
            `,
            [item.id]
        );
    }
}

async function getQueue(cityId) {
    const result = await pool.query(
        `
        SELECT
            cq.id,
            cq.target_level,
            cq.started_at,
            cq.finish_time,
            cq.workers_used,
            cq.is_demolition,
            cq.refund_food,
            cq.refund_wood,
            cq.refund_stone,
            cq.refund_iron,
            cq.refund_gold,
            cb.id AS building_id,
            cb.building_type_id,
            cb.level AS current_level,
            bt.name AS building_name
        FROM construction_queue cq
        JOIN city_buildings cb
            ON cq.building_id = cb.id
        JOIN building_types bt
            ON cb.building_type_id = bt.id
        WHERE cq.city_id = $1
        ORDER BY cq.finish_time
        `,
        [cityId]
    );

    return result.rows;
}

async function getAvailableBuildings(cityId) {
    const client = await pool.connect();
    try {
        const existingResult = await client.query(
            `SELECT building_type_id, level FROM city_buildings WHERE city_id = $1`,
            [cityId]
        );
        const existingBuildings = existingResult.rows;

        const townHall = existingBuildings.find(b => b.building_type_id === 1);
        const townHallLevel = townHall ? townHall.level : 1;

        const walls = existingBuildings.find(b => b.building_type_id === 3);
        const wallLevel = walls ? walls.level : 0;

        const builtTypeIds = new Set(existingBuildings.map(b => b.building_type_id));

        const availableTypesResult = await client.query(
            `
            SELECT bt.*, bl.food_cost, bl.wood_cost, bl.stone_cost, bl.iron_cost, bl.gold_cost, bl.build_seconds
            FROM building_types bt
            JOIN building_levels bl ON bt.id = bl.building_type_id AND bl.level = 1
            WHERE (bt.unlock_th_level IS NULL OR bt.unlock_th_level <= $1)
            `,
            [townHallLevel]
        );

        // Real prerequisite system — see constructBuilding() for the full
        // explanation. Fetched once for all building types (target_level=1
        // rows only, since this list is about what can be newly built),
        // keyed by building_type_id, rather than one query per candidate.
        // No is_fortification/is_defense/unit_type filtering needed here —
        // fortifications are unit_types rows (category='fortification'),
        // never building_types rows, so they can't appear in this result
        // set in the first place.
        const prereqResult = await client.query(
            `SELECT * FROM building_prerequisites WHERE target_level = 1`
        );
        const prereqsByBuildingType = {};
        prereqResult.rows.forEach(p => {
            if (!prereqsByBuildingType[p.building_type_id]) prereqsByBuildingType[p.building_type_id] = [];
            prereqsByBuildingType[p.building_type_id].push(p);
        });

        const existingLevelByType = {};
        existingBuildings.forEach(b => { existingLevelByType[b.building_type_id] = b.level; });

        const buildable = availableTypesResult.rows.filter(bt => {
            if (bt.is_unique && builtTypeIds.has(bt.id)) return false;

            const prereqs = prereqsByBuildingType[bt.id] || [];
            for (const prereq of prereqs) {
                if (prereq.req_building_type_id) {
                    const haveLevel = existingLevelByType[prereq.req_building_type_id] || 0;
                    if (haveLevel < (prereq.req_building_level || 1)) return false;
                }
                // req_research_node_id prerequisites aren't enforced yet —
                // see the matching note in constructBuilding().
            }

            return true;
        });

        return buildable;
    } finally {
        client.release();
    }
}
// Resource type -> the bonus_type key in player_bonus_totals that governs
// its production bonus (see research.service.js's bonus collection system).
// Gold has no entry — gold comes from tax/workers via city.service.js's
// resolveGoldIncome, not an outer-field production rate.
const RESOURCE_TYPE_TO_RESEARCH_BRANCH = {
    food: 'FARM_EFFECTIVENESS',
    wood: 'SAWMILL_EFFECTIVENESS',
    stone: 'QUARRY_EFFECTIVENESS',
    iron: 'IRON_MINE_EFFECTIVENESS'
};

/**
 * Total production bonus (as a decimal fraction, e.g. 0.04 = +4%) from
 * completed research, read straight from player_bonus_totals — the
 * pre-aggregated table research.service.js maintains as research completes
 * (see resolveCompletedResearch's upsert). Returns 0 if the player has no
 * bonus of this type yet, or no bonusType was given (e.g. gold).
 */
async function getResearchProductionBonusPct(cityId, bonusType) {
    if (!bonusType) return 0;

    const cityRes = await pool.query(`SELECT owner_id FROM cities WHERE id = $1`, [cityId]);
    const playerId = cityRes.rows[0]?.owner_id;
    if (!playerId) return 0;

    const totalRes = await pool.query(
        `SELECT total_value FROM player_bonus_totals WHERE player_id = $1 AND bonus_type = $2`,
        [playerId, bonusType]
    );
    const totalPct = Number(totalRes.rows[0]?.total_value || 0);
    return totalPct / 100;
}

async function collectResource(cityId, buildingId) {
    const client = await pool.connect();
    try {
        await client.query("BEGIN");

        // 1. Get building data along with its level production stats
        const bRes = await client.query(
            `
            SELECT 
                cb.*, 
                bt.name AS building_name, 
                bt.slot_pool,
                bl.food_per_hour,
                bl.wood_per_hour,
                bl.stone_per_hour,
                bl.iron_per_hour,
                bl.gold_per_hour,
                bl.storage_capacity AS field_capacity
            FROM city_buildings cb
            JOIN building_types bt ON cb.building_type_id = bt.id
            LEFT JOIN building_levels bl 
                ON bl.building_type_id = cb.building_type_id 
                AND bl.level = cb.level
            WHERE cb.id = $1 AND cb.city_id = $2
            `,
            [buildingId, cityId]
        );

        if (bRes.rows.length === 0) {
            throw new Error("Building not found");
        }

        const building = bRes.rows[0];

        if (building.slot_pool !== 'outer') {
            throw new Error("Only outer resource fields can be collected");
        }

        // 2. Map building name to target resource type (moved earlier so we
        // can apply the matching valley Harvest bonus to prodRate below)
        let resourceType = 'food';
        const nameLower = building.building_name.toLowerCase();
        if (nameLower.includes('sawmill') || nameLower.includes('wood')) resourceType = 'wood';
        else if (nameLower.includes('quarry') || nameLower.includes('stone')) resourceType = 'stone';
        else if (nameLower.includes('iron')) resourceType = 'iron';
        else if (nameLower.includes('mine') || nameLower.includes('gold')) resourceType = 'gold';

        // 3. Calculate elapsed production, boosted by any valleys of the
        // matching type this city is currently Harvesting (level x 0.03,
        // capped 0.30 per valley, summed across all held). Confirmed
        // formula, wired in here for the first time — previously computed
        // but never actually applied to production anywhere.
        const now = Date.now();
        const lastCollected = new Date(building.last_collected_at || building.created_at || now).getTime();
        const hoursElapsed = Math.max(0, (now - lastCollected) / 3600000);

        const baseRate = Number(
            building.food_per_hour || 
            building.wood_per_hour || 
            building.stone_per_hour || 
            building.iron_per_hour || 
            building.gold_per_hour || 
            (building.level || 1) * 100
        );

        const valleyBonuses = await valleyService.getValleyProductionBonusForCity(cityId);
        const valleyBonusPct = valleyBonuses[resourceType] || 0; // gold has no valley type, always 0

        const researchBranch = RESOURCE_TYPE_TO_RESEARCH_BRANCH[resourceType];
        const researchBonusPct = await getResearchProductionBonusPct(cityId, researchBranch);

        // Mayor's Politics bonus — was previously missing here, which meant
        // the badge/preview in getCityBuildings() (below) showed a higher
        // bonused accrual than what collectResource() actually paid out,
        // silently losing the Mayor's share of resources on every collect.
        const mayorBonusPct = await getMayorProductionBonusPct(cityId);

        const totalBonusPct = valleyBonusPct + researchBonusPct + mayorBonusPct;
        const prodRate = baseRate * (1 + totalBonusPct);

        // Field cap = current (boosted) hourly production x 16 hours, per
        // the Resource Field Storage & Collection GDS — NOT a static
        // building_levels.storage_capacity column (that data is unreliable/
        // unset for several buildings and was masked by a misleading 10000
        // fallback). Scales automatically with upgrades/research/bonuses,
        // matching city.service.js's getBuildings/attachFieldStorage, which
        // already used the correct formula.
        const fieldCap = Math.round(prodRate * FIELD_STORAGE_HOURS);
        const totalAccrued = Math.min(
            Math.round(Number(building.stored_resource || 0) + (hoursElapsed * prodRate)),
            fieldCap
        );

        if (totalAccrued <= 0) {
            throw new Error("No resources available to collect yet");
        }


        // 4. Calculate total Warehouse capacity across the city
        const whCapRes = await client.query(
            `
            SELECT COALESCE(SUM(bl.storage_capacity), 10000) AS total_warehouse_cap
            FROM city_buildings cb
            JOIN building_types bt ON cb.building_type_id = bt.id
            JOIN building_levels bl ON bl.building_type_id = cb.building_type_id AND bl.level = cb.level
            WHERE cb.city_id = $1 AND bt.name = 'Warehouse'
            `,
            [cityId]
        );

        const warehouseCap = Number(whCapRes.rows[0]?.total_warehouse_cap || 10000);

        // 5. Fetch current resources with row lock
        const currRes = await client.query(
            `SELECT * FROM city_resources WHERE city_id = $1 FOR UPDATE`,
            [cityId]
        );

        const currentAmount = Number(currRes.rows[0][resourceType] || 0);
        const newAmount = currentAmount + totalAccrued;
        const actualCollected = newAmount - currentAmount;

        // 6. Update city_resources and reset building's local storage timer
        await client.query(
            `UPDATE city_resources SET ${resourceType} = $1, updated_at = NOW() WHERE city_id = $2`,
            [newAmount, cityId]
        );

        await client.query(
            `UPDATE city_buildings SET stored_resource = 0, last_collected_at = NOW() WHERE id = $1`,
            [buildingId]
        );

        await client.query("COMMIT");

        return {
            buildingId,
            resourceType,
            collected: actualCollected,
            newTotal: newAmount,
            warehouseCap,
            valley_bonus_pct: Math.round(valleyBonusPct * 10000) / 100,
            research_bonus_pct: Math.round(researchBonusPct * 10000) / 100,
            mayor_bonus_pct: Math.round(mayorBonusPct * 10000) / 100
        };

    } catch (err) {
        await client.query("ROLLBACK");
        throw err;
    } finally {
        client.release();
    }
}
async function getCityBuildings(cityId) {
    const result = await pool.query(
        `
        SELECT 
            cb.*, 
            bt.name AS building_name, 
            bt.slot_pool,
            bl.food_per_hour,
            bl.wood_per_hour,
            bl.stone_per_hour,
            bl.iron_per_hour,
            bl.gold_per_hour,
            bl.storage_capacity
        FROM city_buildings cb
        JOIN building_types bt ON cb.building_type_id = bt.id
        LEFT JOIN building_levels bl 
            ON bl.building_type_id = cb.building_type_id 
            AND bl.level = cb.level
        WHERE cb.city_id = $1
        ORDER BY cb.id ASC
        `,
        [cityId]
    );

    // const now = Date.now();
    // Fetched once for the whole city, not per building — same bonus applies
    // to every outer field of a given resource type.
    // TEMPORARILY DISABLED: world_valleys table schema incomplete
    const valleyBonuses = { food: 0, wood: 0, stone: 0, iron: 0 };

    // Same idea for research bonuses — one query per branch (4 total: Farm,
    // Sawmill, Quarry, Iron Mine), not per building, even if the city has
    // multiple fields of the same type.
    const researchBonusByType = {};
    for (const [resType, branchCode] of Object.entries(RESOURCE_TYPE_TO_RESEARCH_BRANCH)) {
        researchBonusByType[resType] = await getResearchProductionBonusPct(cityId, branchCode);
    }

    // Reuses the same helper collectResource() now calls too, so the two
    // can't drift apart into two different Mayor bonus values again.
    const mayorBonusPct = await getMayorProductionBonusPct(cityId);

    return result.rows.map(b => {
        if (b.slot_pool === 'outer') {
            const baseRate = Number(
                b.food_per_hour || 
                b.wood_per_hour || 
                b.stone_per_hour || 
                b.iron_per_hour || 
                b.gold_per_hour || 
                (b.level || 1) * 100 // Safe fallback
            );

            // Same name-based resource-type detection as collectResource,
            // needed here to pick the right bonus percentage.
            let resourceType = 'food';
            const nameLower = (b.building_name || '').toLowerCase();
            if (nameLower.includes('sawmill') || nameLower.includes('wood')) resourceType = 'wood';
            else if (nameLower.includes('quarry') || nameLower.includes('stone')) resourceType = 'stone';
            else if (nameLower.includes('iron')) resourceType = 'iron';
            else if (nameLower.includes('mine') || nameLower.includes('gold')) resourceType = 'gold';

            const valleyBonusPct = valleyBonuses[resourceType] || 0;
            const researchBonusPct = researchBonusByType[resourceType] || 0;
            const totalBonusPct = valleyBonusPct + researchBonusPct + mayorBonusPct;
            const prodRate = baseRate * (1 + totalBonusPct);

            const lastCollected = new Date(b.last_collected_at || b.created_at || new Date()).getTime();
            const hoursElapsed = Math.max(0, (Date.now() - lastCollected) / 3600000);
            
            const maxCap = Math.round(prodRate * FIELD_STORAGE_HOURS);
            const accumulated = Number(b.stored_resource || 0) + (hoursElapsed * prodRate);

            return {
                ...b,
                production_rate: prodRate,
                base_production_rate: baseRate,
                valley_bonus_pct: Math.round(valleyBonusPct * 10000) / 100,
                research_bonus_pct: Math.round(researchBonusPct * 10000) / 100,
                mayor_bonus_pct: Math.round(mayorBonusPct * 10000) / 100,
                total_bonus_pct: Math.round(totalBonusPct * 10000) / 100,
                max_capacity: maxCap,
                stored_resource: Math.min(Math.round(accumulated), maxCap)
            };
        }
        return b;
    });
}

module.exports = {
    startUpgrade,
    demolishBuilding,
    constructBuilding,
    processCompletedConstruction,
    getQueue,
    getAvailableBuildings,
    getReservedWorkers,
    getCityBuildings,
    collectResource,
    computeGoldAccrual,
    getResearchProductionBonusPct
};
