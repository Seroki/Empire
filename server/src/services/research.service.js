// ============================================================================
// FILE: src/services/research.service.js
// RESEARCH SERVICE — Tier I Research System (v1.3)
// ============================================================================

const pool = require("../database/db");

// ----------------------------------------------------------------------------
// Tier I Tech Definitions
// Source: Tier I Research System (v1.3) design doc.
// All Tier I techs have 10 levels. Most bonuses scale at +6%/level (noted
// per-tech where the doc gives a different rate, e.g. Stockpile +12%,
// Machinery +10%).
//
// ASSUMPTION FLAGGED: the doc specifies bonus/time-reduction formulas per
// level, but does NOT specify the resource-cost curve for researching a tech,
// or the base research time per tech. Both are estimated below using the
// same 1.6x-per-level growth curve as a starting point — tune baseCost /
// baseTimeSeconds per tech once you have real numbers in mind.
// ----------------------------------------------------------------------------

const TECH_DEFINITIONS = {
  // --- Economy ---------------------------------------------------------
  AGRICULTURE: {
    name: "Agriculture",
    description: "Improves food production across your empire.",
    discipline: "economy",
    maxLevel: 10,
    requiredAcademyLevel: 1,
    prerequisite: null,
    effect: { type: "food_production_pct", perLevel: 0.06 },
    baseCost: { food: 0, wood: 200, stone: 150, iron: 50, gold: 0 },
    baseTimeSeconds: 300
  },
  LUMBERING: {
    name: "Lumbering",
    description: "Improves wood production across your empire.",
    discipline: "economy",
    maxLevel: 10,
    requiredAcademyLevel: 1,
    prerequisite: null,
    effect: { type: "wood_production_pct", perLevel: 0.06 },
    baseCost: { food: 200, wood: 0, stone: 150, iron: 50, gold: 0 },
    baseTimeSeconds: 300
  },
  MASONRY: {
    name: "Masonry",
    description: "Improves stone production across your empire.",
    discipline: "economy",
    maxLevel: 10,
    requiredAcademyLevel: 1,
    prerequisite: null,
    effect: { type: "stone_production_pct", perLevel: 0.06 },
    baseCost: { food: 200, wood: 150, stone: 0, iron: 50, gold: 0 },
    baseTimeSeconds: 300
  },
  MINING: {
    name: "Mining",
    description: "Improves iron production across your empire.",
    discipline: "economy",
    maxLevel: 10,
    requiredAcademyLevel: 1,
    prerequisite: null,
    effect: { type: "iron_production_pct", perLevel: 0.06 },
    baseCost: { food: 200, wood: 150, stone: 150, iron: 0, gold: 0 },
    baseTimeSeconds: 300
  },
  STOCKPILE: {
    name: "Stockpile",
    description: "Increases the amount of resources protected from raids.",
    discipline: "economy",
    maxLevel: 10,
    requiredAcademyLevel: 1,
    prerequisite: { tech: "AGRICULTURE", level: 2 },
    effect: { type: "protected_storage_pct", perLevel: 0.12 },
    baseCost: { food: 300, wood: 300, stone: 300, iron: 100, gold: 0 },
    baseTimeSeconds: 450
  },

  // --- Construction ------------------------------------------------------
  CONSTRUCTION: {
    name: "Construction",
    description: "Reduces building construction time.",
    discipline: "construction",
    maxLevel: 10,
    requiredAcademyLevel: 1,
    prerequisite: { tech: "MASONRY", level: 3 },
    effect: { type: "build_time_pct", perLevel: -0.06 },
    baseCost: { food: 300, wood: 400, stone: 400, iron: 150, gold: 0 },
    baseTimeSeconds: 500
  },

  // --- Military ------------------------------------------------------
  MILITARY_SCIENCE: {
    name: "Military Science",
    description: "Reduces unit training time and determines the highest training quality your Barracks can produce (Novice / Trained / Expert / Elite).",
    discipline: "military",
    maxLevel: 10,
    requiredAcademyLevel: 2,
    prerequisite: null,
    effect: { type: "training_time_pct", perLevel: -0.06 },
    unlocks: ["ARCHERY", "HORSEBACK_RIDING"],
    baseCost: { food: 300, wood: 300, stone: 200, iron: 200, gold: 50 },
    baseTimeSeconds: 500
  },
  MILITARY_TRADITION: {
    name: "Military Tradition",
    description: "Increases unit attack.",
    discipline: "military",
    maxLevel: 10,
    requiredAcademyLevel: 1,
    prerequisite: { tech: "MILITARY_SCIENCE", level: 2 },
    effect: { type: "attack_pct", perLevel: 0.06 },
    baseCost: { food: 300, wood: 200, stone: 200, iron: 300, gold: 50 },
    baseTimeSeconds: 500
  },
  IRONWORKING: {
    name: "Ironworking",
    description: "Increases unit defense and unlocks Heavy Infantry.",
    discipline: "military",
    maxLevel: 10,
    requiredAcademyLevel: 1,
    prerequisite: { tech: "MINING", level: 3 },
    effect: { type: "defense_pct", perLevel: 0.06 },
    unlocksUnit: "HEAVY_INFANTRY",
    baseCost: { food: 300, wood: 200, stone: 200, iron: 350, gold: 50 },
    baseTimeSeconds: 500
  },
  ARCHERY: {
    name: "Archery",
    description: "Increases ranged unit range and unlocks the Archer.",
    discipline: "military",
    maxLevel: 10,
    requiredAcademyLevel: 1,
    prerequisite: { tech: "MILITARY_SCIENCE", level: 3 },
    effect: { type: "range_pct", perLevel: 0.06 },
    unlocksUnit: "ARCHER",
    baseCost: { food: 300, wood: 350, stone: 150, iron: 200, gold: 50 },
    baseTimeSeconds: 550
  },
  HORSEBACK_RIDING: {
    name: "Horseback Riding",
    description: "Increases mounted unit speed and unlocks Cavalry.",
    discipline: "military",
    maxLevel: 10,
    requiredAcademyLevel: 1,
    prerequisite: { tech: "MILITARY_SCIENCE", level: 3 },
    effect: { type: "mounted_speed_pct", perLevel: 0.06 },
    unlocksUnit: "CAVALRY",
    baseCost: { food: 350, wood: 300, stone: 150, iron: 200, gold: 50 },
    baseTimeSeconds: 550
  },
  METAL_CASTING: {
    name: "Metal Casting",
    description: "Increases siege unit attack and unlocks the Catapult.",
    discipline: "military",
    maxLevel: 10,
    requiredAcademyLevel: 1,
    prerequisite: { tech: "MINING", level: 4 },
    effect: { type: "siege_attack_pct", perLevel: 0.06 },
    unlocksUnit: "CATAPULT",
    baseCost: { food: 300, wood: 300, stone: 300, iron: 400, gold: 100 },
    baseTimeSeconds: 600
  },
  ENGINEERING: {
    name: "Engineering",
    description: "Increases siege unit HP and unlocks the Battering Ram.",
    discipline: "military",
    maxLevel: 10,
    requiredAcademyLevel: 1,
    prerequisite: { tech: "METAL_CASTING", level: 2 },
    effect: { type: "siege_hp_pct", perLevel: 0.06 },
    unlocksUnit: "BATTERING_RAM",
    baseCost: { food: 300, wood: 350, stone: 300, iron: 400, gold: 100 },
    baseTimeSeconds: 650
  },

  // --- Intelligence ------------------------------------------------------
  INFORMATICS: {
    name: "Informatics",
    description: "Increases Scout detection, stealth, and recon accuracy. Unlocks the Scout and determines how deep your recon reports go.",
    discipline: "intelligence",
    maxLevel: 10,
    requiredAcademyLevel: 1,
    prerequisite: null,
    effect: { type: "scout_vision_stealth_detection_pct", perLevel: 0.06 },
    unlocksUnit: "SCOUT",
    baseCost: { food: 200, wood: 200, stone: 100, iron: 150, gold: 0 },
    baseTimeSeconds: 350
  },
  BEACON_TOWER: {
    name: "Beacon Tower",
    description: "Provides early warning of incoming marches, with more detail at higher levels.",
    discipline: "intelligence",
    maxLevel: 10,
    requiredAcademyLevel: 1,
    prerequisite: { tech: "INFORMATICS", level: 2 },
    effect: { type: "march_detection_bonus", perLevel: 1 },
    baseCost: { food: 250, wood: 250, stone: 150, iron: 150, gold: 0 },
    baseTimeSeconds: 400
  },

  // --- Movement ------------------------------------------------------
  COMPASS: {
    name: "Compass",
    description: "Increases infantry march speed.",
    discipline: "movement",
    maxLevel: 10,
    requiredAcademyLevel: 1,
    prerequisite: { tech: "HORSEBACK_RIDING", level: 3 },
    effect: { type: "infantry_speed_pct", perLevel: 0.06 },
    baseCost: { food: 300, wood: 300, stone: 200, iron: 200, gold: 50 },
    baseTimeSeconds: 500
  },

  // --- Defense ------------------------------------------------------
  MACHINERY: {
    name: "Machinery",
    description: "Increases wall repair rate.",
    discipline: "defense",
    maxLevel: 10,
    requiredAcademyLevel: 1,
    prerequisite: { tech: "ENGINEERING", level: 3 },
    effect: { type: "wall_repair_rate_pct", perLevel: 0.10 },
    baseCost: { food: 300, wood: 300, stone: 400, iron: 300, gold: 50 },
    baseTimeSeconds: 550
  }
};

