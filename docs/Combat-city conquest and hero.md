Volume IX — City Conquest, Resource Plunder, and Hero SystemsThis volume provides the complete, engine-ready mechanics for city state transitions (loyalty, public grievance, conquest), load-based resource plundering with warehouse protections, tavern hero pool generation algorithms, and battle/task experience scaling.🏛️ 1. City Loyalty & Public Grievance EngineCity ownership and conquest rely on two core server variables: Loyalty ($L$) and Public Grievance ($G$). 
		      +----------------------------------+
                      |       Successful Siege Wave      |
                      +----------------------------------+
                                       |
                                       v
                      +----------------------------------+
                      | Calculate Base Loyalty Reduction |
                      | (L > 50: -2 | 15..50: -1 | <15: -1)
                      +----------------------------------+
                                       |
                                       v
                      +----------------------------------+
                      |    Increase Public Grievance     |
                      |          (+2 per attack)         |
                      +----------------------------------+
                                       |
                                       v
                      +----------------------------------+
                      |   Check Tax & Population Drift   |
                      |   Target Loyalty = 100 - Tax - G |
                      +----------------------------------+
                                       |
                         +-------------+-------------+
                         |                           |
                 L > 0   v                           v   L = 0
       +-----------------------+           +-----------------------+
       | City Defends/Survives |           |  Conquest Condition?  |
       +-----------------------+           |  - Open City Slot?    |
                                           |  - Non-Capital City?  |
                                           +-----------+-----------+
                                                       |
                                           +-----------+-----------+
                                     YES   |                       |   NO
                                           v                       v
                               +-----------------------+ +-----------------------+
                               | Transfer City Ownership| |  Raze / Max Grievance|
                               +-----------------------+ +-----------------------+
