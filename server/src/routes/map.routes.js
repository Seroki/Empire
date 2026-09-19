const express = require('express');

const router = express.Router();
const mapService = require("../services/map.service");

// POST /map/generate — one-time world seeding. Idempotent: refuses if the
// map already has tiles.
router.post("/generate", async (req, res) => {
  try {
    const result = await mapService.generateWorldMap();
    res.json({ success: true, ...result });
  } catch (error) {
    res.status(400).json({ success: false, error: error.message });
  }
});

// GET /map — full 100x100 tile grid.
router.get("/", async (req, res) => {
  try {
    const tiles = await mapService.getFullMap();
    res.json({ success: true, mapSize: mapService.MAP_SIZE, tiles });
  } catch (error) {
    res.status(500).json({ success: false, error: error.message });
  }
});

// GET /map/tile/:x/:y — single tile detail, for click-to-inspect.
router.get("/tile/:x/:y", async (req, res) => {
  try {
    const x = parseInt(req.params.x, 10);
    const y = parseInt(req.params.y, 10);
    const tile = await mapService.getTile(x, y);
    res.json({ success: true, tile });
  } catch (error) {
    res.status(404).json({ success: false, error: error.message });
  }
});

module.exports = router;
