// Market routee
const express = require("express");
const router = express.Router();
const marketService = require("../services/market.service");

// GET /market/data?cityId=1
router.get("/data", async (req, res) => {
  try {
    const cityId = req.query.cityId || 1;
    const data = await marketService.getMarketData(cityId);
    res.json({ success: true, ...data });
  } catch (err) {
    res.status(400).json({ success: false, error: err.message });
  }
});

// POST /market/buy
router.post("/buy", async (req, res) => {
  try {
    const { cityId, resource, goldSpent } = req.body;
    const result = await marketService.executeBuy(cityId, resource, goldSpent);
    res.json(result);
  } catch (err) {
    res.status(400).json({ success: false, error: err.message });
  }
});

// POST /market/sell
router.post("/sell", async (req, res) => {
  try {
    const { cityId, resource, quantity } = req.body;
    const result = await marketService.executeSell(cityId, resource, quantity);
    res.json(result);
  } catch (err) {
    res.status(400).json({ success: false, error: err.message });
  }
});

module.exports = router;
