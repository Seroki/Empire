const db = require("../database/db");

// Academy building_type_id = 6
const ACADEMY_BUILDING_TYPE_ID = 6;

const TECH_DEFINITIONS = {
  AGRICULTURE: { id: 1, baseTime: 900, baseCost: { food: 500, wood: 1000, stone: 500, iron: 200, gold: 0 }, reqAcademy: 1, reqTechs: {} },
  LUMBERING: { id: 2, baseTime: 900, baseCost: { food: 500, wood: 500, stone: 1000, iron: 500, gold: 0 }, reqAcademy: 1, reqTechs: {} },
  MASONRY: { id: 3, baseTime: 1200, baseCost: { food: 500, wood: 1000, stone: 500, iron: 1000, gold: 0 }, reqAcademy: 1, reqTechs: {} },
  MINING: { id: 4, baseTime: 1500, baseCost: { food: 1000, wood: 1000, stone: 1000, iron: 500, gold: 0 }, reqAcademy: 1, reqTechs: {} },
  STOCKPILE: { id: 5, baseTime: 2400, baseCost: { food: 1000, wood: 2000, stone: 4000, iron: 1000, gold: 0 }, reqAcademy: 1, reqTechs: { AGRICULTURE: 1 } },
  MEDICINE: { id: 6, baseTime: 2700, baseCost: { food: 3000, wood: 1000, stone: 1000, iron: 1000, gold: 0 }, reqAcademy: 3, reqTechs: { AGRICULTURE: 1 } },
  LOGISTICS: { id: 7, baseTime: 3600, baseCost: { food: 2000, wood: 5000, stone: 2000, iron: 2000, gold: 0 }, reqAcademy: 3, reqTechs: {} },
  CONSTRUCTION: { id: 8, baseTime: 1800, baseCost: { food: 1000, wood: 3000, stone: 5000, iron: 1000, gold: 0 }, reqAcademy: 2, reqTechs: {} },
  MILITARY_SCIENCE: { id: 9, baseTime: 1800, baseCost: { food: 1000, wood: 2000, stone: 1000, iron: 1000, gold: 0 }, reqAcademy: 2, reqTechs: {} },
  MILITARY_TRADITION: { id: 10, baseTime: 2700, baseCost: { food: 2000, wood: 3000, stone: 1000, iron: 2000, gold: 0 }, reqAcademy: 3, reqTechs: { MILITARY_SCIENCE: 1 } },
  INFORMATICS: { id: 11, baseTime: 1200, baseCost: { food: 1000, wood: 2000, stone: 1000, iron: 1000, gold: 0 }, reqAcademy: 1, reqTechs: {} },
  ARCHERY: { id: 12, baseTime: 5400, baseCost: { food: 3000, wood: 10000, stone: 2000, iron: 3000, gold: 0 }, reqAcademy: 4, reqTechs: { MILITARY_SCIENCE: 2 } },
  HORSEBACK_RIDING: { id: 13, baseTime: 3600, baseCost: { food: 5000, wood: 3000, stone: 2000, iron: 3000, gold: 0 }, reqAcademy: 3, reqTechs: { MILITARY_SCIENCE: 1 } },
  COMPASS: { id: 14, baseTime: 2700, baseCost: { food: 2000, wood: 3000, stone: 1000, iron: 1000, gold: 0 }, reqAcademy: 3, reqTechs: { HORSEBACK_RIDING: 1 } },
  ENGINEERING: { id: 15, baseTime: 7200, baseCost: { food: 3000, wood: 8000, stone: 5000, iron: 5000, gold: 0 }, reqAcademy: 5, reqTechs: { METAL_CASTING: 2 } },
  METAL_CASTING: { id: 16, baseTime: 5400, baseCost: { food: 2000, wood: 5000, stone: 3000, iron: 8000, gold: 0 }, reqAcademy: 5, reqTechs: { MINING: 1 } },
  IRON_WORKING: { id: 17, baseTime: 3600, baseCost: { food: 2000, wood: 2000, stone: 2000, iron: 4000, gold: 0 }, reqAcademy: 4, reqTechs: { METAL_CASTING: 1 } }
};

function calculateTechCost(baseCost, targetLevel) {
  return Math.ceil(baseCost * Math.pow(1.45, targetLevel - 1));
}

function calculateResearchDuration(baseTime, mayorIntelligence, academyLevel) {
  const intelDenominator = 1 + (mayorIntelligence / 100);
  const academyMultiplier = Math.pow(0.95, academyLevel - 1);
  return Math.max(1, Math.floor((baseTime / intelDenominator) * academyMultiplier));
}

function getEffectiveTechLevel(globalTechLevel, localAcademyLevel) {
  if (!globalTechLevel || globalTechLevel <= 0) return 0;
  return Math.min(globalTechLevel, localAcademyLevel);
}

async function getCityMayorIntelligence(cityId) {
  const mayorRes = await db.query(
    `SELECT intelligence FROM heroes WHERE city_id = $1 AND status = 'MAYOR' LIMIT 1`,
    [cityId]
  );
  return mayorRes.rows[0]?.intelligence || 0;
}

