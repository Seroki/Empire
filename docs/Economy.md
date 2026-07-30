Architectural Review & Mechanical Integration Here is the architectural review for GDS Volume IX — Economy for a Node.js + SQLite deterministic tick engine.To ensure exact parity with Evony Age I, three subtle tick behaviors must be enforced in the background runtime:Sub-second Floating-Point Accumulation vs. Integer Storage: Production and upkeep accrue continuously on fractional time steps ($\Delta t$). To prevent rounding errors or DB write fatigue, the engine computes resource updates in memory as floats and flushes truncated integer values to SQLite during state persistence ticks or state-querying endpoints.Refined Mayor Production Math: In original Age I, Mayor Politics boosts resource field base output, but does not multiply Town Hall base production or Valley percentage buffs. Valleys (lakes, forests, hills) apply as an additive percentage modifier to field output alongside research technology.Refuge State Trigger (Zero Food Loop): When $Res_{\text{food}} = 0$ and $Net_{\text{food}} < 0$, troops do not vanish all at once. Instead, a Refuge Tick triggers: every 15 minutes at zero food, approximately $10\%$ of total troops desert (are removed from the database), prioritizing highest-upkeep units (Cavalry/Cataphracts/Siege) first until upkeep drops back to $\le Prod_{\text{food}}$.📘 Volume IX — Economy Engine (Node.js + SQLite Specification)            
             +-----------------------------------------------+
             |         Delta-t Economy Loop Trigger          |
             +-----------------------------------------------+
                                     |
                                     v
             +-----------------------------------------------+
             |  Load City Fields, Tech, Mayor & Valleys      |
             +-----------------------------------------------+
                                     |
                                     v
             +-----------------------------------------------+
             | Calculate Field Base Output & Valley Modifiers|
             +-----------------------------------------------+
                                     |
                                     v
             +-----------------------------------------------+
             |  Apply Tech (+5%/lvl) & Mayor (+1%/Pol) Buffs |
             +-----------------------------------------------+
                                     |
                                     v
             +-----------------------------------------------+
             |   Calculate Net Rates (Prod - Army Upkeep)    |
             +-----------------------------------------------+
                                     |
                 +-------------------+-------------------+
                 |                                       |
          Food Net >= 0                           Food Net < 0
                 |                                       |
                 v                                       v
    +-------------------------+             +-------------------------+
    | Add Accrued Food to Stock|            | Deduct Food from Stock  |
    |  Cap at Warehouse Limit |             +-------------------------+
    +-------------------------+                          |
                                           +-------------+-------------+
                                           |                           |
                                     Food Stock > 0             Food Stock == 0
                                           |                           |
                                           v                           v
                                +---------------------+     +---------------------+
                                | Normal Consumption  |     | Trigger Refuge Tick |
                                +---------------------+     | (Deserters -10%/15m)|
                                                            +---------------------+
💾 1. Database Schema (economy_schema.sql)SQL-- City Resource Stock & Storage Caps
CREATE TABLE IF NOT EXISTS city_resources (
    city_id INTEGER PRIMARY KEY,
    food REAL DEFAULT 5000.0,
    lumber REAL DEFAULT 5000.0,
    stone REAL DEFAULT 5000.0,
    iron REAL DEFAULT 5000.0,
    gold REAL DEFAULT 5000.0,
    last_updated_at INTEGER NOT NULL, -- Unix Timestamp (ms)
    FOREIGN KEY(city_id) REFERENCES cities(city_id) ON DELETE CASCADE
);

-- City Resource Fields Mapping
CREATE TABLE IF NOT EXISTS resource_fields (
    field_id INTEGER PRIMARY KEY AUTOINCREMENT,
    city_id INTEGER NOT NULL,
    slot_index INTEGER NOT NULL, -- 1 to 40
    field_type TEXT CHECK(field_type IN ('FARM', 'SAWMILL', 'QUARRY', 'IRONMINE')) NOT NULL,
    level INTEGER DEFAULT 1,
    FOREIGN KEY(city_id) REFERENCES cities(city_id) ON DELETE CASCADE
);

