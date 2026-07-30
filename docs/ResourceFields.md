### Executive Evaluation & Architectural Feedback

Your outline for **Volume IV — Resource Fields** hits the core mechanics of *Evony Age I*, but a few critical data points, formulas, and structural edge cases need to be refined before finalizing the Game Design Specification (GDS):

#### 1. Formula & Worker Allocation Corrections

* **Worker Allocation Formula:** In original *Age I*, workers do not act as an additive multiplier in the form of $(1 + \frac{\text{Workers}}{\text{Max Workers}})$. Instead, labor acts as an **operational availability percentage (Labor Rate)** applied directly to the base production capacity:

$$\text{Labor Efficiency} = \min\left(1.0, \, \frac{\text{Idle Population}}{\text{Required Population}}\right)$$


* **Additive Multiplier Structure:** Valley bonuses, Technology bonuses, and Hero Politics are **additive** with each other inside the modifier multiplier, rather than purely cumulative compound products. The true *Age I* hourly production formula is:

$$\text{Hourly Production} = \left( \sum \text{Base Production} \right) \times \text{Labor Efficiency} \times \left( 1 + \frac{\text{Mayor Politics}}{100} + \text{Tech Bonus} + \sum \text{Valley Bonuses} + \text{Item Buffs} \right)$$



#### 2. Base Production Level Curve Precision

The base production numbers for Level 1 through Level 10 across all standard resource fields (Farm, Sawmill, Quarry, Iron Mine) follow a distinct, fixed non-linear progression in *Evony Age I*, rather than a strict linear step:

