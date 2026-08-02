const researchService = require('../services/research.service');
const pool = require('../database/db');

// This app has no real login/session system yet — "the player" is resolved
// from the city they're acting on, the same way units.service.js does it.
async function resolvePlayerIdFromCity(cityId) {
  const result = await pool.query(`SELECT owner_id FROM cities WHERE id = $1`, [cityId]);
  if (result.rows.length === 0) {
    throw new Error("City not found");
  }
  return result.rows[0].owner_id;
}

// GET /api/research?cityId=1
async function getResearchTree(req, res) {
  try {
    const cityId = req.query.cityId ? parseInt(req.query.cityId, 10) : null;

    if (!cityId) {
      return res.status(400).json({ success: false, error: 'cityId is required.' });
    }

    const playerId = await resolvePlayerIdFromCity(cityId);

    // 1. First, resolve any completed research projects lazily
    await researchService.resolveCompletedResearch(playerId);

    // 2. Fetch player's current completed tech levels
    const playerTechsRes = await pool.query(
      `SELECT tech_code, level FROM player_researches WHERE player_id = $1`,
      [playerId]
    );

    const playerTechMap = {};
    for (const row of playerTechsRes.rows) {
      playerTechMap[row.tech_code] = row.level;
    }

    // 3. Fetch active queue project
    const activeQueueRes = await pool.query(
      `SELECT * FROM research_queue WHERE player_id = $1 AND status = 'IN_PROGRESS' LIMIT 1`,
      [playerId]
    );
    const activeQueue = activeQueueRes.rows[0] || null;

    // 4. Fetch local city Academy level
    const academyRes = await pool.query(
      `SELECT level FROM city_buildings WHERE city_id = $1 AND building_type_id = 6`,
      [cityId]
    );
    const academyLevel = academyRes.rows[0]?.level || 0;

    // 5. Build response object combining global levels and effective levels
    const tree = {};
    for (const [code, config] of Object.entries(researchService.TECH_DEFINITIONS)) {
      const globalLevel = playerTechMap[code] || 0;
      const effectiveLevel = researchService.getEffectiveTechLevel(globalLevel, academyLevel);

      tree[code] = {
        ...config,
        globalLevel,
        effectiveLevel,
        nextLevelCost: {
          food: researchService.calculateTechCost(config.baseCost.food, globalLevel + 1),
          wood: researchService.calculateTechCost(config.baseCost.wood, globalLevel + 1),
          stone: researchService.calculateTechCost(config.baseCost.stone, globalLevel + 1),
          iron: researchService.calculateTechCost(config.baseCost.iron, globalLevel + 1),
          gold: researchService.calculateTechCost(config.baseCost.gold, globalLevel + 1)
        }
      };
    }

    return res.json({
      success: true,
      activeQueue,
      academyLevel,
      technologies: tree
    });
  } catch (err) {
    return res.status(500).json({ success: false, error: err.message });
  }
}

// POST /api/research/start
async function startResearch(req, res) {
  try {
    const { cityId, techCode, targetLevel } = req.body;

    if (!cityId || !techCode || !targetLevel) {
      return res.status(400).json({ success: false, error: 'Missing cityId, techCode, or targetLevel.' });
    }

    const playerId = await resolvePlayerIdFromCity(cityId);

    const queueItem = await researchService.startResearch(
      playerId,
      parseInt(cityId, 10),
      techCode.toUpperCase(),
      parseInt(targetLevel, 10)
    );

    return res.json({
      success: true,
      message: `Started research on ${techCode} level ${targetLevel}`,
      queueItem
    });
  } catch (err) {
    return res.status(400).json({ success: false, error: err.message });
  }
}

module.exports = {
  getResearchTree,
  startResearch
};