-- Population & Tax Configuration
CREATE TABLE IF NOT EXISTS city_population (
    city_id INTEGER PRIMARY KEY,
    tax_rate INTEGER DEFAULT 20, -- Tax Rate % (0 to 100)
    public_grievance INTEGER DEFAULT 0,
    loyalty INTEGER DEFAULT 80,
    idle_population INTEGER DEFAULT 0,
    FOREIGN KEY(city_id) REFERENCES cities(city_id) ON DELETE CASCADE
);
📐 2. Resource Production Engine (economy_calculator.js)JavaScript/**
 * Evony Age I Resource Production Calculations
 */

// Base Field Outputs per Hour by Level (Levels 1 to 10)
const BASE_FIELD_PRODUCTION = {
  FARM:     [0, 100, 300, 600, 1000, 1500, 2100, 2800, 3600, 4500, 5500],
  SAWMILL:  [0, 100, 300, 600, 1000, 1500, 2100, 2800, 3600, 4500, 5500],
  QUARRY:   [0, 80,  240, 480, 800,  1200, 1680, 2240, 2880, 3600, 4400],
  IRONMINE: [0, 50,  150, 300, 500,  750,  1050, 1400, 1800, 2250, 2750]
};

// Troop Food Upkeep per Hour
const TROOP_UPKEEP = {
  Worker: 2, Warrior: 3, Scout: 5, Pikeman: 6, Swordsman: 7,
  Archer: 9, Cavalry: 18, Cataphract: 35, Transporter: 10,
  Ballista: 50, BatteringRam: 100, Catapult: 250
};

function calculateCityProduction(fields, techs, mayor, valleys) {
  let baseProd = { FARM: 0, SAWMILL: 0, QUARRY: 0, IRONMINE: 0 };

  // 1. Sum up base field production
  fields.forEach(field => {
    if (field.level > 0 && BASE_FIELD_PRODUCTION[field.field_type]) {
      baseProd[field.field_type] += BASE_FIELD_PRODUCTION[field.field_type][field.level];
    }
  });

  // 2. Tech Buffs (+5% per level)
  let techBuffs = {
    FARM: (techs.agricultureLevel || 0) * 0.05,
    SAWMILL: (techs.lumberingLevel || 0) * 0.05,
    QUARRY: (techs.masonryLevel || 0) * 0.05,
    IRONMINE: (techs.miningLevel || 0) * 0.05
  };

  // 3. Mayor Politics Buff (1% per Politics point)
  let mayorBuff = mayor ? (mayor.politics / 100) : 0;

  // 4. Valley Buffs (Percentage additions from owned valleys)
  let valleyBuffs = {
    FARM: (valleys.lakeBonus || 0) + (valleys.swampBonus || 0) + (valleys.grasslandBonus || 0),
    SAWMILL: (valleys.forestBonus || 0),
    QUARRY: (valleys.desertBonus || 0),
    IRONMINE: (valleys.hillBonus || 0)
  };

  // 5. Compute Final Hourly Production
  // Formula: BaseField * (1 + Tech + Mayor + Valley) + TownHallBase
  let finalProd = {
    food: Math.floor(baseProd.FARM * (1 + techBuffs.FARM + mayorBuff + valleyBuffs.FARM) + 100),
    lumber: Math.floor(baseProd.SAWMILL * (1 + techBuffs.SAWMILL + mayorBuff + valleyBuffs.SAWMILL) + 100),
    stone: Math.floor(baseProd.QUARRY * (1 + techBuffs.QUARRY + mayorBuff + valleyBuffs.QUARRY) + 100),
    iron: Math.floor(baseProd.IRONMINE * (1 + techBuffs.IRONMINE + mayorBuff + valleyBuffs.IRONMINE) + 100)
  };

  return finalProd;
}

function calculateHourlyUpkeep(cityTroops) {
  let totalUpkeep = 0;
  for (const [unitType, count] of Object.entries(cityTroops)) {
    if (TROOP_UPKEEP[unitType] && count > 0) {
      totalUpkeep += count * TROOP_UPKEEP[unitType];
    }
  }
  return totalUpkeep;
}
⏱️ 3. Population & Tax Equilibrium EnginePopulation dynamically approaches an equilibrium based on available Cottage Capacity, Tax Rate, and Public Grievance.JavaScript/**
 * Calculates Cottage Capacity, Target Population, and Gold Income
 */
