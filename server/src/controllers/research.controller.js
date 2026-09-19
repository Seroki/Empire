const researchService = require('../services/research.service');
const pool = require('../database/db');

async function resolvePlayerIdFromCity(cityId) {
  const result = await pool.query(`SELECT owner_id FROM cities WHERE id = $1`, [cityId]);
  if (result.rows.length === 0) {
    throw new Error("City not found");
  }
  return result.rows[0].owner_id;
}

// GET /research?cityId=1
async function getResearchTree(req, res) {
  try {
    const cityId = req.query.cityId ? parseInt(req.query.cityId, 10) : null;
    if (!cityId) {
      return res.status(400).json({ success: false, error: 'cityId is required.' });
    }

    const playerId = await resolvePlayerIdFromCity(cityId);

    // Resolve any completed research before reading state.
    await researchService.resolveCompletedResearch(playerId);

    const { academyLevel, activeQueue, tree } = await researchService.getResearchTree(playerId, cityId);
    const bonusTotals = await researchService.getPlayerBonusTotals(playerId);

    return res.json({
      success: true,
      academyLevel,
      activeQueue,
      tree,
      bonusTotals
    });
  } catch (err) {
    console.error(err); // TEMP - remove once confirmed stable
    return res.status(500).json({ success: false, error: err.message });
  }
}

// GET /research/bonuses?cityId=1
// Standalone lookup for other systems (building speed/cost, resource
// production, combat, etc.) that need a player's current stacked research
// bonuses without loading the whole tree.
async function getBonusTotals(req, res) {
  try {
    const cityId = req.query.cityId ? parseInt(req.query.cityId, 10) : null;
    if (!cityId) {
      return res.status(400).json({ success: false, error: 'cityId is required.' });
    }

    const playerId = await resolvePlayerIdFromCity(cityId);
    const bonusTotals = await researchService.getPlayerBonusTotals(playerId);

    return res.json({ success: true, bonusTotals });
  } catch (err) {
    return res.status(500).json({ success: false, error: err.message });
  }
}

// POST /research/start
async function startResearch(req, res) {
  try {
    const { cityId, researchId } = req.body;

    if (!cityId || !researchId) {
      return res.status(400).json({ success: false, error: 'Missing cityId or researchId.' });
    }

    const playerId = await resolvePlayerIdFromCity(cityId);

    const queueItem = await researchService.startResearchNode(
      playerId,
      parseInt(cityId, 10),
      researchId
    );

    return res.json({
      success: true,
      message: `Started research on ${researchId}`,
      queueItem
    });
  } catch (err) {
    return res.status(400).json({ success: false, error: err.message });
  }
}

module.exports = {
  getResearchTree,
  startResearch,
  getBonusTotals
};
