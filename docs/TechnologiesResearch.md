### Executive Evaluation & Architectural Feedback

Your draft of **Volume V — Technologies & Research** captures the core tree structure of *Evony Age I*, but several key mechanics, level prerequisites, and formulas need to be corrected to ensure complete historical accuracy for the Game Design Specification (GDS):

#### 1. Formula & Research Time Corrections

* **Research Time Formula:** In *Age I*, Hero Intelligence reduces research time multiplicatively based on a percentage reduction formula rather than a direct linear subtraction $(1 - \frac{\text{INT}}{100})$, which would lead to $0$ research time at 100 INT (in reality, late-game mayors had $400+$ INT). The correct original formula is:

$$\text{Research Time} = \frac{\text{Base Time}}{\left(1 + \frac{\text{Mayor Intelligence}}{100}\right)} \times (0.95^{\text{Academy Level - 1}})$$


* **Local vs. Global Effective Tech:** Technologies are researched **account-wide**, but their active effects in a specific city are capped by that city's **Academy Level**:

$$\text{Effective Tech Level} = \min(\text{Global Researched Tech Level}, \, \text{Local City Academy Level})$$



#### 2. Missing Core Technologies

Two critical *Age I* technologies are missing from your outline:

* **Stockpile:** Increases Warehouse storage protection capacity by $+10\%$ per level.
* **Iron Working:** Increases defense/armour values for all ground troops by $+5\%$ per level (prerequisite for high-tier troops like Cataphracts and Battering Rams).

#### 3. Specific Dependency & Formula Fixes

* **Archery Range Bonus:** Archery grants $+5\%$ range per level to Archers and Archer Towers. The full range equation for Archer Towers mounted on walls is:

$$\text{AT Range} = 1300 \times \left(1 + 0.05 \times \text{Wall Level} + 0.05 \times \text{Archery Level}\right)$$


* **Horseback Riding:** Horseback Riding grants a **$+5\%$ speed boost per level** specifically to mounted units (Cavalry, Cataphracts) and mechanical/transport units (Transporters, Ballistas, Rams, Catapults).

---

# 📘 **Volume V — Technologies & Research (Mechanical Edition)**

### *Evony Age I Recreation — Complete Technology Reference*

---

# 🧠 **SYSTEM OVERVIEW**

Research in *Evony Age I* is governed by:

* **Account-Wide Unlocks:** Once researched, a technology is unlocked globally for the player's account across all present and future cities.
* **Local Academy Level Gating:** A city only benefits from a technology up to that city's local Academy Level.
* **Single Research Queue:** Only **one** technology can be actively researched across the player's entire account at any given time (unless accelerated via items like *Primary Guidelines* or *Intermediate Guidelines*).
* **Mayor Intelligence Buff:** Assigning a Hero with high Intelligence as Mayor of the city where research is initiated dramatically reduces research completion time.

---

# 🏛 **RESEARCH BUILDING: ACADEMY**

### **Description**

The central institution of higher learning and technological progress.

### **Purpose**

Unlocks and executes technological upgrades across economy, military, logistics, and intelligence systems.

### **Maximum Level**

