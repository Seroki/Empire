// ============================================================================
// FILE: src/services/plunder.service.js
// PLUNDER SERVICE — standalone on purpose (per design direction: "plunder is
// a big part of player and NPC actions... could be its own service/routes
// files so it can breathe and be called"), rather than buried inline in
// npc.service.js. Reusable by NPC attacks today, and later by player-city
// sieges and resource-field raids once those exist.
//
// Core rule: a raid's actual haul is capped by TWO independent ceilings —
//   1. What's available at all: stockpile x PLUNDER_PCT_PER_ATTACK
//   2. What the surviving attacking force can physically carry:
//      Σ(surviving unit count x unit_types.load_capacity)
// Whichever is lower wins. Anything above the carry-capacity ceiling is
// left behind at the target — not destroyed, just never picked up.
//
// PLACEHOLDERS, called out explicitly rather than guessed at:
//   - PLUNDER_PCT_PER_ATTACK (10%) has no confirmed research hook yet —
//     there IS a tech meant to raise this cap per design direction, but
//     it isn't linked to a real research_nodes branch_code yet. Left as a
//     flat constant until that mapping exists; do not invent a branch code.
//   - Every unit_types row already has a real load_capacity column (not
//     invented here) — confirmed every troop type can carry, not just
//     Transporter, per design direction.
// ============================================================================

const PLUNDER_PCT_PER_ATTACK = 0.10;

/**
 * @param {Object} stockpile - resource amounts at the target, keyed by
 *   resource name (e.g. { food, lumber, stone, iron, gold } for NPCs).
 * @param {Object} survivingByCode - surviving attacker troop counts by
 *   unit code, POST-combat-losses (dead troops carry nothing).
 * @param {Object} unitTypeByCode - unit_types rows keyed by lowercase code,
 *   must include load_capacity (and code) for every key present in
 *   survivingByCode.
 * @param {number} [plunderPct] - override for PLUNDER_PCT_PER_ATTACK,
 *   for whenever the research hook above gets wired in.
 */
function calculatePlunder(stockpile, survivingByCode, unitTypeByCode, plunderPct = PLUNDER_PCT_PER_ATTACK) {
  const totalCarryCapacity = Object.entries(survivingByCode).reduce((sum, [code, qty]) => {
    const ut = unitTypeByCode[code];
    return sum + Number(qty || 0) * Number(ut?.load_capacity || 0);
  }, 0);

  const resourceKeys = Object.keys(stockpile);
  const availableByResource = {};
  let totalAvailable = 0;
  resourceKeys.forEach(res => {
    const amt = Math.round(Number(stockpile[res] || 0) * plunderPct);
    availableByResource[res] = amt;
    totalAvailable += amt;
  });

  const cappedByCapacity = totalAvailable > totalCarryCapacity;

  // When capacity is the binding constraint, split it across resource
  // types proportionally to how much of each was available — same
  // proportional-share pattern already used for combat loss distribution
  // elsewhere in this codebase, so a mixed stockpile can't be cherry-picked
  // (e.g. hauling 100% of the gold and 0% of the food).
  const plunder = {};
  resourceKeys.forEach(res => {
    if (!cappedByCapacity || totalAvailable <= 0) {
      plunder[res] = availableByResource[res];
    } else {
      const share = availableByResource[res] / totalAvailable;
      plunder[res] = Math.round(totalCarryCapacity * share);
    }
  });

  return {
    plunder,           // actual amount carried home, per resource
    totalCarryCapacity,
    totalAvailable,    // what the flat % would have allowed with unlimited capacity
    cappedByCapacity   // true if the force couldn't carry everything available
  };
}

module.exports = {
  PLUNDER_PCT_PER_ATTACK,
  calculatePlunder
};
