const db = require("../database/db");

// Must match the same constants in city.service.js
const STARTING_POPULATION = 200;
const WORKER_RATIO = 0.6;
const GOLD_PER_WORKER_PER_HOUR = 10;

// Rough placeholder: each unit of construction/upgrade level
// reserves this many workers until it completes.
const WORKERS_PER_LEVEL = 100;


// Locks and returns city_resources with elapsed production applied.
// Only gold (population/tax-driven) accrues continuously here —
// food/wood/stone/iron come from Resource Fields, which store their
// own production locally and require manual collection
// (see city.service.js collectResource / attachFieldStorage).
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


// How many workers are currently tied up in this city's active
// construction/upgrade queue.
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


// Builds a clear, specific message listing exactly which resources
// (and how much) are short, so the player can plan ahead rather than
// getting a flat "not enough resources".
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

    const client = await db.connect();

    try {

        await client.query("BEGIN");


        // Get current building by its specific instance id — not by
        // type, since a city can have multiple buildings of the same
        // type (e.g. two Barracks) and each needs to be targetable
        // individually.
        const buildingResult = await client.query(
            `
            SELECT *
            FROM city_buildings
            WHERE id = $1
            AND city_id = $2
            `,
            [
                buildingId,
                cityId
            ]
        );


        if (buildingResult.rows.length === 0) {
            throw new Error("Building not found");
        }


        const building = buildingResult.rows[0];
        const buildingTypeId = building.building_type_id;


        const nextLevel = building.level + 1;


        // Get upgrade cost
        const levelResult = await client.query(
            `
            SELECT *
            FROM building_levels
            WHERE building_type_id = $1
            AND level = $2
            `,
            [
                buildingTypeId,
                nextLevel
            ]
        );

        if (levelResult.rows.length === 0) {
            throw new Error("Maximum level reached");
        }


        // Capping non-Town-Hall building upgrades to the Town Hall's level
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


        // Get resources, with elapsed production settled first
        const resources = await getSettledResources(client, cityId);

        // Workers are a reusable resource: reserved while queued,
        // automatically freed when the queue item completes (since
        // it's simply removed from construction_queue).
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


        // Spend resources (absolute values, since we already settled
        // elapsed production above)
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


        // Create construction timer, reserving the workers it uses
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

    const client = await db.connect();

    try {

        await client.query("BEGIN");


        // Get building type definition
        const typeResult = await client.query(
            `
            SELECT *
            FROM building_types
            WHERE id = $1
            `,
            [
                buildingTypeId
            ]
        );

        if (typeResult.rows.length === 0) {
            throw new Error("Building type not found");
        }

        const buildingType = typeResult.rows[0];


        // Get all existing buildings in this city (with type info)
        const existingResult = await client.query(
            `
            SELECT cb.*, bt.slot_pool
            FROM city_buildings cb
            JOIN building_types bt
                ON cb.building_type_id = bt.id
            WHERE cb.city_id = $1
            `,
            [
                cityId
            ]
        );

        const existingBuildings = existingResult.rows;


        // Singleton check
        if (buildingType.is_unique) {
            const alreadyBuilt = existingBuildings.some(
                b => b.building_type_id === buildingType.id
            );
            if (alreadyBuilt) {
                throw new Error("This building is already built (only one allowed)");
            }
        }


        // Prerequisite building check
        if (buildingType.requires_building_id) {
            const hasPrereq = existingBuildings.some(
                b => b.building_type_id === buildingType.requires_building_id
            );
            if (!hasPrereq) {
                throw new Error("Required building not built yet");
            }
        }


        // Town Hall level check
        const townHall = existingBuildings.find(b => b.building_type_id === 1);
        const townHallLevel = townHall ? townHall.level : 1;

        if (buildingType.unlock_th_level && townHallLevel < buildingType.unlock_th_level) {
            throw new Error(`Requires Town Hall level ${buildingType.unlock_th_level}`);
        }


        // Wall level check
        const walls = existingBuildings.find(b => b.building_type_id === 3);
        const wallLevel = walls ? walls.level : 0;

        if (buildingType.unlock_wall_level && wallLevel < buildingType.unlock_wall_level) {
            throw new Error(`Requires Wall level ${buildingType.unlock_wall_level}`);
        }


        // Slot capacity check
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
                [
                    wallLevel
                ]
            );

            const capacity = capacityResult.rows.length > 0
                ? capacityResult.rows[0].capacity
                : 0;

            const fortUsed = existingBuildings.filter(b => b.slot_pool === "wall_fortification").length;

            if (fortUsed >= capacity) {
                throw new Error("No wall fortification capacity available");
            }
        }


        // Limit total additional buildings at Town Hall level 1
        if (townHallLevel === 1) {
            const additionalBuildingCount = existingBuildings.filter(b => b.building_type_id !== 1).length;
            if (additionalBuildingCount >= 3) {
                throw new Error("At Town Hall level 1, you can only have 3 additional buildings");
            }
        }


        // Get level 1 cost
        const levelResult = await client.query(
            `
            SELECT *
            FROM building_levels
            WHERE building_type_id = $1
            AND level = 1
            `,
            [
                buildingTypeId
            ]
        );

        if (levelResult.rows.length === 0) {
            throw new Error("Cost data not available for this building yet");
        }

        const cost = levelResult.rows[0];


        // Get resources, with elapsed production settled first
        const resources = await getSettledResources(client, cityId);

        // Workers are a reusable resource: reserved while queued,
        // automatically freed when the queue item completes.
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


        // Spend resources (absolute values, since we already settled
        // elapsed production above)
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


        // Create the building at level 0 (under construction) and
        // queue it to complete after build_seconds, reserving the
        // workers it uses
        const newBuildingResult = await client.query(
            `
            INSERT INTO city_buildings
            (city_id, building_type_id, level, position_x, position_y)
            VALUES ($1, $2, 0, 0, 0)
            RETURNING *
            `,
            [
                cityId,
                buildingTypeId
            ]
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

    const completedResult = await db.query(
        `
        SELECT *
        FROM construction_queue
        WHERE city_id = $1
        AND finish_time <= NOW()
        `,
        [
            cityId
        ]
    );

    for (const item of completedResult.rows) {

        await db.query(
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

        await db.query(
            `
            DELETE FROM construction_queue
            WHERE id = $1
            `,
            [
                item.id
            ]
        );
    }
}


async function getQueue(cityId) {

    const result = await db.query(
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
        [
            cityId
        ]
    );

    return result.rows;
}


async function getAvailableBuildings(cityId) {
    const client = await db.connect();
    try {
        // Fetch current buildings to determine TH Level, Wall level,
        // and built prerequisites
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

        // Get all building types unlockable at or below current TH level
        const availableTypesResult = await client.query(
            `
            SELECT bt.*, bl.food_cost, bl.wood_cost, bl.stone_cost, bl.iron_cost, bl.gold_cost, bl.build_seconds
            FROM building_types bt
            JOIN building_levels bl ON bt.id = bl.building_type_id AND bl.level = 1
            WHERE (bt.unlock_th_level IS NULL OR bt.unlock_th_level <= $1)
            `,
            [townHallLevel]
        );

        // Filter out singletons already constructed, buildings missing
        // their prerequisite, and buildings that need a higher Wall level
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

module.exports = {
    startUpgrade,
    constructBuilding,
    processCompletedConstruction,
    getQueue,
    getAvailableBuildings,
    getReservedWorkers
};
