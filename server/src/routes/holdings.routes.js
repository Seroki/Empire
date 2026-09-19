const express = require('express');

const router = express.Router();
const valleyService = require("../services/valley.service");
const resourceFieldService = require("../services/resourceField.service");

// GET /holdings/:cityId — everything this city currently occupies out in
// the wilderness: valleys and RESOURCE fields, with live garrison, harvest
// rate, and accrued totals per tile.
router.get("/:cityId", async (req, res) => {
  try {
    const cityId = parseInt(req.params.cityId, 10);
    const [valleys, resourceFields] = await Promise.all([
      valleyService.getHoldingsForCity(cityId),
      resourceFieldService.getHoldingsForCity(cityId)
    ]);
    res.json({ success: true, valleys, resourceFields });
  } catch (error) {
    res.status(400).json({ success: false, error: error.message });
  }
});

module.exports = router;