// Doctrine tiers unlocked by Military Science level (Training Quality Standard).
const TRAINING_QUALITY_TIERS = [
  { minLevel: 9, tier: "elite", bonusPct: 0.20 },
  { minLevel: 6, tier: "expert", bonusPct: 0.15 },
  { minLevel: 3, tier: "trained", bonusPct: 0.10 },
  { minLevel: 1, tier: "novice", bonusPct: 0 }
];

const WORKERS_PER_LEVEL = 100;

// City's Academy caps how much of a global tech level is actually usable
// in that city.
function getEffectiveTechLevel(globalLevel, academyLevel) {
  return Math.min(Number(globalLevel || 0), Number(academyLevel || 0));
}

// ASSUMPTION: cost curve not specified in the design doc. Using the same
// 1.6x-per-level growth as the time curve below. Tune per-tech baseCost or
// this exponent once real balance numbers exist.
function calculateTechCost(baseAmount, level) {
  if (!baseAmount) return 0;
  return Math.round(baseAmount * Math.pow(1.6, Math.max(0, level - 1)));
}

// Research Time Formula (per doc):
// ActualTime = BaseTime / (1 + MayorINT/100) × 0.95^(AcademyLevel − 1)
// ASSUMPTION: BaseTime here is scaled per-level using the same curve as
// cost, since the doc only gives the modifier formula, not how BaseTime
// itself grows across a tech's 10 levels.
function calculateResearchTime(baseTimeSeconds, level, academyLevel, mayorInt = 0) {
  const scaledBaseTime = baseTimeSeconds * Math.pow(1.6, Math.max(0, level - 1));
  const intFactor = 1 + (Number(mayorInt || 0) / 100);
  const academyFactor = Math.pow(0.95, Math.max(0, Number(academyLevel || 1) - 1));
  return Math.round((scaledBaseTime / intFactor) * academyFactor);
}

