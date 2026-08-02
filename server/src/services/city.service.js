// ============================================================================
// FILE: src/services/city.service.js
// CITY SERVICE ONLY (NO RESEARCH, NO ROUTES)
// ============================================================================

const pool = require("../database/db");
const buildingService = require("./building.service");
const playerService = require("./player.service");
const researchService = require("./research.service");

// Rough placeholders, to be balanced later.
// Must match the same constants in building.service.js.
const STARTING_POPULATION = 200;
const WORKER_RATIO = 0.6;
const GOLD_PER_WORKER_PER_HOUR = 10;

const FIELD_STORAGE_HOURS = 16;
const BASE_STOCKPILE_CAP = 10000;

async function getCity(cityId) {
    const result = await pool.query(
        `SELECT * FROM cities WHERE id = $1`,
        [cityId]
    );
    if (result.rows.length === 0) {
        throw new Error("City not found");
    }
    return result.rows[0];
}

async function getResources(cityId) {
    const result = await pool.query(
        `SELECT * FROM city_resources WHERE city_id = $1`,
        [cityId]
    );
    return result.rows[0];
}

// Minimal working version so GUI can load a city.
// You can expand this later to include buildings, workforce, etc.
async function getFullCityState(cityId) {
    // Settle any construction/upgrades whose timer has already elapsed
    // before we read the queue, so we don't report stale "in progress" items.
    await buildingService.processCompletedConstruction(cityId);

    const city = await getCity(cityId);
    const resources = await getResources(cityId);

    // Calculate total Warehouse capacity across all built Warehouses in this city
    const warehouseRes = await pool.query(
        `
        SELECT COALESCE(SUM(bl.storage_capacity), $2) AS warehouse_capacity
        FROM city_buildings cb
        JOIN building_types bt ON cb.building_type_id = bt.id
        JOIN building_levels bl ON bl.building_type_id = cb.building_type_id AND bl.level = cb.level
        WHERE cb.city_id = $1 AND bt.name = 'Warehouse'
        `,
        [cityId, BASE_STOCKPILE_CAP]
    );

    const warehouseCapacity = Number(warehouseRes.rows[0]?.warehouse_capacity || BASE_STOCKPILE_CAP);

    // Total current stockpile across all 5 resource types. Note this is NOT
    // capped by warehouse_capacity — you can hold more than you can protect,
    // the excess is just exposed to raids.
    const totalResources =
        Number(resources.food || 0) +
        Number(resources.wood || 0) +
        Number(resources.stone || 0) +
        Number(resources.iron || 0) +
        Number(resources.gold || 0);

    const protectedResources = Math.min(totalResources, warehouseCapacity);
    const atRiskResources = Math.max(0, totalResources - warehouseCapacity);

    const queue = await buildingService.getQueue(cityId);
    const availableToBuild = await buildingService.getAvailableBuildings(cityId);

    return {
        city,
        resources: {
            ...resources,
            warehouse_capacity: warehouseCapacity,
            protected_resources: protectedResources,
            at_risk_resources: atRiskResources
        },
        queue,
        availableToBuild
    };
}

async function updateCityName(cityId, name) {
    if (!name || !name.trim()) {
        throw new Error("City name cannot be empty");
    }

    const result = await pool.query(
        `UPDATE cities SET name = $1 WHERE id = $2 RETURNING *`,
        [name.trim(), cityId]
    );

    if (result.rows.length === 0) {
        throw new Error("City not found");
    }

    return result.rows[0];
}

async function setTaxRate(cityId, taxRate) {
    const rate = Number(taxRate);

    if (Number.isNaN(rate) || rate < 0 || rate > 100) {
        throw new Error("Tax rate must be between 0 and 100");
    }

    const result = await pool.query(
        `
        UPDATE city_resources
        SET tax_rate = $1, updated_at = NOW()
        WHERE city_id = $2
        RETURNING tax_rate
        `,
        [rate, cityId]
    );

    if (result.rows.length === 0) {
        throw new Error("City not found");
    }

    return Number(result.rows[0].tax_rate);
}

module.exports = {
    getCity,
    getResources,
    getFullCityState,
    updateCityName,
    setTaxRate
};

