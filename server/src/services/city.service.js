// ============================================================================
// FILE: src/services/city.service.js
// COMPLETE WORKING VERSION WITH RESEARCH INTEGRATION
// ============================================================================

const db = require("../database/db");
const buildingService = require("./building.service");
const playerService = require("./player.service");
const researchService = require("./research.service"); // <--- 1. IMPORT RESEARCH SERVICE

// Rough placeholders, to be balanced later.
// Must match the same constants in building.service.js.
const STARTING_POPULATION = 200;
const WORKER_RATIO = 0.6;
const GOLD_PER_WORKER_PER_HOUR = 10;

const FIELD_STORAGE_HOURS = 16;
const BASE_STOCKPILE_CAP = 10000;


async function getCity(cityId) {
    const result = await db.query(
        `SELECT * FROM cities WHERE id = $1`,
        [cityId]
    );
    if (result.rows.length === 0) {
        throw new Error("City not found");
    }
    return result.rows[0];
}


async function getResources(cityId) {
    const result = await db.query(
        `SELECT * FROM city_resources WHERE city_id = $1`,
        [cityId]
    );
    return result.rows[0];
}


async function saveResources(resources) {
    await db.query(
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
            resources.food,
            resources.wood,
            resources.stone,
            resources.iron,
            resources.gold,
            resources.workers,
            resources.population,
            resources.city_id
        ]
    );
}


async function updateCityName(cityId, name) {
    const trimmed = String(name || "").trim();
    if (trimmed.length < 1 || trimmed.length > 100) {
        throw new Error("City name must be between 1 and 100 characters");
    }
    const result = await db.query(
        `UPDATE cities SET name = $1 WHERE id = $2 RETURNING id, name`,
        [trimmed, cityId]
    );
    if (result.rows.length === 0) {
        throw new Error("City not found");
    }
    return result.rows[0];
}


async function setTaxRate(cityId, taxRate) {
    const clamped = Math.min(100, Math.max(0, Math.round(Number(taxRate))));
    await db.query(
        `UPDATE city_resources SET tax_rate = $1 WHERE city_id = $2`,
        [clamped, cityId]
    );
    return clamped;
}


async function getBuildings(cityId) {
    const result = await db.query(
        `
        SELECT
            cb.id,
            cb.city_id,
            cb.building_type_id,
            cb.level,
            cb.position_x,
            cb.position_y,
            cb.stored_resource,
            cb.last_collected_at,
            bt.name AS building_name,
            bt.slot_pool,
            bt.is_unique,
            COALESCE(bl.food_per_hour, 0) AS food_per_hour,
            COALESCE(bl.wood_per_hour, 0) AS wood_per_hour,
            COALESCE(bl.stone_per_hour, 0) AS stone_per_hour,
            COALESCE(bl.iron_per_hour, 0) AS iron_per_hour,
            COALESCE(bl.population_capacity, 0) AS population_capacity
        FROM city_buildings cb
        JOIN building_types bt
            ON bt.id = cb.building_type_id
        LEFT JOIN building_levels bl
            ON bl.building_type_id = cb.building_type_id
            AND bl.level = cb.level
        WHERE cb.city_id = $1
        ORDER BY cb.building_type_id
        `,
        [cityId]
    );

    return result.rows.map(attachFieldStorage);
}


function attachFieldStorage(building) {
    const rates = {
        food: Number(building.food_per_hour) || 0,
        wood: Number(building.wood_per_hour) || 0,
        stone: Number(building.stone_per_hour) || 0,
        iron: Number(building.iron_per_hour) || 0
    };

    const resourceType = Object.keys(rates).find(key => rates[key] > 0) || null;

    if (!resourceType || building.level === 0) {
        return { ...building, resource_type: null, field_storage: null };
    }

    const ratePerHour = rates[resourceType];
    const capacity = ratePerHour * FIELD_STORAGE_HOURS;

    const now = Date.now();
    const last = new Date(building.last_collected_at).getTime();
    const hoursElapsed = Math.max(0, (now - last) / 3600000);

    const accrued = Math.min(
        capacity,
        Number(building.stored_resource) + ratePerHour * hoursElapsed
    );

    return {
        ...building,
        resource_type: resourceType,
        field_storage: {
            stored: Math.floor(accrued),
            capacity: Math.floor(capacity),
            percent: capacity > 0 ? Math.min(100, Math.round((accrued / capacity) * 100)) : 0,
            full: accrued >= capacity
        }
    };
}


async function getStockpileCapacity(cityId) {
    const result = await db.query(
        `
        SELECT bl.storage_capacity
        FROM city_buildings cb
        JOIN building_levels bl
            ON bl.building_type_id = cb.building_type_id
            AND bl.level = cb.level
        WHERE cb.city_id = $1 AND cb.building_type_id = 11
        `,
        [cityId]
    );
    return result.rows.length > 0
        ? Number(result.rows[0].storage_capacity)
        : BASE_STOCKPILE_CAP;
}


