const pool = require("../database/db");

// Must match the same constants in city.service.js
const STARTING_POPULATION = 200;
const WORKER_RATIO = 0.6;
const GOLD_PER_WORKER_PER_HOUR = 10;

// Rough placeholder: each unit of construction/upgrade level
// reserves this many workers until it completes.
const WORKERS_PER_LEVEL = 100;

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
        JOIN building_levels bl
            ON bl.building_type_id = cb.building_type_id
            AND bl.level = cb.level
        WHERE cb.city_id = $1
        `,
        [cityId]
    );

    const rates = rateResult.rows[0];

    const totalPopulation = STARTING_POPULATION + Number(rates.cottages_population);
    const workers = Math.floor(totalPopulation * WORKER_RATIO);
    const taxRate = Number(resources.tax_rate) || 0;

    const now = Date.now();
    const last = new Date(resources.updated_at).getTime();
    const hoursElapsed = Math.max(0, (now - last) / 3600000);

    return {
        ...resources,
        food: Number(resources.food),
        wood: Number(resources.wood),
        stone: Number(resources.stone),
        iron: Number(resources.iron),
        gold: Number(resources.gold) + workers * GOLD_PER_WORKER_PER_HOUR * (taxRate / 100) * hoursElapsed,
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
                workers = $6,
                population = $7,
                updated_at = NOW()
            WHERE city_id = $8
            `,
            [
                resources.food - upgrade.food_cost,
                resources.wood - upgrade.wood_cost,
                resources.stone - upgrade.stone_cost,
                resources.iron - upgrade.iron_cost,
                resources.gold - upgrade.gold_cost,
                resources.workers,
                resources.population,
                cityId
            ]
        );

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
                upgrade.build_seconds,
                workerCost
            ]
        );

        await client.query("COMMIT");

        return {
            building: buildingId,
            oldLevel: building.level,
            newLevel: nextLevel,
            finishesIn: upgrade.build_seconds,
            workersReserved: workerCost
        };

    } catch(error) {
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

        if (buildingType.requires_building_id) {
            const hasPrereq = existingBuildings.some(
                b => b.building_type_id === buildingType.requires_building_id
            );
            if (!hasPrereq) {
                throw new Error("Required building not built yet");
            }
        }

        const townHall = existingBuildings.find(b => b.building_type_id === 1);
        const townHallLevel = townHall ? townHall.level : 1;

        if (buildingType.unlock_th_level && townHallLevel < buildingType.unlock_th_level) {
            throw new Error(`Requires Town Hall level ${buildingType.unlock_th_level}`);
        }

        const walls = existingBuildings.find(b => b.building_type_id === 3);
        const wallLevel = walls ? walls.level : 0;

        if (buildingType.unlock_wall_level && wallLevel < buildingType.unlock_wall_level) {
            throw new Error(`Requires Wall level ${buildingType.unlock_wall_level}`);
        }

        if (buildingType.slot_pool === "inner") {
            const innerUsed = existingBuildings.filter(b => b.slot_pool === "inner").length;
            if (innerUsed >= 32) {
                throw new Error("No inner city slots available");
            }
        } else if (buildingType.slot_pool === "outer") {
            const outerTotal = Math.min(40, 13 + 3 * (townHallLevel - 1));
            const outerUsed = existingBuildings.filter(b => b.slot_pool === "outer").length;
            if (outerUsed >= outerTotal) {
                throw new Error("No outer field slots available");
            }
        } else if (buildingType.slot_pool === "wall_fortification") {
            const capacityResult = await client.query(
                `
                SELECT capacity
                FROM wall_fortification_capacity
                WHERE wall_level = $1
                `,
                [wallLevel]
            );

            const capacity = capacityResult.rows.length > 0
                ? capacityResult.rows[0].capacity
                : 0;

            const fortUsed = existingBuildings.filter(b => b.slot_pool === "wall_fortification").length;

            if (fortUsed >= capacity) {
                throw new Error("No wall fortification capacity available");
            }
        }

        if (townHallLevel === 1) {
            const additionalBuildingCount = existingBuildings.filter(b => b.building_type_id !== 1).length;
            if (additionalBuildingCount >= 3) {
                throw new Error("At Town Hall level 1, you can only have 3 additional buildings");
            }
        }

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
                workers = $6,
                population = $7,
                updated_at = NOW()
            WHERE city_id = $8
            `,
            [
                resources.food - cost.food_cost,
                resources.wood - cost.wood_cost,
                resources.stone - cost.stone_cost,
                resources.iron - cost.iron_cost,
                resources.gold - cost.gold_cost,
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

        await client.query(
            `
            INSERT INTO construction_queue
            (city_id, building_id, target_level, finish_time, workers_used)
            VALUES ($1, $2, 1, NOW() + ($3 || ' seconds')::interval, $4)
            `,
            [
                cityId,
                newBuilding.id,
                cost.build_seconds,
                workerCost
            ]
        );

        await client.query("COMMIT");

        return {
            building: newBuilding,
            name: buildingType.name,
            finishesIn: cost.build_seconds,
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
            cb.id AS building_id,
            cb.building_type_id,
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

        const buildable = availableTypesResult.rows.filter(bt => {
            if (bt.is_unique && builtTypeIds.has(bt.id)) return false;
            if (bt.requires_building_id && !builtTypeIds.has(bt.requires_building_id)) return false;
            if (bt.unlock_wall_level && wallLevel < bt.unlock_wall_level) return false;
            return true;
        });

        return buildable;
    } finally {
        client.release();
    }
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

        // 2. Calculate elapsed production
        const now = Date.now();
        const lastCollected = new Date(building.last_collected_at || building.created_at || now).getTime();
        const hoursElapsed = Math.max(0, (now - lastCollected) / 3600000);

        const prodRate = Number(
            building.food_per_hour || 
            building.wood_per_hour || 
            building.stone_per_hour || 
            building.iron_per_hour || 
            building.gold_per_hour || 
            (building.level || 1) * 100
        );

        const fieldCap = Number(building.field_capacity) || 10000;
        const totalAccrued = Math.min(
            Math.round(Number(building.stored_resource || 0) + (hoursElapsed * prodRate)),
            fieldCap
        );

        if (totalAccrued <= 0) {
            throw new Error("No resources available to collect yet");
        }

        // 3. Map building name to target resource type in city_resources
        let resourceType = 'food';
        const nameLower = building.building_name.toLowerCase();
        if (nameLower.includes('sawmill') || nameLower.includes('wood')) resourceType = 'wood';
        else if (nameLower.includes('quarry') || nameLower.includes('stone')) resourceType = 'stone';
        else if (nameLower.includes('iron')) resourceType = 'iron';
        else if (nameLower.includes('mine') || nameLower.includes('gold')) resourceType = 'gold';

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
        const newAmount = Math.min(currentAmount + totalAccrued, warehouseCap);
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
            warehouseCap
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

    const now = Date.now();

    return result.rows.map(b => {
        if (b.slot_pool === 'outer') {
            // Determine production rate based on whichever resource column is non-zero
            const prodRate = Number(
                b.food_per_hour || 
                b.wood_per_hour || 
                b.stone_per_hour || 
                b.iron_per_hour || 
                b.gold_per_hour || 
                (b.level || 1) * 100 // Safe fallback
            );

            const lastCollected = new Date(b.last_collected_at || b.created_at || now).getTime();
            const hoursElapsed = Math.max(0, (now - lastCollected) / 3600000);
            
            const maxCap = Number(b.storage_capacity) || 10000;
            const accumulated = Number(b.stored_resource || 0) + (hoursElapsed * prodRate);

            return {
                ...b,
                production_rate: prodRate,
                max_capacity: maxCap,
                stored_resource: Math.min(Math.round(accumulated), maxCap)
            };
        }
        return b;
    });
}

module.exports = {
    startUpgrade,
    constructBuilding,
    processCompletedConstruction,
    getQueue,
    getAvailableBuildings,
    getReservedWorkers,
    getCityBuildings,
    collectResource
};