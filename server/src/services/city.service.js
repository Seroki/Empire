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
            gold_remainder = $6,
            workers = $7,
            population = $8,
            updated_at = NOW(),
            gold_updated_at = NOW()
        WHERE city_id = $9
        `,
        [
            Math.floor(resources.food),
            Math.floor(resources.wood),
            Math.floor(resources.stone),
            Math.floor(resources.iron),
            Math.floor(resources.gold),
            resources.goldRemainder || 0,
            Math.floor(resources.workers),
            Math.floor(resources.population),
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


// NOTE: Confirmed dead code as of this diagnostic session — index.html's
// collectResource() action calls POST /buildings/collect/:cityId/:buildingId,
// which routes to building.service.js's collectResource (the version with
// valley/research/mayor bonuses correctly wired). Nothing in the frontend
// hits a route shaped to reach this function. Left in place rather than
// deleted pending confirmation no other route file references it — see
// open item "duplicate collectResource" in session handoff notes.
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


async function computeLiveResources(resources, buildings, cityId) {
    if (!resources || !resources.updated_at) return resources;

    const now = Date.now();
    const lastParsed = Date.parse(resources.updated_at);
    const last = Number.isNaN(lastParsed) ? now : lastParsed;
    const hoursElapsed = Math.max(0, (now - last) / 3600000);

    const { basePopulation, cottagesPopulation, totalPopulation } = computePopulation(buildings);
    const workers = Math.floor(cottagesPopulation * WORKER_RATIO) + STARTING_POPULATION;
    const taxRate = Number(resources.tax_rate) || 0;
    const currentGold = Number(resources.gold) || 0;

    // Gold uses its OWN dedicated clock (gold_updated_at), mirroring
    // building.service.js's getSettledResources and for the same reason:
    // updated_at gets bumped by THIS function's own saveResources() call on
    // every 5s refresh() poll from index.html, plus by unrelated spends
    // (research, training, upgrades). Using updated_at for gold's elapsed
    // time would collapse gold accrual toward zero on almost every call.
    const goldLastParsed = Date.parse(resources.gold_updated_at);
    const goldLast = Number.isNaN(goldLastParsed) ? now : goldLastParsed;
    const goldHoursElapsed = Math.max(0, (now - goldLast) / 3600000);

    // TAX_EFFICIENCY research bonus + the shared gold formula both now live
    // in building.service.js as the single source of truth, so this file
    // and building.service.js's getSettledResources can never drift apart
    // on how gold is computed again. computeGoldAccrual returns
    // { gold, goldRemainder } — NOT a plain number — because the gold
    // column is a bigint and truncating on every save would otherwise
    // silently discard the fractional gold earned each tick.
    const taxEfficiencyPct = await buildingService.getResearchProductionBonusPct(cityId, 'TAX_EFFICIENCY');
    const { gold, goldRemainder } = buildingService.computeGoldAccrual({
        currentGold,
        goldRemainder: Number(resources.gold_remainder) || 0,
        workers,
        taxRate,
        taxEfficiencyPct,
        hoursElapsed: goldHoursElapsed
    });

    return {
        ...resources,
        gold,
        goldRemainder,
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
    const liveResources = await computeLiveResources(rawResources, buildings, cityId);
    await saveResources(liveResources);

    const displayResources = {
        ...liveResources,
        food: Math.floor(Number(liveResources.food) || 0),
        wood: Math.floor(Number(liveResources.wood) || 0),
        stone: Math.floor(Number(liveResources.stone) || 0),
        iron: Math.floor(Number(liveResources.iron) || 0),
        gold: Math.floor(Number(liveResources.gold) || 0),
        cottageCap: liveResources.cottagesPopulation
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
// ============================================================================
// PLACEHOLDER LEVY POOL CONSTANTS — not balanced, just enough to make the
// system functional. Tune these once real numbers are decided.
// ============================================================================
const BASE_LEVY_CAP = 100;                       // levy pool ceiling, normal conditions
const LEVY_REFILL_PER_HOUR = 10;                 // levy points regenerated per hour, normal
const CALL_TO_ARMS_CAP_MULTIPLIER = 2;            // "expands your Levy cap"
const CALL_TO_ARMS_REFILL_MULTIPLIER = 2;         // "doubles refill speed"
const CALL_TO_ARMS_LOYALTY_DRAIN_PER_DAY = 5;     // "drains Loyalty ... daily"
const CALL_TO_ARMS_HAPPINESS_DRAIN_PER_DAY = 5;   // "drains ... Happiness daily"


/**
 * Settles pending gold accrual for a city and persists it, same
 * compute-then-save pattern getFullCityState already uses — just callable
 * standalone for places (like market.service.js) that need current gold
 * without loading the entire city state.
 */
async function resolveGoldIncome(cityId) {
    // No changes needed below — computeLiveResources now returns
    // goldRemainder on its result object, and saveResources persists it.
    const rawResources = await getResources(cityId);
    if (!rawResources) {
        throw new Error("City resources not found");
    }
    const buildings = await getBuildings(cityId);
    const liveResources = await computeLiveResources(rawResources, buildings, cityId);
    await saveResources(liveResources);
    return liveResources;
}


/**
 * Settles pending Levy Pool refill for a city and persists it. PLACEHOLDER
 * mechanics (see constants above) — refills linearly over time up to a cap,
 * both doubled while Call to Arms is active, which also drains Loyalty and
 * Happiness proportionally to time elapsed.
 */
async function resolveLevyPool(cityId) {
    const client = await db.connect();
    try {
        await client.query("BEGIN");

        const result = await client.query(
            `SELECT * FROM city_resources WHERE city_id = $1 FOR UPDATE`,
            [cityId]
        );
        if (result.rows.length === 0) {
            throw new Error("City resources not found");
        }
        const resources = result.rows[0];

        const now = Date.now();
        const lastParsed = Date.parse(resources.levy_updated_at);
        const last = Number.isNaN(lastParsed) ? now : lastParsed;
        const hoursElapsed = Math.max(0, (now - last) / 3600000);

        const callToArmsActive = Boolean(resources.call_to_arms_active);
        const levyCap = BASE_LEVY_CAP * (callToArmsActive ? CALL_TO_ARMS_CAP_MULTIPLIER : 1);
        const refillPerHour = LEVY_REFILL_PER_HOUR * (callToArmsActive ? CALL_TO_ARMS_REFILL_MULTIPLIER : 1);

        const currentLevyPool = Number(resources.levy_pool) || 0;
        const newLevyPool = Math.min(levyCap, currentLevyPool + refillPerHour * hoursElapsed);

        let newLoyalty = Number(resources.loyalty) || 0;
        let newHappiness = Number(resources.happiness) || 0;
        if (callToArmsActive) {
            newLoyalty = Math.max(0, newLoyalty - (CALL_TO_ARMS_LOYALTY_DRAIN_PER_DAY / 24) * hoursElapsed);
            newHappiness = Math.max(0, newHappiness - (CALL_TO_ARMS_HAPPINESS_DRAIN_PER_DAY / 24) * hoursElapsed);
        }

        const updateResult = await client.query(
            `
            UPDATE city_resources
            SET levy_pool = $1,
                levy_updated_at = NOW(),
                loyalty = $2,
                happiness = $3
            WHERE city_id = $4
            RETURNING *
            `,
            [Math.floor(newLevyPool), Math.round(newLoyalty), Math.round(newHappiness), cityId]
        );

        await client.query("COMMIT");

        return { ...updateResult.rows[0], levy_cap: levyCap };
    } catch (err) {
        await client.query("ROLLBACK");
        throw err;
    } finally {
        client.release();
    }
}


/**
 * Assigns a hero as this city's mayor, unsetting any previous mayor first
 * (only one mayor per city at a time — matches the Feasting Hall UI's
 * single-select radio button behavior).
 */
async function assignMayor(cityId, heroId) {
    const client = await db.connect();
    try {
        await client.query("BEGIN");

        const heroCheck = await client.query(
            `SELECT id FROM heroes WHERE id = $1 AND city_id = $2`,
            [heroId, cityId]
        );
        if (heroCheck.rows.length === 0) {
            throw new Error("Hero not found in this city");
        }

        await client.query(
            `UPDATE heroes SET is_mayor = false WHERE city_id = $1`,
            [cityId]
        );
        await client.query(
            `UPDATE heroes SET is_mayor = true WHERE id = $1`,
            [heroId]
        );

        await client.query("COMMIT");
        return { success: true, mayorId: heroId };
    } catch (err) {
        await client.query("ROLLBACK");
        throw err;
    } finally {
        client.release();
    }
}


async function getMayorPoliticsBuff(cityId) {
    const result = await db.query(
        `SELECT politics FROM heroes WHERE city_id = $1 AND is_mayor = true LIMIT 1`,
        [cityId]
    );
    const politics = Number(result.rows[0]?.politics) || 0;
    return 1 + (politics / 100);
}


/**
 * Releases a hero from active service — unassigns them from the city and
 * clears mayor status, but keeps the hero record itself (not a deletion).
 * The hero becomes available to be recruited/assigned again later.
 */
async function releaseHero(cityId, heroId) {
    const result = await db.query(
        `
        UPDATE heroes
        SET city_id = NULL,
            is_mayor = false,
            hired = false,
            status = 'RELEASED'
        WHERE id = $1 AND city_id = $2
        RETURNING id, name
        `,
        [heroId, cityId]
    );
    if (result.rows.length === 0) {
        throw new Error("Hero not found in this city");
    }
    return { success: true, released: result.rows[0] };
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
    getFullCityState,
    releaseHero,
    resolveGoldIncome,
    resolveLevyPool,
    assignMayor,
    getMayorPoliticsBuff
};
