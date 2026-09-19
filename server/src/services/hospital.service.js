// ============================================================================
// FILE: src/services/hospital.service.js
// HOSPITAL / WOUNDED TROOP SERVICE
//
// State model for a city_wounded_troops row (no status column — state is
// derived from which timestamps are set, same convention this codebase
// already uses elsewhere, e.g. player_completed_research_nodes):
//   admitted_at IS NULL                              -> QUEUED (overflow grace window)
//   admitted_at IS NOT NULL, heal_complete_at IS NULL -> ADMITTED, awaiting payment
//   admitted_at IS NOT NULL, heal_complete_at IS NOT NULL -> HEALING
//
// PLACEHOLDERS — not balanced, flagged per this codebase's existing
// convention (see plunder.service.js's PLUNDER_PCT_PER_ATTACK, city.service.js's
// Levy pool constants):
//   HEAL_TIME_MULTIPLIER, HOSPITAL_LEVEL_HEAL_BONUS, HEAL_COST_GOLD_FRACTION,
//   OVERFLOW_GRACE_SECONDS, and the level*100 hospital_capacity migration.
// ============================================================================

const pool = require("../database/db");

const HEAL_TIME_MULTIPLIER = 3;           // heal time = 3x that unit's training time, at hospital lvl 1
const HOSPITAL_LEVEL_HEAL_BONUS = 0.05;   // +5% heal speed per hospital level
const HEAL_COST_GOLD_FRACTION = 0.5;      // heal costs 50% of the unit's training gold_cost, before HEALING_COST_REDUCTION
const OVERFLOW_GRACE_SECONDS = 1800;      // 30 minutes

/**
 * Current Hospital building level for a city, 0 if not built.
 */
async function getHospitalLevel(cityId) {
    const result = await pool.query(
        `SELECT cb.level FROM city_buildings cb WHERE cb.city_id = $1 AND cb.building_type_id = 25`,
        [cityId]
    );
    return result.rows.length > 0 ? result.rows[0].level : 0;
}

/**
 * Hospital's total wounded capacity at the city's current Hospital level.
 * 0 if no Hospital built (or level 0, which shouldn't exist but is defensive).
 */
async function getHospitalCapacity(cityId) {
    const level = await getHospitalLevel(cityId);
    if (level < 1) return 0;
    const result = await pool.query(
        `SELECT hospital_capacity FROM building_levels WHERE building_type_id = 25 AND level = $1`,
        [level]
    );
    return Number(result.rows[0]?.hospital_capacity || 0);
}

/**
 * Capacity currently occupied — includes ADMITTED (awaiting payment) rows,
 * not just actively HEALING ones, since a reserved-but-unpaid slot still
 * holds the space (by design — see session notes on manual pay-to-heal).
 */
async function getUsedCapacity(client, cityId) {
    const result = await client.query(
        `SELECT COALESCE(SUM(quantity), 0) AS used FROM city_wounded_troops
         WHERE city_id = $1 AND admitted_at IS NOT NULL`,
        [cityId]
    );
    return Number(result.rows[0].used);
}

/**
 * Called by combat resolution (npc.service.js, valley.service.js) whenever
 * troops that would otherwise be fully dead should instead have a chance
 * at recovery. Does NOT immediately admit to a hospital slot — that's
 * resolveHospitalQueue's job, called right after this on the same request
 * so an empty hospital doesn't force an unnecessary wait.
 */
async function queueWounded(cityId, unitTypeId, quantity, source) {
    if (quantity <= 0) return;
    await pool.query(
        `INSERT INTO city_wounded_troops (city_id, unit_type_id, quantity, source, expires_at)
         VALUES ($1, $2, $3, $4, NOW() + ($5 || ' seconds')::interval)`,
        [cityId, unitTypeId, quantity, source, OVERFLOW_GRACE_SECONDS]
    );
}