// Which training quality tier a city's Military Science level unlocks.
function getTrainingQualityTier(militaryScienceLevel) {
  const level = Number(militaryScienceLevel || 0);
  const match = TRAINING_QUALITY_TIERS.find(t => level >= t.minLevel);
  return match || { tier: "novice", bonusPct: 0 };
}

async function getPlayerResearchLevels(playerId) {
    const result = await pool.query(
        `SELECT tech_code, level
         FROM player_researches
         WHERE player_id = $1`,
        [playerId]
    );

    const research = {};
    result.rows.forEach(r => {
        research[r.tech_code] = r.level;
    });

    return research;
}

function calculateCityLabor(population, buildings) {
    const workersUsed = (buildings || []).reduce((total, b) => {
        if (!b.level || b.level <= 0) return total;
        return total + (b.level * WORKERS_PER_LEVEL);
    }, 0);

    const idleWorkers = Math.max(0, population - workersUsed);

    return { workersUsed, idleWorkers };
}

/**
 * Validate and start research on a tech for a player.
 *
 * Schema confirmed: research_queue(player_id, city_id, tech_code,
 * target_level, start_time, finish_time, status) and player_researches
 * (player_id, tech_code, level, updated_at) with a unique constraint on
 * (player_id, tech_code). research_queue also has a partial unique index
 * on player_id WHERE status = 'IN_PROGRESS', so the DB itself enforces
 * one active research per player as a backstop to the app-level check below.
 */