1.1 Loyalty Decay Formula (Per Successful Attack)When an enemy army defeats all defending forces in a city, Loyalty drops based on current thresholds:$$\Delta L = \begin{cases}  2 & \text{if } L > 50 \\ 1 & \text{if } 15 < L \le 50 \\ 1 & \text{if } L \le 15 \text{ (15-minute server tick cooldown applied under 15)} \end{cases}$$Simultaneously, Public Grievance increases by $+2$ per successful attack (capped at $100$).1.2 Passive Loyalty Tick (Every 6 Minutes)Every 6 minutes, city loyalty naturally drifts toward its Target Loyalty Equilibrium:$$L_{\text{target}} = \max(0, 100 - \text{TaxRate} - G)$$$$\text{If } L > L_{\text{target}} \implies L = L - 1$$$$\text{If } L < L_{\text{target}} \implies L = L + 1$$1.3 Conquest Resolution RuleA city is successfully conquered on an attack if and only if:Dealt damage reduces city Loyalty to 0.Target city is NOT the player's last remaining city (Main Capital protection).Attacking player has an available city slot granted by Title:Civic Title Caps: Civilian ($1$), Knight ($2$), Baron ($3$), Viscount ($4$), Earl ($5$), Marquis ($6$), Duke ($7$), Furst ($8$), Prinz ($9$).💰 2. Plunder Engine & Warehouse MechanicsWhen a siege succeeds, resources are taken based on total army transport capacity, relative resource weight, and Warehouse Protection Level.2.1 Troop Carrying Capacity MatrixUnit TypeBase Load CapacityWorker20Warrior80Scout5Pikeman40Swordsman30Archer20Cavalry100Cataphract130Transporter10,000Ballista20Battering Ram140Catapult250$$\text{Total Load Cap} = \sum (\text{UnitCount}_i \times \text{BaseLoad}_i) \times \left(1 + \frac{\text{LogisticsLevel} \times 10}{100}\right)$$2.2 Warehouse Protection FormulaResources stored under the city's warehouse threshold are completely immune to plunder:$$\text{Protected Cap} = \text{WarehouseLevel} \times 100,000 \times \left(1 + \frac{\text{StockpilingLevel} \times 10}{100}\right)$$$$\text{Plunderable Resource}_R = \max(0, \text{Resource}_R - \text{Protected Cap})$$Where $R \in \{\text{Food}, \text{Lumber}, \text{Stone}, \text{Iron}\}$. Gold has no warehouse protection and is $100\%$ plunderable.2.3 Plunder Distribution AlgorithmResources are drained proportionally to their available ratios until the marching army's total load cap is saturated:JavaScriptfunction calculatePlunder(armyCapacity, cityResources, warehouseCap) {
  let available = {
    gold: cityResources.gold,
    food: Math.max(0, cityResources.food - warehouseCap),
    lumber: Math.max(0, cityResources.lumber - warehouseCap),
    stone: Math.max(0, cityResources.stone - warehouseCap),
    iron: Math.max(0, cityResources.iron - warehouseCap)
  };

  let totalAvailable = Object.values(available).reduce((a, b) => a + b, 0);
  let plundered = { gold: 0, food: 0, lumber: 0, stone: 0, iron: 0 };

  if (totalAvailable === 0) return plundered;

  let lootRatio = Math.min(1.0, armyCapacity / totalAvailable);

  for (let res in available) {
    plundered[res] = Math.floor(available[res] * lootRatio);
  }

  return plundered;
}
🍻 3. Hero Inn Generation SystemHero generation follows the classic Age I stat math, where a hero's viability is evaluated by their Base Stat Value relative to level:$$\text{Base Stat} = \text{Primary Stat} - \text{Hero Level}$$Standard Inn Heroes: Base stats range between $50$ and $69$.Holy War / Historic Heroes: Unique base stats ranging from $70$ to $90+$.                       +----------------------------------+
                       |       Player Opens Inn UI        |
                       +----------------------------------+
                                       |
                                       v
                       +----------------------------------+
                       | Determine Hero Slot Count        |
                       | Slots = Inn Building Level (1..10)|
                       +----------------------------------+
                                       |
                                       v
                       +----------------------------------+
                       | Generate Hero Array Loop          |
                       +----------------------------------+
                                       |
                                       v
                       +----------------------------------+
                       | Roll Hero Level:                 |
                       | Lvl = Random(1, InnLevel * 3)    |
                       +----------------------------------+
                                       |
                                       v
                       +----------------------------------+
                       | Roll Archetype (Pol/Atk/Intel)   |
                       | Primary Base = Random(50, 69)     |
                       | Secondary Bases = Random(10, 30) |
                       +----------------------------------+
                                       |
                                       v
                       +----------------------------------+
                       | Assign Level Allocations         |
                       | Add Level points to Primary Base |
                       +----------------------------------+
3.1 Engine Generation Algorithm (hero_generator.js)JavaScriptconst HERO_NAMES = ["Arthur", "Lancelot", "Gawain", "Roland", "Boadicea", "Aethelgard", "Gideon", "Vane"];

