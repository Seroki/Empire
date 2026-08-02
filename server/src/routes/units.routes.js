const express = require('express');

const router = express.Router();
const { getBarracksData, startRecruitment } = require('../services/units.service');

// GET /units/barracks?cityId=123
router.get('/barracks', async (req, res) => {
  try {
    const cityId = req.query.cityId;
    const data = await getBarracksData(cityId);
    res.json({ success: true, ...data });
  } catch (err) {
    res.status(500).json({ success: false, error: err.message });
  }
});

// POST /units/train
router.post('/train', async (req, res) => {
  try {
    const { cityId, unitCode, quantity, barracksId } = req.body;
    const result = await startRecruitment(cityId, unitCode, quantity, barracksId);
    res.json(result);
  } catch (err) {
    res.status(400).json({ success: false, error: err.message });
  }
});

module.exports = router;