async function startResearch(playerId, cityId, techCode, targetLevel) {
  const techDef = TECH_DEFINITIONS[techCode];
  if (!techDef) {
    throw new Error(`Unknown technology: ${techCode}`);
  }
  if (targetLevel < 1 || targetLevel > techDef.maxLevel) {
    throw new Error(`${techDef.name} only has levels 1–${techDef.maxLevel}.`);
  }

  const client = await pool.connect();
  try {
    await client.query("BEGIN");

    // 1. Must not already have an active research project.
    const activeRes = await client.query(
      `SELECT * FROM research_queue WHERE player_id = $1 AND status = 'IN_PROGRESS' LIMIT 1`,
      [playerId]
    );
    if (activeRes.rows.length > 0) {
      throw new Error(`Already researching ${activeRes.rows[0].tech_code}. Wait until it finishes.`);
    }

    // 2. Levels must be researched sequentially.
    const currentRes = await client.query(
      `SELECT level FROM player_researches WHERE player_id = $1 AND tech_code = $2`,
      [playerId, techCode]
    );
    const currentLevel = currentRes.rows[0]?.level || 0;
    if (targetLevel !== currentLevel + 1) {
      throw new Error(`${techDef.name} is at level ${currentLevel}. You must research level ${currentLevel + 1} next.`);
    }

    // 3. Prerequisite tech, if any.
    if (techDef.prerequisite) {
      const prereqRes = await client.query(
        `SELECT level FROM player_researches WHERE player_id = $1 AND tech_code = $2`,
        [playerId, techDef.prerequisite.tech]
      );
      const prereqLevel = prereqRes.rows[0]?.level || 0;
      if (prereqLevel < techDef.prerequisite.level) {
        const prereqName = TECH_DEFINITIONS[techDef.prerequisite.tech]?.name || techDef.prerequisite.tech;
        throw new Error(`Requires ${prereqName} Level ${techDef.prerequisite.level}.`);
      }
    }

    // 4. Academy level (drives both the unlock gate and the time formula).
    const academyRes = await client.query(`
      SELECT cb.level
      FROM city_buildings cb
      JOIN building_types bt ON cb.building_type_id = bt.id
      WHERE cb.city_id = $1 AND UPPER(bt.name) = 'ACADEMY'
    `, [cityId]);
    const academyLevel = academyRes.rows[0]?.level || 0;
    if (academyLevel < techDef.requiredAcademyLevel) {
      throw new Error(`Requires Academy Level ${techDef.requiredAcademyLevel}.`);
    }

    // 5. Resource cost.
    const cost = {
      food: calculateTechCost(techDef.baseCost.food, targetLevel),
      wood: calculateTechCost(techDef.baseCost.wood, targetLevel),
      stone: calculateTechCost(techDef.baseCost.stone, targetLevel),
      iron: calculateTechCost(techDef.baseCost.iron, targetLevel),
      gold: calculateTechCost(techDef.baseCost.gold, targetLevel)
    };

    const resResult = await client.query(`SELECT * FROM city_resources WHERE city_id = $1 FOR UPDATE`, [cityId]);
    if (resResult.rows.length === 0) throw new Error("City resources not found.");
    const resources = resResult.rows[0];

    if (resources.food < cost.food || resources.wood < cost.wood ||
        resources.stone < cost.stone || resources.iron < cost.iron ||
        resources.gold < cost.gold) {
      throw new Error("Insufficient resources for this research.");
    }

    await client.query(`
      UPDATE city_resources
      SET food = food - $1, wood = wood - $2, stone = stone - $3,
          iron = iron - $4, gold = gold - $5, updated_at = NOW()
      WHERE city_id = $6
    `, [cost.food, cost.wood, cost.stone, cost.iron, cost.gold, cityId]);

    // 6. Duration — MayorINT isn't tracked anywhere in this schema yet, so
    // this defaults to 0 (no bonus) until that stat exists. SELECT * here
    // deliberately, so this doesn't hard-crash if the players table doesn't
    // have whatever the eventual column is called.
    const playerRes = await client.query(`SELECT * FROM players WHERE id = $1`, [playerId]);
    const mayorInt = playerRes.rows[0]?.mayor_int ?? playerRes.rows[0]?.intelligence ?? 0;

    const durationSeconds = calculateResearchTime(techDef.baseTimeSeconds, targetLevel, academyLevel, mayorInt);
    const startedAt = new Date();
    const finishAt = new Date(startedAt.getTime() + durationSeconds * 1000);

    const insertRes = await client.query(`
      INSERT INTO research_queue (player_id, city_id, tech_code, target_level, start_time, finish_time, status)
      VALUES ($1, $2, $3, $4, $5, $6, 'IN_PROGRESS')
      RETURNING *
    `, [playerId, cityId, techCode, targetLevel, startedAt, finishAt]);

    await client.query("COMMIT");
    return insertRes.rows[0];

  } catch (err) {
    await client.query("ROLLBACK");
    throw err;
  } finally {
    client.release();
  }
}