* **Level 1:** $100$ / hr
* **Level 2:** $300$ / hr
* **Level 3:** $600$ / hr
* **Level 4:** $1,000$ / hr
* **Level 5:** $1,500$ / hr
* **Level 6:** $2,100$ / hr
* **Level 7:** $2,800$ / hr
* **Level 8:** $3,600$ / hr
* **Level 9:** $4,500$ / hr
* **Level 10:** $5,500$ / hr *(Note: Level 10 reaches 5,500 base/hr, requiring 1× Michelangelo's Script)*

#### 3. Valley Percentage Discrepancies

* **Lakes & Food:** Level 10 Lakes provide a **$+40\%$** bonus to Food production (Lakes range from $+13\%$ at L1 to $+40\%$ at L10).
* **Swamps & Grasslands:** Swamps range from $+10\%$ (L1) to $+37\%$ (L10) for Food. Grasslands range from $+8\%$ (L1) to $+35\%$ (L10).
* **Forests, Hills, Deserts:** Level 10 Forest, Hill, and Desert valleys cap at **$+27\%$** for Wood, Iron, and Stone respectively (scaling from $+9\%$ at Level 1 to $+27\%$ at Level 10, strictly $+2\%$ per level).

---

# 📘 **Volume IV — Resource Fields (Full Mechanical Edition)**

### *Evony Age I Recreation — Complete Resource System Reference*

---

## 🌾 **1. Farm (Food Production)**

### **Description**

Agricultural field dedicated to cultivating crops. Sustains the city's population and supplies the upkeep required for standing armies.

### **Purpose**

Primary food source. Feeds civilian labor and prevents troop starvation.

### **Maximum Level**

10 (Level 10 requires 1× Michelangelo's Script)

### **Costs & Build Time**

* **Level 1:** Food: 200 | Wood: 200 | Stone: 100 | Iron: 100 | Time: 15s
* **Level 2:** Food: 400 | Wood: 400 | Stone: 200 | Iron: 200 | Time: 45s
* **Level 3:** Food: 800 | Wood: 800 | Stone: 400 | Iron: 400 | Time: 2m 15s
* **Scaling:** Multiplies exponentially ($\approx 2.0\times$ resource cost per level).

### **Base Production Curve**

* Level 1: $100$ / hr | Required Labor: 10
* Level 2: $300$ / hr | Required Labor: 20
* Level 3: $600$ / hr | Required Labor: 35
* Level 4: $1,000$ / hr | Required Labor: 55
* Level 5: $1,500$ / hr | Required Labor: 80
* Level 6: $2,100$ / hr | Required Labor: 110
* Level 7: $2,800$ / hr | Required Labor: 145
* Level 8: $3,600$ / hr | Required Labor: 185
* Level 9: $4,500$ / hr | Required Labor: 230
* Level 10: $5,500$ / hr | Required Labor: 280

### **Effects & Modifiers**

* Produces Food continuously on server tick (every 360 seconds / 6 minutes).
* **Technology Modifier:** Agriculture ($+5\%$ per level, max $+50\%$ at Level 10).
* **Valley Modifiers:**
* **Lake:** $+13\%$ (L1) to $+40\%$ (L10)
* **Swamp:** $+10\%$ (L1) to $+37\%$ (L10)
* **Grassland:** $+8\%$ (L1) to $+35\%$ (L10)



### **Dependencies**

* Town Hall Level 1
* Available Outer Field Plot

### **Unlocks**

* Allows higher troop upkeep capacities without triggering negative production panics.

### **UI**

* Located in the Outer City View.
* Renders current hourly output, worker allocation percentage, and breakdown modal showing Base production vs. Hero/Tech/Valley bonuses.

### **Original Age I Behavior**

* **Troop Upkeep & Starvation:** Troops consume Food continuously from the host city:

$$\text{Net Food Output} = \text{Gross Food Production} - \text{Total Troop Upkeep}$$



If Net Food is negative, the city's stored Food reserves deplete. When stored Food hits **exactly 0**, troops enter **Refugee Status**, where $10\%$ of total army units desert every 6-minute tick until reserves are replenished or troops starve down to sustainable levels.

### **Notes for Recreation**

* Must support negative net production values without throwing database integer underflows.

---

## 🌲 **2. Sawmill (Wood Production)**

### **Description**

Lumber processing yard that harvests timber from surrounding woodlands.

### **Purpose**

Primary wood source. Used extensively for city structural upgrades, Wall Archer Towers, Bowmen, and Siege Engines.

### **Maximum Level**

10 (Level 10 requires 1× Michelangelo's Script)

### **Costs & Build Time**

* **Level 1:** Food: 100 | Wood: 100 | Stone: 250 | Iron: 300 | Time: 15s
* **Scaling:** Multiplies exponentially ($\approx 2.0\times$ resource cost per level).

### **Base Production Curve**

* Follows standard curve: $100, 300, 600, 1000, 1500, 2100, 2800, 3600, 4500, 5500$ / hr.
* Labor requirements match Farm progression ($10 \to 280$ workers per level).

### **Effects & Modifiers**

* **Technology Modifier:** Lumbering ($+5\%$ per level, max $+50\%$ at Level 10).
* **Valley Modifier:**
* **Forest:** $+9\%$ (L1) to $+27\%$ (L10) ($+2\%$ per valley level).



### **Dependencies**

* Town Hall Level 1
* Available Outer Field Plot

### **Unlocks**

* Prerequisite resource for Archery-based military infrastructure.

### **UI**

* Outer City View wood plot, yield metrics, capacity details.

### **Original Age I Behavior**

* Wood is the primary bottleneck resource in early-to-mid game due to heavy demand for Archer Towers and mass Archer recruitment. Players standardly build a $3:1$ ratio of Sawmills to other non-farm fields.

### **Notes for Recreation**

* Preserve original field distribution options; players must be able to demolish existing Quarries/Mines to build additional Sawmills.

---

## 🪨 **3. Quarry (Stone Production)**

### **Description**

Stone extraction pit providing raw masonry for city fortification and defensive structures.

### **Purpose**

Primary stone source. Essential for Wall expansion, Wall Fortifications (Archer Towers, Traps, Trebuchets), and Town Hall progression.

### **Maximum Level**

10 (Level 10 requires 1× Michelangelo's Script)

### **Costs & Build Time**

* **Level 1:** Food: 300 | Wood: 200 | Stone: 100 | Iron: 300 | Time: 20s
* **Scaling:** Multiplies exponentially ($\approx 2.0\times$ resource cost per level).

### **Base Production Curve**

* Follows standard curve: $100, 300, 600, 1000, 1500, 2100, 2800, 3600, 4500, 5500$ / hr.
* Labor requirements match standard progression.

### **Effects & Modifiers**

* **Technology Modifier:** Masonry ($+5\%$ per level, max $+50\%$ at Level 10).
* **Valley Modifier:**
* **Desert:** $+9\%$ (L1) to $+27\%$ (L10) ($+2\%$ per valley level).



### **Dependencies**

* Town Hall Level 1
* Available Outer Field Plot

### **Unlocks**

* Enables continuous high-tier Wall construction.

### **UI**

* Outer City View stone quarry plot, active mining metrics.

### **Original Age I Behavior**

* Stone demand spikes heavily during early Wall upgrades (Levels 1–8) and Archer Tower construction, but tapers off in late-game. Advanced players often demolish Quarries down to 1 remaining plot once Walls reach Level 10.

### **Notes for Recreation**

* Ensure demolition routines recalculate local labor pools and Stone production instantly upon plot clearance.

---

## ⛏️ **4. Iron Mine (Iron Production)**

### **Description**

Deep shaft mine extracting iron ore needed for forging heavy weaponry, plate armor, and war machinery.

### **Purpose**

Primary iron source. Heavily consumed by high-tier military units (Swordsmen, Cavalry, Cataphracts, Ballistas, Battering Rams).

### **Maximum Level**

10 (Level 10 requires 1× Michelangelo's Script)

### **Costs & Build Time**

* **Level 1:** Food: 300 | Wood: 300 | Stone: 300 | Iron: 100 | Time: 25s
* **Scaling:** Multiplies exponentially ($\approx 2.0\times$ resource cost per level).

### **Base Production Curve**

* Follows standard curve: $100, 300, 600, 1000, 1500, 2100, 2800, 3600, 4500, 5500$ / hr.
* Labor requirements match standard progression.

### **Effects & Modifiers**

* **Technology Modifier:** Mining ($+5\%$ per level, max $+50\%$ at Level 10).
* **Valley Modifier:**
* **Hill:** $+9\%$ (L1) to $+27\%$ (L10) ($+2\%$ per valley level).



### **Dependencies**

* Town Hall Level 1
* Available Outer Field Plot

### **Unlocks**

* Advanced heavy armaments and siege unit production.

### **UI**

* Outer City View mine shaft plot, iron yield metrics.

### **Original Age I Behavior**

* Iron is the late-game bottleneck for high-prestige players assembling massive Armored Cavalry (Cataphract) and Siege fleets.

### **Notes for Recreation**

* Validate that market trade limits and resource capacity properly account for high-volume Iron transactions.

---

## 📐 **5. Universal Master Production Engine & Code Spec**

The production engine resolves resources per city based on time deltas ($\Delta t$) using dynamic evaluation on tick or request.

### **Production Equation**

$$\text{Production Rate (units/hr)} = \left( \sum_{i=1}^{N} \text{Base}(L_i) \right) \times \text{Labor Efficiency} \times \left( 1 + \frac{\text{Mayor Politics}}{100} + \text{Tech Bonus} + \text{Valley Bonus} + \text{Item Buff} \right)$$

Where:

* $N$ = Number of fields of that specific resource type in the city.
* $\text{Base}(L_i)$ = Base hourly yield for field $i$ at level $L$.
* $\text{Labor Efficiency} = \min\left(1.0, \, \frac{\text{Current Idle Population}}{\text{Total Required Labor}}\right)$.
* $\text{Tech Bonus} = \text{Tech Level} \times 0.05$.
* $\text{Valley Bonus} = \sum (\text{Percentage Bonus of all captured valleys of matching type})$.
* $\text{Item Buff} = 0.25$ if an active production buff (e.g., *Agriculture Guidelines*) is applied, else $0.00$.

---

### 💻 **Production Calculation Module (`resourceEngine.js`)**

```javascript
/**
 * resourceEngine.js
 * Core Resource Calculation Engine for Evony Age I Recreation
 */

const BASE_YIELDS = {
  1: 100,
  2: 300,
  3: 600,
  4: 1000,
  5: 1500,
  6: 2100,
  7: 2800,
  8: 3600,
  9: 4500,
  10: 5500
};

const LABORS = {
  1: 10,
  2: 20,
  3: 35,
  4: 55,
  5: 80,
  6: 110,
  7: 145,
  8: 185,
  9: 230,
  10: 280
};

/**
 * Calculates real-time hourly resource production breakdown for a city
 */
function calculateCityProduction(city, player, mayor, valleys) {
  // 1. Calculate Total Required Labor across all fields
  let totalRequiredLabor = 0;
  city.fields.forEach(field => {
    totalRequiredLabor += LABORS[field.level] || 0;
  });

  // 2. Determine Labor Efficiency
  const availablePop = city.idlePopulation;
  const laborEfficiency = totalRequiredLabor > 0 
    ? Math.min(1.0, availablePop / totalRequiredLabor) 
    : 1.0;

  // 3. Compute Base Yields per Resource Type
  const baseRates = { food: 0, wood: 0, stone: 0, iron: 0 };
  city.fields.forEach(field => {
    if (BASE_YIELDS[field.level]) {
      baseRates[field.type] += BASE_YIELDS[field.level];
    }
  });

  // 4. Calculate Modifiers
  const politicsModifier = mayor ? (mayor.politics / 100.0) : 0.0;

  const techModifiers = {
    food: (player.techs.agriculture || 0) * 0.05,
    wood: (player.techs.lumbering || 0) * 0.05,
    stone: (player.techs.masonry || 0) * 0.05,
    iron: (player.techs.mining || 0) * 0.05
  };

  // 5. Aggregate Valley Bonuses
  const valleyModifiers = { food: 0.0, wood: 0.0, stone: 0.0, iron: 0.0 };
  valleys.forEach(v => {
    if (v.type === 'LAKE') valleyModifiers.food += (0.10 + v.level * 0.03); // L1=13%, L10=40%
    if (v.type === 'SWAMP') valleyModifiers.food += (0.07 + v.level * 0.03); // L1=10%, L10=37%
    if (v.type === 'GRASSLAND') valleyModifiers.food += (0.05 + v.level * 0.03); // L1=8%, L10=35%
    if (v.type === 'FOREST') valleyModifiers.wood += (0.07 + v.level * 0.02); // L1=9%, L10=27%
    if (v.type === 'DESERT') valleyModifiers.stone += (0.07 + v.level * 0.02); // L1=9%, L10=27%
    if (v.type === 'HILL') valleyModifiers.iron += (0.07 + v.level * 0.02); // L1=9%, L10=27%
  });

  // 6. Compute Final Hourly Production Rates
  const hourlyProduction = {};
  const resourceTypes = ['food', 'wood', 'stone', 'iron'];

  resourceTypes.forEach(res => {
    const totalMultiplier = 1.0 
      + politicsModifier 
      + techModifiers[res] 
      + valleyModifiers[res] 
      + (city.itemBuffs[res] ? 0.25 : 0.0);

    hourlyProduction[res] = Math.floor(baseRates[res] * laborEfficiency * totalMultiplier);
  });

  // 7. Calculate Net Food Output (Subtract Troop Upkeep)
  const grossFood = hourlyProduction.food;
  const netFood = grossFood - city.troopUpkeep;

  return {
    laborEfficiency,
    totalRequiredLabor,
    hourlyProduction: {
      ...hourlyProduction,
      netFood
    }
  };
}

module.exports = { calculateCityProduction };

```
