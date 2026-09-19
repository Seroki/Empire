const innService = require('../services/inn.service');
const pool = require('../database/db');

async function getInnState(req, res) {
  try {
    const cityId = req.query.cityId ? parseInt(req.query.cityId, 10) : null;
    if (!cityId) return res.status(400).json({ success: false, error: 'cityId is required.' });

    const innLevel = await innService.getInnLevel(cityId);
    const feastingHallLevel = await innService.getFeastingHallLevel(cityId);

    const maxPowerLevel = Math.min(Math.max(1, Math.floor(innLevel / 2) + 1), 4);
    const tierRes = await pool.query(`SELECT name FROM hero_hiring_tiers WHERE power_level = $1`, [maxPowerLevel]);
    const maxTierName = tierRes.rows[0]?.name || 'Apprentice';

    let candidateRes = await pool.query(
      `SELECT 
         h.id, 
         h.name, 
         h.level, 
         h.politics, 
         h.attack, 
         h.intelligence, 
         h.type AS tier, 
         h.hire_cost
       FROM hero_candidates hc
       JOIN heroes h ON hc.hero_id = h.id
       WHERE hc.city_id = $1 AND hc.status = 'available'`,
      [cityId]
    );

    let candidates = candidateRes.rows;
    if (candidates.length === 0 && innLevel > 0) {
      candidates = await innService.generateCandidatesForInn(cityId, innLevel);
    }

    const resResult = await pool.query(`SELECT gold FROM city_resources WHERE city_id = $1`, [cityId]);
    const heroCountRes = await pool.query(`SELECT COUNT(*) FROM heroes WHERE city_id = $1 AND hired = true`, [cityId]);

    return res.json({
      success: true,
      innLevel,
      maxTierName,
      maxHeroCap: feastingHallLevel,
      currentHeroCount: parseInt(heroCountRes.rows[0].count, 10),
      resources: { gold: resResult.rows[0]?.gold || 0 },
      candidates: candidates.map(c => ({
        id: c.id,
        name: c.name,
        level: c.level || 1,
        politics: c.politics,
        attack: c.attack,
        intelligence: c.intelligence,
        tier: c.tier || c.type || 'Apprentice',
        hireCost: c.hire_cost || c.hireCost
      }))
    });
  } catch (err) {
    return res.status(500).json({ success: false, error: err.message });
  }
}

async function hireHero(req, res) {
  try {
    const { cityId, candidateId } = req.body;
    if (!cityId || !candidateId) {
      return res.status(400).json({ success: false, error: 'Missing cityId or candidateId.' });
    }

    const hiredHero = await innService.hireCandidate(parseInt(cityId, 10), parseInt(candidateId, 10));
    return res.json({ success: true, message: `Successfully hired ${hiredHero.name}!`, hero: hiredHero });
  } catch (err) {
    return res.status(400).json({ success: false, error: err.message });
  }
}

async function refreshHeroPool(req, res) {
  const client = await pool.connect();
  try {
    const { cityId } = req.body;
    if (!cityId) return res.status(400).json({ success: false, error: 'Missing cityId.' });

    const parsedCityId = parseInt(cityId, 10);
    const innLevel = await innService.getInnLevel(parsedCityId);
    if (innLevel <= 0) {
      return res.status(400).json({ success: false, error: 'You need an Inn built in this city.' });
    }

    const REFRESH_COST = 1000;
    await client.query('BEGIN');

    const goldRes = await client.query(`SELECT gold FROM city_resources WHERE city_id = $1 FOR UPDATE`, [parsedCityId]);
    const currentGold = goldRes.rows[0]?.gold || 0;

    if (currentGold < REFRESH_COST) {
      await client.query('ROLLBACK');
      return res.status(400).json({ success: false, error: `Insufficient Gold. Refresh requires ${REFRESH_COST} Gold.` });
    }

    await client.query(`UPDATE city_resources SET gold = gold - $1, updated_at = NOW() WHERE city_id = $2`, [REFRESH_COST, parsedCityId]);

    const newCandidates = await innService.generateCandidatesForInn(parsedCityId, innLevel);

    await client.query('COMMIT');
    return res.json({ success: true, candidates: newCandidates });
  } catch (err) {
    await client.query('ROLLBACK');
    return res.status(500).json({ success: false, error: err.message });
  } finally {
    client.release();
  }
}

module.exports = {
  getInnState,
  hireHero,
  refreshHeroPool
};