function updatePopulationState(cottages, taxRate, publicGrievance, currentLoyalty) {
  // Cottage Capacity: ~1,000 pop per cottage level
  let maxPopulation = cottages.reduce((sum, lvl) => sum + (lvl * 1000), 0);

  // Target Loyalty Equilibrium Formula: 100 - TaxRate - Grievance
  let targetLoyalty = Math.max(0, 100 - taxRate - publicGrievance);

  // Current Working Population based on Loyalty %
  let currentPopulation = Math.floor(maxPopulation * (currentLoyalty / 100));

  // Hourly Gold Generation: Population * Tax Rate %
  let hourlyGold = Math.floor(currentPopulation * (taxRate / 100));

  return {
    maxPopulation,
    targetLoyalty,
    currentPopulation,
    hourlyGold
  };
}
⚡ 4. Complete Economy Tick Runtime (economy_tick_engine.js)This function executes on game ticks to compute delta time updates across all resources, capping production at storage limits and executing the Refuge System when food runs out.JavaScript/**
 * Delta-t City State Economy Process
 */
function processCityEconomyTick(cityData, currentTimeMs) {
  const deltaSeconds = (currentTimeMs - cityData.resources.last_updated_at) / 1000;
  if (deltaSeconds <= 0) return cityData;

  const hoursElapsed = deltaSeconds / 3600;

  // 1. Calculate Gross Production & Upkeep
  const production = calculateCityProduction(
    cityData.fields,
    cityData.techs,
    cityData.mayor,
    cityData.valleys
  );
  const foodUpkeep = calculateHourlyUpkeep(cityData.troops);

  // 2. Net Rates
  const netFoodPerHour = production.food - foodUpkeep;
  const netLumberPerHour = production.lumber;
  const netStonePerHour = production.stone;
  const netIronPerHour = production.iron;

  // Population & Gold Income
  const popState = updatePopulationState(
    cityData.cottageLevels,
    cityData.population.tax_rate,
    cityData.population.public_grievance,
    cityData.population.loyalty
  );

  // 3. Update Resource Stocks
  let newFood = cityData.resources.food + (netFoodPerHour * hoursElapsed);
  let newLumber = cityData.resources.lumber + (netLumberPerHour * hoursElapsed);
  let newStone = cityData.resources.stone + (netStonePerHour * hoursElapsed);
  let newIron = cityData.resources.iron + (netIronPerHour * hoursElapsed);
  let newGold = cityData.resources.gold + (popState.hourlyGold * hoursElapsed);

  // 4. Handle Starvation & Refuge Logic
  let refugeTriggered = false;
  if (newFood <= 0) {
    newFood = 0;
    if (netFoodPerHour < 0) {
      refugeTriggered = true;
      executeRefugeDesertion(cityData.troops, 0.10); // 10% troop desertion per tick
    }
  }

  // 5. Apply Storage Caps (Town Hall / Warehouse Storage Limit)
  const maxCap = cityData.storageCap;
  cityData.resources.food = Math.min(newFood, maxCap);
  cityData.resources.lumber = Math.min(newLumber, maxCap);
  cityData.resources.stone = Math.min(newStone, maxCap);
  cityData.resources.iron = Math.min(newIron, maxCap);
  cityData.resources.gold = newGold; // Gold does not cap
  cityData.resources.last_updated_at = currentTimeMs;

  return {
    updatedResources: cityData.resources,
    refugeTriggered,
    populationSummary: popState
  };
}

function executeRefugeDesertion(cityTroops, desertionRate) {
  // Desertion order: Highest upkeep first to protect lower tier units
  const desertionPriority = [
    'Catapult', 'BatteringRam', 'Ballista', 'Cataphract', 
    'Cavalry', 'Archer', 'Swordsman', 'Pikeman', 'Scout', 'Warrior', 'Worker'
  ];

  desertionPriority.forEach(unit => {
    if (cityTroops[unit] && cityTroops[unit] > 0) {
      let lost = Math.ceil(cityTroops[unit] * desertionRate);
      cityTroops[unit] = Math.max(0, cityTroops[unit] - lost);
    }
  });
}