function generateTavernPool(innLevel) {
  let heroPool = [];
  let poolSize = innLevel; // 1 hero per Inn level

  for (let i = 0; i < poolSize; i++) {
    // 1. Level roll scaled to Inn Level
    let level = Math.floor(Math.random() * (innLevel * 3)) + 1;

    // 2. Roll Base Stat Archetype (50 to 69 Base for standard Inn)
    let primaryBase = Math.floor(Math.random() * 20) + 50; 
    let secBase1 = Math.floor(Math.random() * 20) + 10;
    let secBase2 = Math.floor(Math.random() * 20) + 10;

    // 3. Select Archetype: 0 = Politics, 1 = Attack, 2 = Intelligence
    let archetype = Math.floor(Math.random() * 3);
    let pol, atk, intel;

    if (archetype === 0) {
      pol = primaryBase + level; // All leveled stat gains drop into primary
      atk = secBase1;
      intel = secBase2;
    } else if (archetype === 1) {
      pol = secBase1;
      atk = primaryBase + level;
      intel = secBase2;
    } else {
      pol = secBase1;
      atk = secBase2;
      intel = primaryBase + level;
    }

    let hiringCost = level * 1000;  // Hiring Fee = Level * 1,000 Gold
    let hourlySalary = level * 20;   // Salary = Level * 20 Gold/hr

    heroPool.push({
      name: HERO_NAMES[Math.floor(Math.random() * HERO_NAMES.length)],
      level,
      politics: pol,
      attack: atk,
      intelligence: intel,
      loyalty: 70,
      hiringCost,
      hourlySalary
    });
  }

  return heroPool;
}
📈 4. Hero Experience & Progression MechanicsHeroes earn Experience Points ($\text{XP}$) from combat resolution and mayor task execution.4.1 Combat Experience GainsXP earned in combat is directly derived from the total HP of enemy units killed during the engagement, modified by the target's threat tier:$$\text{XP}_{\text{combat}} = \sum (\text{KilledEnemyUnits}_i \times \text{BaseHP}_i) \times \text{OutcomeMultiplier}$$Outcome Multipliers:Victory: $1.0\times$Defeat: $0.33\times$4.2 Mayor Passive Experience GainsCities with an assigned Mayor grant passive hourly XP derived from resource production and city construction completions:$$\text{XP}_{\text{hourly\_mayor}} = \lfloor \text{BaseResourceProduction} \times 0.001 \rfloor$$4.3 Level-Up Requirement Matrix & FormulaThe XP needed to reach the next level scales quadratically:$$\text{RequiredXP}(\text{Level}) = 100 \times \text{Level}^2$$JavaScriptfunction processHeroExperience(hero, gainedXp) {
  hero.experience += gainedXp;
  let leveledUp = false;

  while (true) {
    let xpForNextLevel = 100 * Math.pow(hero.level, 2);
    if (hero.experience >= xpForNextLevel) {
      hero.experience -= xpForNextLevel;
      hero.level += 1;
      hero.unassignedStatPoints += 1; // 1 free point per level gain
      leveledUp = true;
    } else {
      break;
    }
  }

  return { currentLevel: hero.level, remainingXp: hero.experience, leveledUp };
}
💾 5. Integrated Database Extensions (conquest_hero_schema.sql)SQL-- Extended City Metrics for Loyalty and Grievance Loop
ALTER TABLE cities ADD COLUMN loyalty INTEGER DEFAULT 100;
ALTER TABLE cities ADD COLUMN public_grievance INTEGER DEFAULT 0;
ALTER TABLE cities ADD COLUMN tax_rate INTEGER DEFAULT 20;

-- Heroes Persistent State
CREATE TABLE IF NOT EXISTS heroes (
    hero_id INTEGER PRIMARY KEY AUTOINCREMENT,
    user_id INTEGER NOT NULL,
    city_id INTEGER DEFAULT NULL, -- NULL if marching or unassigned
    name TEXT NOT NULL,
    level INTEGER NOT NULL DEFAULT 1,
    experience INTEGER NOT NULL DEFAULT 0,
    politics INTEGER NOT NULL,
    attack INTEGER NOT NULL,
    intelligence INTEGER NOT NULL,
    unassigned_points INTEGER DEFAULT 0,
    loyalty INTEGER DEFAULT 70,
    status TEXT CHECK(status IN ('IDLE', 'MAYOR', 'MARCHING', 'CAPTURED')) DEFAULT 'IDLE',
    FOREIGN KEY(user_id) REFERENCES users(user_id),
    FOREIGN KEY(city_id) REFERENCES cities(city_id)
);

-- Inn Daily/Refreshed Pool Tracking
CREATE TABLE IF NOT EXISTS tavern_pools (
    city_id INTEGER PRIMARY KEY,
    generated_at INTEGER NOT NULL,
    pool_json JSON NOT NULL, -- Array of serialized recruitables
    FOREIGN KEY(city_id) REFERENCES cities(city_id) ON DELETE CASCADE
);
Single Follow-Up Question
