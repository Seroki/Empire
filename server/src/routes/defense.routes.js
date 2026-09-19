// Defense routes
const express = require("express");
const router = express.Router();
const defenseService = require("../services/defense.service");

// GET /defenses/wall?cityId=1
router.get("/wall", async (req, res) => {
  try {
    const cityId = parseInt(req.query.cityId || 1, 10);
    const data = await defenseService.getWallState(cityId);
    res.json(data);
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: err.message || "Error fetching wall state." });
  }
});

// POST /defenses/build
router.post("/build", async (req, res) => {
  try {
    const { cityId, defenseCode, quantity } = req.body;
    const data = await defenseService.buildDefenses(cityId, defenseCode, quantity);
    res.json(data);
  } catch (err) {
    console.error(err);
    res.status(400).json({ error: err.message || "Build order rejected." });
  }
});

module.exports = router;
