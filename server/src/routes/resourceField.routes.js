const express = require('express');

const router = express.Router();
const resourceFieldService = require("../services/resourceField.service");

// POST /resource-field/seed — create world_resource_fields rows for existing
// RESOURCE map tiles. Idempotent, safe to call again after generating more tiles.
router.post("/seed", async (req, res) => {
  try {
    const result = await resourceFieldService.seedResourceFieldsFromMap();
    res.json({ success: true, ...result });
  } catch (error) {
    res.status(400).json({ success: false, error: error.message });
  }
});

// GET /resource-field/tile/:x/:y — current state, with pending recall resolved
// and live harvest accrual (computed from current garrison) included.
router.get("/tile/:x/:y", async (req, res) => {
  try {
    const x = parseInt(req.params.x, 10);
    const y = parseInt(req.params.y, 10);
    const field = await resourceFieldService.getResourceField(x, y);
    const accruedHarvest = await resourceFieldService.getAccruedHarvest(field);
    const hourlyRate = await resourceFieldService.getHourlyHarvestRate(field);
    res.json({ success: true, field, accruedHarvest, hourlyRate });
  } catch (error) {
    res.status(404).json({ success: false, error: error.message });
  }
});

// POST /resource-field/:x/:y/attack — body: { cityId, troops: { pikeman, swordsman, archer, cavalry, cataphract, ballista, battering_ram, catapult, scout, transporter } }
router.post("/:x/:y/attack", async (req, res) => {
  try {
    const x = parseInt(req.params.x, 10);
    const y = parseInt(req.params.y, 10);
    const { cityId, troops } = req.body;
    if (!cityId || !troops) {
      return res.status(400).json({ success: false, error: "cityId and troops are required." });
    }
    const result = await resourceFieldService.attackResourceField(cityId, x, y, troops);
    res.json({ success: true, ...result });
  } catch (error) {
    res.status(400).json({ success: false, error: error.message });
  }
});

// POST /resource-field/:x/:y/recall — body: { cityId }
router.post("/:x/:y/recall", async (req, res) => {
  try {
    const x = parseInt(req.params.x, 10);
    const y = parseInt(req.params.y, 10);
    const { cityId } = req.body;
    if (!cityId) {
      return res.status(400).json({ success: false, error: "cityId is required." });
    }
    const result = await resourceFieldService.recallFromResourceField(cityId, x, y);
    res.json({ success: true, ...result });
  } catch (error) {
    res.status(400).json({ success: false, error: error.message });
  }
});

// POST /resource-field/:x/:y/collect — body: { cityId }
// Deposits currently-accrued harvest into city_resources WITHOUT recalling
// the garrison — the missing counterpart to /recall. Recall both cashes
// out AND vacates the field; this only cashes out, so a player can keep
// holding a tile indefinitely and still get its resources into the city.
router.post("/:x/:y/collect", async (req, res) => {
  try {
    const x = parseInt(req.params.x, 10);
    const y = parseInt(req.params.y, 10);
    const { cityId } = req.body;
    if (!cityId) {
      return res.status(400).json({ success: false, error: "cityId is required." });
    }
    const result = await resourceFieldService.collectFromResourceField(cityId, x, y);
    res.json({ success: true, ...result });
  } catch (error) {
    res.status(400).json({ success: false, error: error.message });
  }
});

module.exports = router;
