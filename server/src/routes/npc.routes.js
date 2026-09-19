const express = require('express');

const router = express.Router();
const npcService = require("../services/npc.service");

// POST /npc/seed — create npc_cities rows for existing NPC map tiles.
// Idempotent, safe to call again after generating more map tiles.
router.post("/seed", async (req, res) => {
  try {
    const result = await npcService.seedNpcCitiesFromMap();
    res.json({ success: true, ...result });
  } catch (error) {
    res.status(400).json({ success: false, error: error.message });
  }
});

// GET /npc/tile/:x/:y — current state of the NPC at a tile, with regen
// applied for whatever time has elapsed since it was last checked.
router.get("/tile/:x/:y", async (req, res) => {
  try {
    const x = parseInt(req.params.x, 10);
    const y = parseInt(req.params.y, 10);
    const npc = await npcService.getNpcCityWithRegen(x, y);
    res.json({ success: true, npc });
  } catch (error) {
    res.status(404).json({ success: false, error: error.message });
  }
});

// POST /npc/:x/:y/attack — body: { cityId, troops: {...}, heroId? }
router.post("/:x/:y/attack", async (req, res) => {
  try {
    const x = parseInt(req.params.x, 10);
    const y = parseInt(req.params.y, 10);
    const { cityId, troops, heroId } = req.body;
    if (!cityId || !troops) {
      return res.status(400).json({ success: false, error: "cityId and troops are required." });
    }
    const result = await npcService.attackNpcCity(cityId, x, y, troops, heroId || null);
    res.json({ success: true, ...result });
  } catch (error) {
    res.status(400).json({ success: false, error: error.message });
  }
});

module.exports = router;
