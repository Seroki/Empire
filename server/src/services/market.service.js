const pool = require("../database/db");
const cityService = require("./city.service");

const MARKET_RATES = {
  food:   { buyRate: 100, sellRate: 33 },
  lumber: { buyRate: 150, sellRate: 49 },
  wood:   { buyRate: 150, sellRate: 49 }, // Alias for DB compatibility
  stone:  { buyRate: 200, sellRate: 66 },
  iron:   { buyRate: 300, sellRate: 99 }
};

// Map frontend resource key to database column name
function getDbColumn(resourceKey) {
  const key = resourceKey.toLowerCase();
  if (key === "lumber") return "wood";
  if (["food", "wood", "stone", "iron"].includes(key)) return key;
  throw new Error("Invalid resource type");
}

async function getMarketData(cityId) {
  // Always settle pending passive gold income first
  await cityService.resolveGoldIncome(cityId);

  const res = await pool.query(
    `SELECT gold, food, wood, stone, iron FROM city_resources WHERE city_id = $1`,
    [cityId]
  );

  if (res.rows.length === 0) {
    throw new Error("City resources not found");
  }

  const row = res.rows[0];
  return {
    gold: Number(row.gold || 0),
    resources: {
      food: Number(row.food || 0),
      wood: Number(row.wood || 0), // Maps DB 'wood' to UI 'lumber'
      stone: Number(row.stone || 0),
      iron: Number(row.iron || 0)
    }
  };
}

async function executeBuy(cityId, resourceKey, goldSpent) {
  const dbCol = getDbColumn(resourceKey);
  const rateConfig = MARKET_RATES[resourceKey];
  const lots = Math.floor(goldSpent / rateConfig.buyRate);

  if (lots <= 0) {
    throw new Error(`Minimum purchase requires at least ${rateConfig.buyRate} Gold.`);
  }

  const actualGoldCost = lots * rateConfig.buyRate;
  const resourceGained = lots * 10;

  const client = await pool.connect();
  try {
    await client.query("BEGIN");

    // Settle pending gold before checking balance
    await cityService.resolveGoldIncome(cityId);

    const checkRes = await client.query(
      `SELECT gold FROM city_resources WHERE city_id = $1 FOR UPDATE`,
      [cityId]
    );

    if (checkRes.rows.length === 0) throw new Error("City not found");
    
    const currentGold = Number(checkRes.rows[0].gold || 0);
    if (currentGold < actualGoldCost) {
      throw new Error("Insufficient Gold available in city treasury.");
    }

    // Deduct Gold and increment target resource
    await client.query(
      `UPDATE city_resources 
       SET gold = gold - $1, 
           ${dbCol} = ${dbCol} + $2,
           updated_at = NOW() 
       WHERE city_id = $3`,
      [actualGoldCost, resourceGained, cityId]
    );

    await client.query("COMMIT");
    return { success: true, goldSpent: actualGoldCost, resourceGained };
  } catch (err) {
    await client.query("ROLLBACK");
    throw err;
  } finally {
    client.release();
  }
}

async function executeSell(cityId, resourceKey, quantity) {
  const dbCol = getDbColumn(resourceKey);
  const rateConfig = MARKET_RATES[resourceKey];
  const lots = Math.floor(quantity / 10);

  if (lots <= 0) {
    throw new Error("Minimum sale requires at least 10 units.");
  }

  const actualResSold = lots * 10;
  const goldGained = lots * rateConfig.sellRate;

  const client = await pool.connect();
  try {
    await client.query("BEGIN");

    // Settle pending gold
    await cityService.resolveGoldIncome(cityId);

    const checkRes = await client.query(
      `SELECT ${dbCol} FROM city_resources WHERE city_id = $1 FOR UPDATE`,
      [cityId]
    );

    if (checkRes.rows.length === 0) throw new Error("City not found");

    const currentStock = Number(checkRes.rows[0][dbCol] || 0);
    if (currentStock < actualResSold) {
      throw new Error(`Insufficient ${resourceKey} available to sell.`);
    }

    // Add Gold and deduct target resource
    await client.query(
      `UPDATE city_resources 
       SET gold = gold + $1, 
           ${dbCol} = ${dbCol} - $2,
           updated_at = NOW() 
       WHERE city_id = $3`,
      [goldGained, actualResSold, cityId]
    );

    await client.query("COMMIT");
    return { success: true, goldGained, resourceSold: actualResSold };
  } catch (err) {
    await client.query("ROLLBACK");
    throw err;
  } finally {
    client.release();
  }
}

module.exports = {
  getMarketData,
  executeBuy,
  executeSell
};