async function resolveCompletedResearch(playerId) {
  // Find any IN_PROGRESS research that has expired
  const expiredRes = await db.query(
    `SELECT * FROM research_queue 
     WHERE player_id = $1 AND status = 'IN_PROGRESS' AND finish_time <= NOW()`,
    [playerId]
  );

  for (const task of expiredRes.rows) {
    await db.query('BEGIN');

    // 1. Grant global player research level
    await db.query(
      `INSERT INTO player_researches (player_id, tech_code, level, updated_at)
       VALUES ($1, $2, $3, NOW())
       ON CONFLICT (player_id, tech_code) 
       DO UPDATE SET level = EXCLUDED.level, updated_at = NOW()`,
      [task.player_id, task.tech_code, task.target_level]
    );

    // 2. Mark queue item as completed
    await db.query(
      `UPDATE research_queue SET status = 'COMPLETED' WHERE id = $1`,
      [task.id]
    );

    await db.query('COMMIT');
  }
}

async function startResearch(playerId, cityId, techCode, targetLevel) {
  // CRITICAL ADDITION: Clear out any completed research first
  await resolveCompletedResearch(playerId);

  const config = TECH_DEFINITIONS[techCode];
  if (!config) throw new Error(`Invalid tech code: ${techCode}`);

  // Now this check will properly pass if the previous research finished!
  const activeQueue = await db.query(
    `SELECT id FROM research_queue WHERE player_id = $1 AND status = 'IN_PROGRESS'`,
    [playerId]
  );
  if (activeQueue.rows.length > 0) {
    throw new Error('Another research project is currently in progress. Global queue limit reached.');
  }

  const academyRes = await db.query(
    `SELECT level FROM city_buildings WHERE city_id = $1 AND building_type_id = $2`,
    [cityId, ACADEMY_BUILDING_TYPE_ID]
  );
  const academyLevel = academyRes.rows[0]?.level || 0;
  if (academyLevel < config.reqAcademy) {
    throw new Error(`Academy Level ${config.reqAcademy} required.`);
  }

  const playerTechRes = await db.query(
    `SELECT level FROM player_researches WHERE player_id = $1 AND tech_code = $2`,
    [playerId, techCode]
  );
  const currentLevel = playerTechRes.rows[0]?.level || 0;
  if (targetLevel !== currentLevel + 1) {
    throw new Error(`Target level ${targetLevel} invalid. Current level is ${currentLevel}.`);
  }

  for (const [reqTech, reqLevel] of Object.entries(config.reqTechs)) {
    const reqRes = await db.query(
      `SELECT level FROM player_researches WHERE player_id = $1 AND tech_code = $2`,
      [playerId, reqTech]
    );
    if ((reqRes.rows[0]?.level || 0) < reqLevel) {
      throw new Error(`Prerequisite ${reqTech} level ${reqLevel} not met.`);
    }
  }

  const mayorINT = await getCityMayorIntelligence(cityId);

  const foodCost = calculateTechCost(config.baseCost.food, targetLevel);
  const woodCost = calculateTechCost(config.baseCost.wood, targetLevel);
  const stoneCost = calculateTechCost(config.baseCost.stone, targetLevel);
  const ironCost = calculateTechCost(config.baseCost.iron, targetLevel);
  const goldCost = calculateTechCost(config.baseCost.gold, targetLevel);

  const resCheck = await db.query(
    `SELECT food, wood, stone, iron, gold FROM city_resources WHERE city_id = $1`,
    [cityId]
  );
  const res = resCheck.rows[0];
  if (!res || res.food < foodCost || res.wood < woodCost || res.stone < stoneCost || res.iron < ironCost || res.gold < goldCost) {
    throw new Error('Insufficient resources in city.');
  }

  await db.query(
    `UPDATE city_resources 
     SET food = food - $1, wood = wood - $2, stone = stone - $3, iron = iron - $4, gold = gold - $5 
     WHERE city_id = $6`,
    [foodCost, woodCost, stoneCost, ironCost, goldCost, cityId]
  );

  const scaledBaseTime = calculateTechCost(config.baseTime, targetLevel);
  const duration = calculateResearchDuration(scaledBaseTime, mayorINT, academyLevel);

  const insertRes = await db.query(
    `INSERT INTO research_queue (player_id, city_id, tech_code, target_level, start_time, finish_time, status)
     VALUES ($1, $2, $3, $4, NOW(), NOW() + (INTERVAL '1 second' * $5), 'IN_PROGRESS')
     RETURNING *`,
    [playerId, cityId, techCode, targetLevel, duration]
  );

  return insertRes.rows[0];
}

module.exports = {
  TECH_DEFINITIONS,
  calculateTechCost,
  calculateResearchDuration,
  getEffectiveTechLevel,
  getCityMayorIntelligence,
  resolveCompletedResearch,
  startResearch
};
