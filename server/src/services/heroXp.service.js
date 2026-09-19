// ============================================================================
// FILE: src/services/heroXp.service.js
// HERO XP ENGINE — standalone, same reasoning as plunder.service.js: this
// gets called from multiple attack functions (NPC today, Valley/
// ResourceField as a fast follow) and later from civic completion handlers
// (troop training / building / research), so it doesn't belong buried
// inside any one of them.
//
// Source: historical Age I player-guide reconstruction (2009-2011),
// supplied as verified GDS data, not derived/invented here.
//
// PLACEHOLDER / OPEN QUESTION, flagged rather than silently resolved:
// the source doc says level-up grants "+1 attribute point" that the PLAYER
// CHOOSES to spend (Politics/Attack/Intelligence). There's no schema
// column for a pending, unspent point. This engine auto-applies the point
// to Attack for combat XP (the channel that earned it) rather than
// inventing a new column. Revisit if real player choice is wanted — see
// HeroSystem_DeferredItems.md, Item 2.
// ============================================================================

const pool = require("../database/db");

// Combat XP per kill — enemy units/structures destroyed. Warrior stays
// Warrior here (killing an NPC/valley/field guard's Warrior units is real;
// this table is about what you KILLED, not what your city trains).
const KILL_XP_BY_CODE = {
  warrior: 3.05,
  scout: 6.95,
  pikeman: 9.00,
  swordsman: 13.50,
  archer: 13.50,
  cavalry: 28.50,
  cataphract: 87.50,
  transporter: 29.75,
  ballista: 100.00,
  battering_ram: 137.50,
  catapult: 290.00,
  // Fortifications — only archer_tower/rolling_log/defensive_trebuchet are
  // currently tracked as reduced anywhere in combat resolution (traps/
  // abatis aren't decremented by any attack function yet — same gap
  // already flagged for defense math). Included here for when that closes.
  archer_tower: 54.50,
  rolling_log: 63.00,
  defensive_trebuchet: 166.00,
  trap: 8.75,
  abatis: 16.75
  // "worker" has no unit_types row — intentionally omitted, see
  // HeroSystem_DeferredItems.md.
};

// Mayor civic production XP — Warrior substituted for Militia here per
// design direction, since the CITY can only ever produce Militia, never
// Warrior (is_npc_only). Predefined now for Item 3 to consume later;
// nothing in this session calls this table yet.
const PRODUCTION_XP_BY_CODE = {
  militia: 1.525, // doc said "Warrior" — substituted per design direction
  scout: 3.475,
  pikeman: 4.500,
  swordsman: 6.750,
  archer: 7.000,
  cavalry: 14.250,
  cataphract: 43.750,
  transporter: 14.875,
  ballista: 50.000,
  battering_ram: 68.750,
  catapult: 145.000,
  trap: 4.375,
  abatis: 8.375,
  archer_tower: 27.250,
  rolling_log: 31.500,
  defensive_trebuchet: 83.000
};

function xpRequiredForLevel(level) {
  return 100 * Math.pow(level, 2);
}

/**
 * Sum of killed-unit counts x their kill-XP value. killedByCode is a plain
 * { code: countKilled } map — caller computes the deltas (before/after
 * combat resolution) since that's specific to each attack function's own
 * table shape.
 */
function calculateCombatXp(killedByCode) {
  return Object.entries(killedByCode).reduce((sum, [code, count]) => {
    const xpValue = KILL_XP_BY_CODE[code.toLowerCase()];
    if (!xpValue || !count) return sum;
    return sum + Number(count) * xpValue;
  }, 0);
}

/**
 * Validates a hero is eligible to lead an attack: exists, belongs to the
 * attacking city, and is IDLE (not already Mayor/Marching/Captured).
 * Locks the row FOR UPDATE within the caller's existing transaction.
 */
async function lockAndValidateHero(heroId, cityId, client) {
  const result = await client.query(
    `SELECT * FROM heroes WHERE id = $1 FOR UPDATE`,
    [heroId]
  );
  if (result.rows.length === 0) throw new Error(`No hero with id ${heroId}.`);
  const hero = result.rows[0];

  if (hero.city_id !== cityId) {
    throw new Error(`Hero ${hero.name} does not belong to this city.`);
  }
  // BUGFIX: was comparing against uppercase 'IDLE' only. Hero rows as
  // actually created come back lowercase ('idle') — other parts of this
  // codebase (valley recall, releaseHero) write uppercase 'IDLE' when
  // transitioning a hero back, so the column ends up mixed-case depending
  // on a hero's history. Compare case-insensitively rather than assume one.
  // Same fix applied in valley.service.js's own separate inline check.
  if ((hero.status || '').toLowerCase() !== 'idle') {
    throw new Error(`Hero ${hero.name} is not available (status: ${hero.status}).`);
  }

  return hero;
}

/**
 * Awards XP to a hero and resolves any level-ups (looped, in case a single
 * award crosses more than one threshold). Auto-applies +1 Attack per level
 * gained — see the placeholder note at the top of this file.
 */
async function awardCombatXp(hero, xpGained, client) {
  let experience = Number(hero.experience) + xpGained;
  let level = Number(hero.level);
  let attack = Number(hero.attack);
  let levelsGained = 0;

  while (experience >= xpRequiredForLevel(level)) {
    experience -= xpRequiredForLevel(level);
    level += 1;
    attack += 1; // auto-applied point — see placeholder note
    levelsGained += 1;
  }

  const result = await client.query(`
    UPDATE heroes
    SET experience = $1, level = $2, attack = $3
    WHERE id = $4
    RETURNING *
  `, [Math.round(experience), level, attack, hero.id]);

  return {
    hero: result.rows[0],
    xpGained: Math.round(xpGained * 100) / 100,
    levelsGained
  };
}

module.exports = {
  KILL_XP_BY_CODE,
  PRODUCTION_XP_BY_CODE,
  xpRequiredForLevel,
  calculateCombatXp,
  lockAndValidateHero,
  awardCombatXp
};