/**
 * Lazy resolve, same pattern as research.service.js's resolveCompletedResearch
 * and city.service.js's resolveLevyPool — called opportunistically whenever
 * a city's state is loaded. Three steps in order:
 *   1. Complete any HEALING rows whose timer has finished -> credit troops
 *      back to city_units, remove the row.
 *   2. With whatever capacity that just freed (plus any already free),
 *      promote QUEUED rows into ADMITTED, oldest first (partial admission
 *      if a batch is bigger than remaining capacity).
 *   3. Any QUEUED remainder past its expires_at is lost for good.
 */
async function resolveHospitalQueue(cityId) {
    const client = await pool.connect();
    try {
        await client.query("BEGIN");

        // 1. Complete healing
        const finishedResult = await client.query(
            `SELECT * FROM city_wounded_troops
             WHERE city_id = $1 AND heal_complete_at IS NOT NULL AND heal_complete_at <= NOW()
             FOR UPDATE`,
            [cityId]
        );
        for (const row of finishedResult.rows) {
            await client.query(
                `INSERT INTO city_units (city_id, unit_type_id, amount)
                 VALUES ($1, $2, $3)
                 ON CONFLICT (city_id, unit_type_id)
                 DO UPDATE SET amount = city_units.amount + EXCLUDED.amount`,
                [cityId, row.unit_type_id, row.quantity]
            );
            await client.query(`DELETE FROM city_wounded_troops WHERE id = $1`, [row.id]);
        }

        // 2. Promote queued overflow into freed capacity, oldest first
        const capacity = await getHospitalCapacity(cityId);
        let used = await getUsedCapacity(client, cityId);
        let remaining = Math.max(0, capacity - used);

        if (remaining > 0) {
            const queuedResult = await client.query(
                `SELECT * FROM city_wounded_troops
                 WHERE city_id = $1 AND admitted_at IS NULL
                 ORDER BY created_at ASC
                 FOR UPDATE`,
                [cityId]
            );

            for (const row of queuedResult.rows) {
                if (remaining <= 0) break;

                if (row.quantity <= remaining) {
                    // Whole batch fits — admit it as-is.
                    await client.query(
                        `UPDATE city_wounded_troops SET admitted_at = NOW(), expires_at = NULL WHERE id = $1`,
                        [row.id]
                    );
                    remaining -= row.quantity;
                } else {
                    // Partial admission: split the row. Admitted portion
                    // becomes its own row; the rest stays queued under the
                    // original expires_at.
                    await client.query(
                        `UPDATE city_wounded_troops SET quantity = quantity - $1 WHERE id = $2`,
                        [remaining, row.id]
                    );
                    await client.query(
                        `INSERT INTO city_wounded_troops (city_id, unit_type_id, quantity, source, admitted_at)
                         VALUES ($1, $2, $3, $4, NOW())`,
                        [cityId, row.unit_type_id, remaining, row.source]
                    );
                    remaining = 0;
                }
            }
        }

        // 3. Anything still queued past its grace window is lost.
        await client.query(
            `DELETE FROM city_wounded_troops
             WHERE city_id = $1 AND admitted_at IS NULL AND expires_at <= NOW()`,
            [cityId]
        );

        await client.query("COMMIT");
    } catch (err) {
        await client.query("ROLLBACK");
        throw err;
    } finally {
        client.release();
    }
}

/**
 * Full wounded roster for a city, split by state, for the hospital UI.
 * Call resolveHospitalQueue(cityId) first (route layer's job) so this
 * always reflects current reality rather than stale timers.
 */
async function getWoundedRoster(cityId) {
    const result = await pool.query(
        `SELECT wt.*, ut.name AS unit_name, ut.code AS unit_code
         FROM city_wounded_troops wt
         JOIN unit_types ut ON ut.id = wt.unit_type_id
         WHERE wt.city_id = $1
         ORDER BY wt.created_at ASC`,
        [cityId]
    );
    return result.rows.map(row => ({
        ...row,
        status: row.admitted_at === null ? 'QUEUED' : (row.heal_complete_at === null ? 'ADMITTED' : 'HEALING')
    }));
}