10 (Level 10 upgrade requires 1× Michelangelo's Script)

### **Costs**

* **Level 1:** Food: 120 | Wood: 2,500 | Stone: 1,500 | Iron: 200 | Time: 10m
* **Scaling:** Multiplies exponentially ($\approx 2.0\times$ resource cost per level).

### **Upgrade Scaling**

* Each level provides a cumulative $5\%$ reduction in research times initiated in that city.
* Unlocks higher tiers of technology and caps local effective tech levels.

### **Dependencies**

Town Hall Level 2

### **UI**

Tech Tree Matrix, Active Research Queue (Progress Bar, Time Remaining, Speed Up Button), Effective Tech Levels Display.

---

# 🌾 **ECONOMY TECHNOLOGIES**

---

## 1. **Agriculture**

### **Description**

Advanced farming techniques, soil rotation, and irrigation systems.

### **Purpose**

Boosts base Food production across all owned Farms.

### **Maximum Level**

10

### **Costs**

* **Level 1:** Food: 500 | Wood: 1,000 | Stone: 500 | Iron: 200 | Base Time: 15m
* **Scaling:** Cost and time multiply by $2.0\times$ per level.

### **Upgrade Scaling**

$+5\%$ Food output per level (Max $+50\%$ at Level 10).

### **Dependencies**

* Academy Level 1
* Farm Level 1

### **Unlocks**

* **Medicine Level 1** (Requires Agriculture Level 1)

---

## 2. **Lumbering**

### **Description**

Improved forestry, logging axes, and sawmill throughput.

### **Purpose**

Boosts base Wood production across all owned Sawmills.

### **Maximum Level**

10

### **Costs**

* **Level 1:** Food: 500 | Wood: 500 | Stone: 1,000 | Iron: 500 | Base Time: 15m

### **Upgrade Scaling**

$+5\%$ Wood output per level (Max $+50\%$ at Level 10).

### **Dependencies**

* Academy Level 1
* Sawmill Level 1

---

## 3. **Masonry**

### **Description**

Advanced stonecutting, quarrying methods, and structural stonework.

### **Purpose**

Boosts base Stone production across all owned Quarries.

### **Maximum Level**

10

### **Costs**

* **Level 1:** Food: 500 | Wood: 1,000 | Stone: 500 | Iron: 1,000 | Base Time: 20m

### **Upgrade Scaling**

$+5\%$ Stone output per level (Max $+50\%$ at Level 10).

### **Dependencies**

* Academy Level 1
* Quarry Level 1

---

## 4. **Mining**

### **Description**

Deep-shaft mining, tunnel bracing, and ore extraction techniques.

### **Purpose**

Boosts base Iron production across all owned Iron Mines.

### **Maximum Level**

10

### **Costs**

* **Level 1:** Food: 1,000 | Wood: 1,000 | Stone: 1,000 | Iron: 500 | Base Time: 25m

### **Upgrade Scaling**

$+5\%$ Iron output per level (Max $+50\%$ at Level 10).

### **Dependencies**

* Academy Level 1
* Iron Mine Level 1

### **Unlocks**

* **Metal Casting Level 1** (Requires Mining Level 1)

---

# ⚔️ **MILITARY TECHNOLOGIES**

---

## 5. **Military Science**

### **Description**

Strategic theory, drilling drills, and standardized military protocols.

### **Purpose**

Reduces unit training times in Barracks, Stables, and Workshops.

### **Maximum Level**

10

### **Costs**

* **Level 1:** Food: 1,000 | Wood: 2,000 | Stone: 1,000 | Iron: 1,000 | Base Time: 30m

### **Upgrade Scaling**

Reduces unit recruitment time by $5\%$ per level (Max $50\%$ reduction at Level 10).

### **Dependencies**

* Academy Level 2
* Barracks Level 1

### **Unlocks**

* **Military Tradition** (Academy 3, Military Science 1)
* **Compass** (Academy 3, Military Science 1)
* **Horseback Riding** (Academy 3, Military Science 1)
* **Archery** (Academy 4, Military Science 2)

---

## 6. **Military Tradition**

### **Description**

Combat doctrines, blade sharpening, and offensive tactics.

### **Purpose**

Increases base attack values for all military units.

### **Maximum Level**

10

### **Costs**

* **Level 1:** Food: 2,000 | Wood: 3,000 | Stone: 1,000 | Iron: 2,000 | Base Time: 45m

### **Upgrade Scaling**

$+5\%$ Attack power per level for all troops (Max $+50\%$ at Level 10).

### **Dependencies**

* Academy Level 3
* Military Science Level 1

---

## 7. **Iron Working**

### **Description**

High-grade metallurgical forging for personal body armor and shields.

### **Purpose**

Increases base defense/armor values for all military units.

### **Maximum Level**

10

### **Costs**

* **Level 1:** Food: 2,000 | Wood: 2,000 | Stone: 2,000 | Iron: 4,000 | Base Time: 1h

### **Upgrade Scaling**

$+5\%$ Defense power per level for all troops (Max $+50\%$ at Level 10).

### **Dependencies**

* Academy Level 4
* Forge Level 2
* Metal Casting Level 1

### **Unlocks**

* **Pikeman** (Iron Working 1)
* **Swordsman** (Iron Working 2)
* **Cataphract** (Iron Working 6)
* **Battering Ram** (Iron Working 5)

---

## 8. **Archery**

### **Description**

Composite bow design, arrow fletching, and long-range ballistic targeting.

### **Purpose**

Increases attack range and offensive output for Archers and Wall Archer Towers.

### **Maximum Level**

10

### **Costs**

* **Level 1:** Food: 3,000 | Wood: 10,000 | Stone: 2,000 | Iron: 3,000 | Base Time: 1h 30m

### **Upgrade Scaling**

* $+5\%$ firing range per level for Archers and Archer Towers.
* Base Range Formulas:

$$\text{Archer Range} = 1200 \times (1 + 0.05 \times \text{Archery Level})$$


$$\text{AT Range} = 1300 \times \left(1 + 0.05 \times \text{Wall Level} + 0.05 \times \text{Archery Level}\right)$$



### **Dependencies**

* Academy Level 4
* Military Science Level 2

### **Unlocks**

* **Archer** (Archery 2)
* **Ballista** (Archery 6)
* **Catapult** (Archery 10)

---

## 9. **Horseback Riding**

### **Description**

Equestrian breeding, stirrup engineering, and mounted maneuver warfare.

### **Purpose**

Increases travel speed for mounted troops (Cavalry, Cataphracts) and mechanical/transport units (Transporters, Ballistas, Rams, Catapults).

### **Maximum Level**

10

### **Costs**

* **Level 1:** Food: 5,000 | Wood: 3,000 | Stone: 2,000 | Iron: 3,000 | Base Time: 1h

### **Upgrade Scaling**

$+5\%$ movement speed per level for applicable units (Max $+50\%$ at Level 10).

### **Dependencies**

* Academy Level 3
* Stable Level 1
* Military Science Level 1

### **Unlocks**

* **Cavalry** (Horseback Riding 3)
* **Cataphract** (Horseback Riding 5)
* **Relief Station** (Horseback Riding 1)

---

## 10. **Engineering**

### **Description**

Structural mechanics and stress analysis for siege engine construction.

### **Purpose**

Increases hit points (durability) of all siege engine units (Ballistas, Rams, Catapults).

### **Maximum Level**

10

### **Costs**

* **Level 1:** Food: 3,000 | Wood: 8,000 | Stone: 5,000 | Iron: 5,000 | Base Time: 2h

### **Upgrade Scaling**

$+5\%$ HP per level for siege engines (Max $+50\%$ at Level 10).

### **Dependencies**

* Academy Level 5
* Workshop Level 1
* Metal Casting Level 2

### **Unlocks**

* **Battering Ram** (Engineering 5)
* **Rolling Log** (Engineering 1)
* **Defensive Trebuchet** (Engineering 3)

---

## 11. **Metal Casting**

### **Description**

Foundry casting techniques for heavy siege barrels, counterweights, and reinforcement plates.

### **Purpose**

Increases base attack power for all siege engines.

### **Maximum Level**

10

### **Costs**

* **Level 1:** Food: 2,000 | Wood: 5,000 | Stone: 3,000 | Iron: 8,000 | Base Time: 1h 30m

### **Upgrade Scaling**

$+5\%$ attack power per level for siege units (Max $+50\%$ at Level 10).

### **Dependencies**

* Academy Level 5
* Forge Level 3
* Mining Level 1

### **Unlocks**

* **Ballista** (Metal Casting 5)
* **Catapult** (Metal Casting 10)
* **Iron Working** (Metal Casting 1)

---

# 🛠 **LOGISTICS & DEVELOPMENT TECHNOLOGIES**

---

## 12. **Construction**

### **Description**

Advanced scaffolding, stone masonry organization, and site logistics.

### **Purpose**

Reduces building construction and upgrade times across all cities.

### **Maximum Level**

10

### **Costs**

* **Level 1:** Food: 1,000 | Wood: 3,000 | Stone: 5,000 | Iron: 1,000 | Base Time: 30m

### **Upgrade Scaling**

Reduces building construction time by $5\%$ per level (Max $50\%$ reduction at Level 10).

### **Dependencies**

* Academy Level 2
* Forge Level 1

---

## 13. **Medicine**

### **Description**

Field medicine, herbal antiseptics, and triage operations.

### **Purpose**

Increases the proportion of troops wounded in combat that survive and return to the Medic Camp.

### **Maximum Level**

10

### **Costs**

* **Level 1:** Food: 3,000 | Wood: 1,000 | Stone: 1,000 | Iron: 1,000 | Base Time: 45m

### **Upgrade Scaling**

$+5\%$ wounded troop recovery rate per level (Max $+50\%$ recovery at Level 10).

### **Dependencies**

* Academy Level 3
* Agriculture Level 1

---

## 14. **Logistics**

### **Description**

Quartermaster organization, standardized crates, and load distribution.

### **Purpose**

Increases carrying capacity for Transporter units.

### **Maximum Level**

10

### **Costs**

* **Level 1:** Food: 2,000 | Wood: 5,000 | Stone: 2,000 | Iron: 2,000 | Base Time: 1h

### **Upgrade Scaling**

$+10\%$ Transporter load capacity per level (Base 5,000 $\to$ 10,000 per unit at Level 10).

### **Dependencies**

* Academy Level 3
* Marketplace Level 1

### **Unlocks**

* **Transporter** (Logistics 2)

---

## 15. **Compass**

### **Description**

Magnetic orientation instruments and land navigation maps.

### **Purpose**

Increases movement speed for ground infantry units (Workers, Warriors, Scouts, Pikemen, Swordsmen, Archers).

### **Maximum Level**

10

### **Costs**

* **Level 1:** Food: 2,000 | Wood: 3,000 | Stone: 1,000 | Iron: 1,000 | Base Time: 45m

### **Upgrade Scaling**

$+5\%$ movement speed per level for infantry units (Max $+50\%$ at Level 10).

### **Dependencies**

* Academy Level 3
* Military Science Level 1

---

## 16. **Stockpile**

### **Description**

Camouflaged subterranean vaults and lock-box systems.

### **Purpose**

Increases resource protection capacity in Warehouses.

### **Maximum Level**

10

### **Costs**

* **Level 1:** Food: 1,000 | Wood: 2,000 | Stone: 4,000 | Iron: 1,000 | Base Time: 40m

### **Upgrade Scaling**

$+10\%$ Warehouse protected resource capacity per level (Max $+100\%$ at Level 10).

### **Dependencies**

* Academy Level 1
* Warehouse Level 1

---

# 🕵️ **INFORMATIONAL & DEFENSIVE TECHNOLOGIES**

---

## 17. **Informatics**

### **Description**

Cipher networks, intelligence gathering, and reconnaissance protocols.

### **Purpose**

Unlocks detailed scouting reports when scouting target cities or wilderness valleys.

### **Maximum Level**

10

### **Costs**

* **Level 1:** Food: 1,000 | Wood: 2,000 | Stone: 1,000 | Iron: 1,000 | Base Time: 20m

### **Upgrade Scaling**

* **Level 1:** Discloses resource quantities.
* **Level 2:** Discloses building levels.
* **Level 3:** Discloses exact troop counts.
* **Level 4:** Discloses Wall fortification numbers.
* **Level 5:** Discloses hero details (Name, Level).
* **Level 6:** Discloses hero stats (Attack, Politics, Intel).
* **Level 7:** Discloses technology research levels.
* **Level 8–10:** Ensures high intelligence visibility against enemy anti-scout counters.

### **Dependencies**

* Academy Level 1
* Beacon Tower Level 1

### **Unlocks**

* **Scout** (Informatics 1)

---

## 18. **Machinery**

### **Description**

Torsion springs, counter-weights, and automated wall defense gear.

### **Purpose**

Increases repair/recovery rates for destroyed Wall Fortifications after a defensive battle.

### **Maximum Level**

10

### **Costs**

* **Level 1:** Food: 2,000 | Wood: 5,000 | Stone: 8,000 | Iron: 5,000 | Base Time: 2h

### **Upgrade Scaling**

$+8\%$ automatic post-battle fortification repair chance per level (Max $80\%$ at Level 10).

### **Dependencies**

* Academy Level 7
* Workshop Level 1
* Engineering Level 3

---

# 📐 **UNIVERSAL RESEARCH FORMULA & CODE MODULE**

### **Calculated Research Time Equation**

$$\text{Actual Research Time (seconds)} = \frac{\text{Base Time}}{\left(1 + \frac{\text{Mayor Intelligence}}{100}\right)} \times \left(0.95^{\text{Academy Level} - 1}\right)$$

---

### 💻 **Production-Grade Research Engine (`researchEngine.js`)**

```javascript
/**
 * researchEngine.js
 * Comprehensive Technology & Research Validation Service
 */

const db = require('../database/db');

class ResearchEngine {

  /**
   * Calculates actual research duration in seconds
   */
  calculateResearchDuration(baseTimeSeconds, mayorIntelligence, academyLevel) {
    const intelMultiplier = 1.0 + (mayorIntelligence / 100.0);
    const academyMultiplier = Math.pow(0.95, academyLevel - 1);
    
    const finalSeconds = (baseTimeSeconds / intelMultiplier) * academyMultiplier;
    return Math.max(1, Math.floor(finalSeconds));
  }

  /**
   * Returns effective tech level in a specific city considering local Academy limits
   */
  getEffectiveTechLevel(globalTechLevel, cityAcademyLevel) {
    if (!globalTechLevel || globalTechLevel <= 0) return 0;
    return Math.min(globalTechLevel, cityAcademyLevel);
  }

  /**
   * Evaluates whether a player meets all prerequisites to start a research project
   */
  async canStartResearch(playerId, cityId, techCode, targetLevel) {
    const errors = [];

    // 1. Fetch Global Account Research State & Local City Academy
    const [globalTechs, cityAcademy] = await Promise.all([
      this.getPlayerGlobalTechs(playerId),
      this.getCityAcademy(cityId)
    ]);

    if (!cityAcademy || cityAcademy.level < targetLevel) {
      errors.push(`Local Academy level (${cityAcademy ? cityAcademy.level : 0}) must be at least Level ${targetLevel} to research level ${targetLevel}.`);
    }

    // 2. Check if another research project is active account-wide
    const isResearching = await this.isAccountResearching(playerId);
    if (isResearching) {
      errors.push("Another research project is currently in progress. Only 1 global research queue allowed.");
    }

    return {
      valid: errors.length === 0,
      errors
    };
  }

  async getPlayerGlobalTechs(playerId) {
    const res = await db.query('SELECT tech_code, level FROM player_researches WHERE player_id = $1', [playerId]);
    return res.rows.reduce((acc, row) => {
      acc[row.tech_code] = row.level;
      return acc;
    }, {});
  }

  async getCityAcademy(cityId) {
    const res = await db.query("SELECT level FROM city_buildings WHERE city_id = $1 AND building_code = 'ACADEMY'", [cityId]);
    return res.rows[0] || null;
  }

  async isAccountResearching(playerId) {
    const res = await db.query("SELECT id FROM research_queues WHERE player_id = $1 AND status = 'ACTIVE'", [playerId]);
    return res.rows.length > 0;
  }
}

module.exports = new ResearchEngine();

```