/**
 * Apply any research whose timer has elapsed: bump player_researches to the
 * target level and mark the queue entry done. Mirrors
 * processCompletedConstruction() / processCompletedRecruitment().
 */
async function resolveCompletedResearch(playerId) {
  const completedRes = await pool.query(
    `SELECT * FROM research_queue WHERE player_id = $1 AND status = 'IN_PROGRESS' AND finish_time <= NOW()`,
    [playerId]
  );

  for (const item of completedRes.rows) {
    await pool.query(`
      INSERT INTO player_researches (player_id, tech_code, level, updated_at)
      VALUES ($1, $2, $3, NOW())
      ON CONFLICT (player_id, tech_code)
      DO UPDATE SET level = EXCLUDED.level, updated_at = NOW()
    `, [playerId, item.tech_code, item.target_level]);

    await pool.query(
      `UPDATE research_queue SET status = 'COMPLETED' WHERE id = $1`,
      [item.id]
    );
  }

  return completedRes.rows;
}

module.exports = {
    TECH_DEFINITIONS,
    TRAINING_QUALITY_TIERS,
    getEffectiveTechLevel,
    calculateTechCost,
    calculateResearchTime,
    getTrainingQualityTier,
    getPlayerResearchLevels,
    calculateCityLabor,
    startResearch,
    resolveCompletedResearch
};
