const express = require('express');

const router = express.Router();
const valleyService = require("../services/valley.service");

// POST /valley/seed
router.post("/seed", async (req, res) => {
  try {
    const result = await valleyService.seedValleysFromMap();
    res.json({ success: true, ...result });
  } catch (error) {
    res.status(400).json({ success: false, error: error.message });
  }
});

// GET /valley/tile/:x/:y
router.get("/tile/:x/:y", async (req, res) => {
  try {
    const x = parseInt(req.params.x, 10);
    const y = parseInt(req.params.y, 10);
    const valley = await valleyService.getValley(x, y);
    res.json({ success: true, valley });
  } catch (error) {
    res.status(404).json({ success: false, error: error.message });
  }
});

// POST /valley/:x/:y/harvest — body: { cityId, troops, heroId } — heroId REQUIRED
router.post("/:x/:y/harvest", async (req, res) => {
  try {
    const x = parseInt(req.params.x, 10);
    const y = parseInt(req.params.y, 10);
    const { cityId, troops, heroId } = req.body;
    if (!cityId || !troops) {
      return res.status(400).json({ success: false, error: "cityId and troops are required." });
    }
    const result = await valleyService.startHarvest(cityId, x, y, troops, heroId);
    res.json({ success: true, ...result });
  } catch (error) {
    res.status(400).json({ success: false, error: error.message });
  }
});

// POST /valley/:x/:y/raid — body: { cityId, troops, heroId? } — hit-and-return
router.post("/:x/:y/raid", async (req, res) => {
  try {
    const x = parseInt(req.params.x, 10);
    const y = parseInt(req.params.y, 10);
    const { cityId, troops, heroId } = req.body;
    if (!cityId || !troops) {
      return res.status(400).json({ success: false, error: "cityId and troops are required." });
    }
    const result = await valleyService.raidValley(cityId, x, y, troops, heroId || null);
    res.json({ success: true, ...result });
  } catch (error) {
    res.status(400).json({ success: false, error: error.message });
  }
});

// POST /valley/:x/:y/recall — body: { cityId } — ends an active Harvest
router.post("/:x/:y/recall", async (req, res) => {
  try {
    const x = parseInt(req.params.x, 10);
    const y = parseInt(req.params.y, 10);
    const { cityId } = req.body;
    if (!cityId) {
      return res.status(400).json({ success: false, error: "cityId is required." });
    }
    const result = await valleyService.recallFromValley(cityId, x, y);
    res.json({ success: true, ...result });
  } catch (error) {
    res.status(400).json({ success: false, error: error.message });
  }
});

module.exports = router;