/**
 * Gold cost to heal one ADMITTED (not yet healing) wounded batch, after
 * HEALING_COST_REDUCTION research. Reuses building.service.js's
 * getResearchProductionBonusPct rather than re-querying player_bonus_totals
 * directly, so this can never drift from how every other bonus is read.
 */
async function getHealCost(cityId, woundedId) {
    const buildingService = require("./building.service");

    const woundedResult = await pool.query(
        `SELECT wt.*, ut.gold_cost FROM city_wounded_troops wt
         JOIN unit_types ut ON ut.id = wt.unit_type_id
         WHERE wt.id = $1 AND wt.city_id = $2`,
        [woundedId, cityId]
    );
    if (woundedResult.rows.length === 0) {
        throw new Error("Wounded batch not found");
    }
    const wounded = woundedResult.rows[0];
    if (wounded.admitted_at === null) {
        throw new Error("This batch hasn't been admitted to the hospital yet — no hospital slot available.");
    }
    if (wounded.heal_complete_at !== null) {
        throw new Error("This batch is already healing.");
    }

    const healingCostReductionPct = await buildingService.getResearchProductionBonusPct(cityId, 'HEALING_COST_REDUCTION');
    const baseCost = wounded.quantity * Number(wounded.gold_cost) * HEAL_COST_GOLD_FRACTION;
    const actualCost = Math.round(baseCost * (1 - healingCostReductionPct));

    return { woundedId, quantity: wounded.quantity, baseCost, healingCostReductionPct, actualCost };
}

/**
 * Player-initiated: pay to start healing an ADMITTED batch. Manual by
 * design — a batch can sit admitted (occupying a hospital slot) indefinitely
 * until the player chooses to pay, which is itself a real resource decision,
 * not an oversight.
 */
async function startHealing(cityId, woundedId) {
    const cityService = require("./city.service");
    const buildingService = require("./building.service");

    const { actualCost, quantity } = await getHealCost(cityId, woundedId);

    const client = await pool.connect();
    try {
        await client.query("BEGIN");

        const resResult = await client.query(
            `SELECT * FROM city_resources WHERE city_id = $1 FOR UPDATE`,
            [cityId]
        );
        const resources = resResult.rows[0];
        if (Number(resources.gold) < actualCost) {
            throw new Error(`Not enough gold to heal. Need ${actualCost}, have ${Math.floor(resources.gold)}.`);
        }

        await client.query(
            `UPDATE city_resources SET gold = gold - $1, updated_at = NOW() WHERE city_id = $2`,
            [actualCost, cityId]
        );

        const woundedResult = await client.query(
            `SELECT wt.*, ut.base_training_seconds FROM city_wounded_troops wt
             JOIN unit_types ut ON ut.id = wt.unit_type_id
             WHERE wt.id = $1 AND wt.city_id = $2 FOR UPDATE`,
            [woundedId, cityId]
        );
        const wounded = woundedResult.rows[0];

        const hospitalLevel = await getHospitalLevel(cityId);
        const healSeconds = Math.round(
            Number(wounded.base_training_seconds) * HEAL_TIME_MULTIPLIER /
            (1 + hospitalLevel * HOSPITAL_LEVEL_HEAL_BONUS)
        );

        await client.query(
            `UPDATE city_wounded_troops SET heal_complete_at = NOW() + ($1 || ' seconds')::interval WHERE id = $2`,
            [healSeconds, woundedId]
        );

        await client.query("COMMIT");
        return { woundedId, cost: actualCost, healSeconds };
    } catch (err) {
        await client.query("ROLLBACK");
        throw err;
    } finally {
        client.release();
    }
}

module.exports = {
    HEAL_TIME_MULTIPLIER,
    HOSPITAL_LEVEL_HEAL_BONUS,
    HEAL_COST_GOLD_FRACTION,
    OVERFLOW_GRACE_SECONDS,
    getHospitalLevel,
    getHospitalCapacity,
    queueWounded,
    resolveHospitalQueue,
    getWoundedRoster,
    getHealCost,
    startHealing
};
