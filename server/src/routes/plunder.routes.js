const express = require('express');

const router = express.Router();
const pool = require("../database/db");
const npcService = require("../services/npc.service");
const plunderService = require("../services/plunder.service");

// POST /plunder/preview-npc — body: { x, y, troops }
// Read-only: computes what an attack WOULD carry home right now, without
// resolving combat or spending anything. Lets the frontend show an
// estimated haul before the player commits to Confirm Attack.
router.post("/preview-npc", async (req, res) => {
  try {
    const { x, y, troops } = req.body;
    if (x === undefined || y === undefined || !troops) {
      return res.status(400).json({ success: false, error: "x, y, and troops are required." });
    }

    const npc = await npcService.getNpcCityWithRegen(parseInt(x, 10), parseInt(y, 10));

    const codes = Object.keys(troops);
    const unitTypesRes = await pool.query(
      `SELECT code, load_capacity FROM unit_types WHERE UPPER(code) = ANY($1)`,
      [codes.map(c => c.toUpperCase())]
    );
    const unitTypeByCode = {};
    unitTypesRes.rows.forEach(u => { unitTypeByCode[u.code.toLowerCase()] = u; });

    // Preview assumes no losses (best case) — actual combat may reduce
    // survivors and therefore carry capacity; this is an upper-bound estimate.
    const stockpile = { food: npc.food, lumber: npc.lumber, stone: npc.stone, iron: npc.iron, gold: npc.gold };
    const result = plunderService.calculatePlunder(stockpile, troops, unitTypeByCode);

    res.json({ success: true, ...result, note: "Best-case estimate — assumes no troop losses." });
  } catch (error) {
    res.status(400).json({ success: false, error: error.message });
  }
});

module.exports = router;