async function collectResource(cityId, buildingId) {
    const client = await db.connect();

    try {
        await client.query("BEGIN");

        const buildingResult = await client.query(
            `
            SELECT cb.*, bl.food_per_hour, bl.wood_per_hour, bl.stone_per_hour, bl.iron_per_hour
            FROM city_buildings cb
            LEFT JOIN building_levels bl
                ON bl.building_type_id = cb.building_type_id
                AND bl.level = cb.level
            WHERE cb.id = $1 AND cb.city_id = $2
            FOR UPDATE OF cb
            `,
            [buildingId, cityId]
        );

        if (buildingResult.rows.length === 0) {
            throw new Error("Building not found");
        }

        const building = buildingResult.rows[0];
        const withStorage = attachFieldStorage(building);

        if (!withStorage.resource_type) {
            throw new Error("This building does not produce a collectible resource");
        }

        const collected = withStorage.field_storage.stored;

        if (collected <= 0) {
            throw new Error("Nothing to collect yet");
        }

        await client.query(
            `
            UPDATE city_resources
            SET ${withStorage.resource_type} = ${withStorage.resource_type} + $1,
                updated_at = NOW()
            WHERE city_id = $2
            `,
            [collected, cityId]
        );

        await client.query(
            `
            UPDATE city_buildings
            SET stored_resource = 0, last_collected_at = NOW()
            WHERE id = $1
            `,
            [buildingId]
        );

        await client.query("COMMIT");

        return {
            buildingId,
            resourceType: withStorage.resource_type,
            collected
        };

    } catch (error) {
        await client.query("ROLLBACK");
        throw error;
    } finally {
        client.release();
    }
}


function computePopulation(buildings) {
    const cottagesPopulation = buildings.reduce(
        (sum, b) => sum + (Number(b.population_capacity) || 0),
        0
    );
    const totalPopulation = cottagesPopulation + STARTING_POPULATION;
    return {
        basePopulation: STARTING_POPULATION,
        cottagesPopulation,
        totalPopulation
    };
}


function computeLiveResources(resources, buildings) {
    if (!resources || !resources.updated_at) return resources;

    const now = Date.now();
    const lastParsed = Date.parse(resources.updated_at);
    const last = Number.isNaN(lastParsed) ? now : lastParsed;
    const hoursElapsed = Math.max(0, (now - last) / 3600000);

    const { basePopulation, cottagesPopulation, totalPopulation } = computePopulation(buildings);
    
    const workers = Math.floor(cottagesPopulation * WORKER_RATIO) + STARTING_POPULATION;

    const taxRate = Number(resources.tax_rate) || 0;
    const currentGold = Number(resources.gold) || 0;
    const goldPH = workers * GOLD_PER_WORKER_PER_HOUR * (taxRate / 100);

    return {
        ...resources,
        gold: currentGold + goldPH * hoursElapsed,
        workers,
        population: totalPopulation,
        basePopulation,
        cottagesPopulation
    };
}


async function getSlots(cityId) {
    const buildings = await getBuildings(cityId);

    const townHall = buildings.find(b => b.building_type_id === 1);
    const townHallLevel = townHall ? townHall.level : 1;

    const innerTotal = 32;
    const outerTotal = Math.min(40, 13 + 3 * (townHallLevel - 1));

    const innerUsed = buildings.filter(b => b.slot_pool === "inner").length;
    const outerUsed = buildings.filter(b => b.slot_pool === "outer").length;

    return {
        inner: {
            used: innerUsed,
            total: innerTotal,
            available: innerTotal - innerUsed
        },
        outer: {
            used: outerUsed,
            total: outerTotal,
            available: outerTotal - outerUsed
        }
    };
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
    return buildingService.getAvailableBuildings(cityId);
}


async function processCompletedQueue(cityId) {
    return buildingService.processCompletedConstruction(cityId);
}


async function getFullCityState(cityId) {
    // 1. Process construction queue
    await processCompletedQueue(cityId);

    // Fetch player to resolve research
    const player = await playerService.getPlayerByCityId(cityId);

    // 2. LAZY RESOLVE RESEARCH QUEUE IF PLAYER EXISTS
    if (player && player.id) {
        await researchService.resolveCompletedResearch(player.id); // <--- 2. LAZY CHECK HERE
    }

    // 3. Fetch base components
    const city = await getCity(cityId);
    const rawResources = await getResources(cityId);
    const buildings = await getBuildings(cityId);

    // 4. Compute continuous live resources (gold accrual)
    const liveResources = computeLiveResources(rawResources, buildings);
    await saveResources(liveResources);

    const displayResources = {
        ...liveResources,
        food: Math.floor(Number(liveResources.food) || 0),
        wood: Math.floor(Number(liveResources.wood) || 0),
        stone: Math.floor(Number(liveResources.stone) || 0),
        iron: Math.floor(Number(liveResources.iron) || 0),
        gold: Math.floor(Number(liveResources.gold) || 0)
    };

    // 5. Fetch peripheral UI state
    const slots = await getSlots(cityId);
    const queue = await getQueue(cityId);
    const availableBuildings = await getAvailableBuildings(cityId);
    const stockpileCapacity = await getStockpileCapacity(cityId);

    // 6. Compute Warehouse Protected vs At-Risk amounts
    const totalStored = 
        displayResources.food +
        displayResources.wood +
        displayResources.stone +
        displayResources.iron +
        displayResources.gold;

    const warehouseProtected = Math.min(totalStored, stockpileCapacity);
    const warehouseAtRisk = Math.max(0, totalStored - stockpileCapacity);

    return {
        city,
        player,
        resources: displayResources,
        stockpileCapacity,
        warehouseStats: {
            capacity: stockpileCapacity,
            protected: warehouseProtected,
            atRisk: warehouseAtRisk,
            totalStored
        },
        buildings,
        slots,
        queue,
        availableBuildings
    };
}


module.exports = {
    STARTING_POPULATION,
    WORKER_RATIO,
    GOLD_PER_WORKER_PER_HOUR,
    FIELD_STORAGE_HOURS,
    BASE_STOCKPILE_CAP,
    getCity,
    getResources,
    saveResources,
    setTaxRate,
    updateCityName,
    getBuildings,
    attachFieldStorage,
    getStockpileCapacity,
    collectResource,
    computePopulation,
    computeLiveResources,
    getSlots,
    getQueue,
    getAvailableBuildings,
    processCompletedQueue,
    getFullCityState
};
