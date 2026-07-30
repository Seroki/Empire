### Comprehensive Unit Reference Volume VI

Here is the complete, canonical troop database for *Evony Age I*, converted directly into structural definitions and implementation specifications for our recreation engine.

---

### 🛡️ **Ground Infantry**

#### 1. **Pikeman**

* **Description:** Long-spear infantry designed specifically to counter mounted cavalry and hold defensive lines.
* **Purpose:** Anti-cavalry meatshield, layer defense, secondary frontline combatant.
* **Stats:**
* **Life:** 300
* **Population Cost:** 1
* **Attack:** 150
* **Defense:** 150
* **Carry Load:** 80
* **Food Upkeep/Hour:** 6
* **Speed (mi/1000 min):** 300 | **Speed (mi/hr):** 18.0
* **Range:** 30 yards


* **Training Prerequisites & Cost:**
* **Required Building:** Barracks Level 3
* **Required Technologies:** Military Science Level 1, Iron Working Level 1
* **Base Training Time:** 75 seconds
* **Resource Cost:** Food: 100 | Lumber: 150 | Stone: 0 | Iron: 50 | Gold: 0


* **Combat & AI Profile:**
* **Role:** `Ground`
* **AI Profile:** `Melee_Frontline`
* **Combat Notes:** Deals $+100\%$ bonus damage against `Cavalry` and `Cataphract` units.



#### 2. **Swordsman**

* **Description:** Heavily armored foot soldier equipped with short swords and heavy steel shields.
* **Purpose:** High-defense frontline wall/tank, archer-protection layer.
* **Stats:**
* **Life:** 350
* **Population Cost:** 1
* **Attack:** 100
* **Defense:** 250
* **Carry Load:** 100
* **Food Upkeep/Hour:** 7
* **Speed (mi/1000 min):** 250 | **Speed (mi/hr):** 15.0
* **Range:** 30 yards


* **Training Prerequisites & Cost:**
* **Required Building:** Barracks Level 4
* **Required Technologies:** Military Science Level 2, Iron Working Level 2
* **Base Training Time:** 100 seconds
* **Resource Cost:** Food: 150 | Lumber: 80 | Stone: 0 | Iron: 100 | Gold: 0


* **Combat & AI Profile:**
* **Role:** `Ground`
* **AI Profile:** `Melee_Frontline`
* **Combat Notes:** Absorbs heavy ranged damage due to base 250 defense. Absorbs hits to keep Archers safe during turn-based range convergence.



---

### 🏹 **Ranged Units**

#### 3. **Archer**

* **Description:** Primary ranged combat unit in *Evony Age I*. Highly versatile and deadly when stacked in massive quantities.
* **Purpose:** Primary damage dealer for NPC farming, city offense, and city defense.
* **Stats:**
* **Life:** 250
* **Population Cost:** 1
* **Attack:** 120
* **Defense:** 100
* **Carry Load:** 250
* **Food Upkeep/Hour:** 9
* **Speed (mi/1000 min):** 250 | **Speed (mi/hr):** 15.0
* **Range:** 1,200 yards


* **Training Prerequisites & Cost:**
* **Required Building:** Barracks Level 5
* **Required Technologies:** Military Science Level 3, Archery Level 2
* **Base Training Time:** 150 seconds
* **Resource Cost:** Food: 300 | Lumber: 350 | Stone: 0 | Iron: 100 | Gold: 0


* **Combat & AI Profile:**
* **Role:** `Ranged`
* **AI Profile:** `Ranged_Backline`
* **Combat Notes:** Range scales by $+5\%$ per level of `Archery`. Attacks enemy units from backlines; subject to dynamic range-checking prior to turn execution.



---

### 🐴 **Mounted Units**

#### 4. **Cavalry**

* **Description:** Light horsemen capable of rapid movement across terrain and fast flank assaults.
* **Purpose:** Fast raiding, anti-archer flanker, rapid response unit.
* **Stats:**
* **Life:** 500
* **Population Cost:** 2
* **Attack:** 250
* **Defense:** 180
* **Carry Load:** 1,000
* **Food Upkeep/Hour:** 18
* **Speed (mi/1000 min):** 1,000 | **Speed (mi/hr):** 60.0
* **Range:** 100 yards


* **Training Prerequisites & Cost:**
* **Required Building:** Barracks Level 7, Stable Level 1
* **Required Technologies:** Horseback Riding Level 3
* **Base Training Time:** 250 seconds
* **Resource Cost:** Food: 1,000 | Lumber: 600 | Stone: 0 | Iron: 300 | Gold: 0


* **Combat & AI Profile:**
* **Role:** `Mounted`
* **AI Profile:** `Fast_Flanker`
* **Combat Notes:** Crosses battlefield gaps quickly due to high movement speed; vulnerable to `Pikeman` counter-attacks.



#### 5. **Cataphract**

* **Description:** Fully armored heavy cavalry capable of tearing through backline layers and fortified defenses.
* **Purpose:** Late-game shock unit ("Phract Smack") used to punch through massive defending armies.
* **Stats:**
* **Life:** 1,000
* **Population Cost:** 3
* **Attack:** 350
* **Defense:** 350
* **Carry Load:** 1,500
* **Food Upkeep/Hour:** 35
* **Speed (mi/1000 min):** 750 | **Speed (mi/hr):** 45.0
* **Range:** 120 yards


* **Training Prerequisites & Cost:**
* **Required Building:** Barracks Level 9, Stable Level 5
* **Required Technologies:** Horseback Riding Level 5, Iron Working Level 6
* **Base Training Time:** 450 seconds
* **Resource Cost:** Food: 2,500 | Lumber: 1,000 | Stone: 0 | Iron: 1,200 | Gold: 0


* **Combat & AI Profile:**
* **Role:** `Mounted`
* **AI Profile:** `Fast_Flanker`
* **Combat Notes:** Highest HP infantry/mounted unit in game; extremely expensive upkeep and iron cost.



---

### 🚚 **Logistics & Transport**

#### 6. **Transporter**

* **Description:** Heavy pack wagon drawn by horses or oxen.
* **Purpose:** Bulk resource transfer between allied cities, plunder collection during attacks.
* **Stats:**
* **Life:** 200
* **Population Cost:** 2
* **Attack:** 10
* **Defense:** 10
* **Carry Load:** 5,000 *(Increases to 10,000 at Logistics Level 10)*
* **Food Upkeep/Hour:** 10
* **Speed (mi/1000 min):** 150 | **Speed (mi/hr):** 9.0
* **Range:** 10 yards


* **Training Prerequisites & Cost:**
* **Required Building:** Barracks Level 6, Workshop Level 1
* **Required Technologies:** Logistics Level 2
* **Base Training Time:** 300 seconds
* **Resource Cost:** Food: 200 | Lumber: 500 | Stone: 0 | Iron: 100 | Gold: 0


* **Combat & AI Profile:**
* **Role:** `Support`
* **AI Profile:** `Worker_Support`
* **Combat Notes:** Zero offensive utility; targeted last by defending AI unless forced into range.



---

### 🧱 **Siege Engines**

#### 7. **Ballista**

* **Description:** Heavy mobile cross-bow engine used for long-range siege operations.
* **Purpose:** Zero-loss NPC farming (Levels 1–5) and long-range structural siege bombardment.
* **Stats:**
* **Life:** 320
* **Population Cost:** 4
* **Attack:** 450
* **Defense:** 160
* **Carry Load:** 450
* **Food Upkeep/Hour:** 50
* **Speed (mi/1000 min):** 100 | **Speed (mi/hr):** 6.0
* **Range:** 1,400 yards


* **Training Prerequisites & Cost:**
* **Required Building:** Barracks Level 8, Workshop Level 2
* **Required Technologies:** Archery Level 6, Metal Casting Level 5
* **Base Training Time:** 500 seconds
* **Resource Cost:** Food: 2,000 | Lumber: 2,500 | Stone: 0 | Iron: 1,000 | Gold: 0


* **Combat & AI Profile:**
* **Role:** `Siege`
* **AI Profile:** `Ranged_Backline`
* **Combat Notes:** Range outdistances Level 1–5 NPC Archer Towers, enabling standard zero-loss farming algorithms.



#### 8. **Battering Ram**

* **Description:** Massive armored ramming chassis operated by ground crews.
* **Purpose:** Wall breach operations, absorbing high volumes of defensive trap/tower fire.
* **Stats:**
* **Life:** 5,000
* **Population Cost:** 10
* **Attack:** 250
* **Defense:** 500
* **Carry Load:** 100
* **Food Upkeep/Hour:** 100
* **Speed (mi/1000 min):** 80 | **Speed (mi/hr):** 4.8
* **Range:** 30 yards


* **Training Prerequisites & Cost:**
* **Required Building:** Barracks Level 9, Workshop Level 5
* **Required Technologies:** Iron Working Level 5, Engineering Level 5
* **Base Training Time:** 1,000 seconds
* **Resource Cost:** Food: 5,000 | Lumber: 10,000 | Stone: 0 | Iron: 2,000 | Gold: 0


* **Combat & AI Profile:**
* **Role:** `Siege`
* **AI Profile:** `Siege_WallBreaker`
* **Combat Notes:** Extremely high HP pool (5,000) allows it to soak defensive wall hits while ground forces advance.



#### 9. **Catapult**

* **Description:** High-powered counterweight siege engine launching stone boulders across massive distances.
* **Purpose:** Ultimate siege engine; outranges Level 10 Wall Archer Towers.
* **Stats:**
* **Life:** 480
* **Population Cost:** 8
* **Attack:** 800
* **Defense:** 200
* **Carry Load:** 250
* **Food Upkeep/Hour:** 250
* **Speed (mi/1000 min):** 80 | **Speed (mi/hr):** 4.8
* **Range:** 1,500 yards


* **Training Prerequisites & Cost:**
* **Required Building:** Barracks Level 10, Workshop Level 10
* **Required Technologies:** Archery Level 10, Metal Casting Level 10
* **Base Training Time:** 1,800 seconds
* **Resource Cost:** Food: 8,000 | Lumber: 10,000 | Stone: 5,000 | Iron: 3,000 | Gold: 0


* **Combat & AI Profile:**
* **Role:** `Siege`
* **AI Profile:** `Siege_WallBreaker`
* **Combat Notes:** Highest standard unit base range (1,500 yards) and base attack power (800).



---

### 💻 **Production Data Registration Script (`unitRegistry.js`)**

```javascript
/**
 * unitRegistry.js
 * Complete Unit Specification Registry for Evony Age I Recreation
 */

const UnitTypes = Object.freeze({
  WORKER: 'Worker',
  WARRIOR: 'Warrior',
  SCOUT: 'Scout',
  PIKEMAN: 'Pikeman',
  SWORDSMAN: 'Swordsman',
  ARCHER: 'Archer',
  CAVALRY: 'Cavalry',
  CATAPHRACT: 'Cataphract',
  TRANSPORTER: 'Transporter',
  BALLISTA: 'Ballista',
  BATTERING_RAM: 'BatteringRam',
  CATAPULT: 'Catapult'
});

const UNIT_DATABASE = {
  [UnitTypes.WORKER]: {
    id: UnitTypes.WORKER,
    life: 100, population_cost: 1, attack: 5, defense: 10, carry_load: 200,
    food_upkeep_per_hour: 2, speed_mi_per_hour: 10.8, range_yards: 10,
    base_training_time_seconds: 50, required_building_level: 1,
    resource_cost: { food: 50, lumber: 0, stone: 0, iron: 0, gold: 0 },
    role: 'Support', ai_profile: 'Worker_Support'
  },
  [UnitTypes.WARRIOR]: {
    id: UnitTypes.WARRIOR,
    life: 200, population_cost: 1, attack: 50, defense: 50, carry_load: 20,
    food_upkeep_per_hour: 3, speed_mi_per_hour: 12.0, range_yards: 20,
    base_training_time_seconds: 24, required_building_level: 1,
    resource_cost: { food: 50, lumber: 30, stone: 0, iron: 0, gold: 0 },
    role: 'Ground', ai_profile: 'Melee_Frontline'
  },
  [UnitTypes.SCOUT]: {
    id: UnitTypes.SCOUT,
    life: 100, population_cost: 1, attack: 20, defense: 20, carry_load: 5,
    food_upkeep_per_hour: 5, speed_mi_per_hour: 180.0, range_yards: 20,
    base_training_time_seconds: 98, required_building_level: 1,
    resource_cost: { food: 50, lumber: 30, stone: 0, iron: 0, gold: 0 },
    role: 'Scout', ai_profile: 'Scout_Intel'
  },
  [UnitTypes.PIKEMAN]: {
    id: UnitTypes.PIKEMAN,
    life: 300, population_cost: 1, attack: 150, defense: 150, carry_load: 80,
    food_upkeep_per_hour: 6, speed_mi_per_hour: 18.0, range_yards: 30,
    base_training_time_seconds: 75, required_building_level: 3,
    resource_cost: { food: 100, lumber: 150, stone: 0, iron: 50, gold: 0 },
    role: 'Ground', ai_profile: 'Melee_Frontline'
  },
  [UnitTypes.SWORDSMAN]: {
    id: UnitTypes.SWORDSMAN,
    life: 350, population_cost: 1, attack: 100, defense: 250, carry_load: 100,
    food_upkeep_per_hour: 7, speed_mi_per_hour: 15.0, range_yards: 30,
    base_training_time_seconds: 100, required_building_level: 4,
    resource_cost: { food: 150, lumber: 80, stone: 0, iron: 100, gold: 0 },
    role: 'Ground', ai_profile: 'Melee_Frontline'
  },
  [UnitTypes.ARCHER]: {
    id: UnitTypes.ARCHER,
    life: 250, population_cost: 1, attack: 120, defense: 100, carry_load: 250,
    food_upkeep_per_hour: 9, speed_mi_per_hour: 15.0, range_yards: 1200,
    base_training_time_seconds: 150, required_building_level: 5,
    resource_cost: { food: 300, lumber: 350, stone: 0, iron: 100, gold: 0 },
    role: 'Ranged', ai_profile: 'Ranged_Backline'
  },
  [UnitTypes.CAVALRY]: {
    id: UnitTypes.CAVALRY,
    life: 500, population_cost: 2, attack: 250, defense: 180, carry_load: 1000,
    food_upkeep_per_hour: 18, speed_mi_per_hour: 60.0, range_yards: 100,
    base_training_time_seconds: 250, required_building_level: 7,
    resource_cost: { food: 1000, lumber: 600, stone: 0, iron: 300, gold: 0 },
    role: 'Mounted', ai_profile: 'Fast_Flanker'
  },
  [UnitTypes.CATAPHRACT]: {
    id: UnitTypes.CATAPHRACT,
    life: 1000, population_cost: 3, attack: 350, defense: 350, carry_load: 1500,
    food_upkeep_per_hour: 35, speed_mi_per_hour: 45.0, range_yards: 120,
    base_training_time_seconds: 450, required_building_level: 9,
    resource_cost: { food: 2500, lumber: 1000, stone: 0, iron: 1200, gold: 0 },
    role: 'Mounted', ai_profile: 'Fast_Flanker'
  },
  [UnitTypes.TRANSPORTER]: {
    id: UnitTypes.TRANSPORTER,
    life: 200, population_cost: 2, attack: 10, defense: 10, carry_load: 5000,
    food_upkeep_per_hour: 10, speed_mi_per_hour: 9.0, range_yards: 10,
    base_training_time_seconds: 300, required_building_level: 6,
    resource_cost: { food: 200, lumber: 500, stone: 0, iron: 100, gold: 0 },
    role: 'Support', ai_profile: 'Worker_Support'
  },
  [UnitTypes.BALLISTA]: {
    id: UnitTypes.BALLISTA,
    life: 320, population_cost: 4, attack: 450, defense: 160, carry_load: 450,
    food_upkeep_per_hour: 50, speed_mi_per_hour: 6.0, range_yards: 1400,
    base_training_time_seconds: 500, required_building_level: 8,
    resource_cost: { food: 2000, lumber: 2500, stone: 0, iron: 1000, gold: 0 },
    role: 'Siege', ai_profile: 'Ranged_Backline'
  },
  [UnitTypes.BATTERING_RAM]: {
    id: UnitTypes.BATTERING_RAM,
    life: 5000, population_cost: 10, attack: 250, defense: 500, carry_load: 100,
    food_upkeep_per_hour: 100, speed_mi_per_hour: 4.8, range_yards: 30,
    base_training_time_seconds: 1000, required_building_level: 9,
    resource_cost: { food: 5000, lumber: 10000, stone: 0, iron: 2000, gold: 0 },
    role: 'Siege', ai_profile: 'Siege_WallBreaker'
  },
  [UnitTypes.CATAPULT]: {
    id: UnitTypes.CATAPULT,
    life: 480, population_cost: 8, attack: 800, defense: 200, carry_load: 250,
    food_upkeep_per_hour: 250, speed_mi_per_hour: 4.8, range_yards: 1500,
    base_training_time_seconds: 1800, required_building_level: 10,
    resource_cost: { food: 8000, lumber: 10000, stone: 5000, iron: 3000, gold: 0 },
    role: 'Siege', ai_profile: 'Siege_WallBreaker'
  }
};

/**
 * Calculates exact training duration for a given batch size
 */
function calculateTrainingTime(unitType, count, militaryScienceLevel, heroAttack) {
  const unit = UNIT_DATABASE[unitType];
  if (!unit) throw new Error(`Unknown unit type: ${unitType}`);

  const perUnitSeconds = unit.base_training_time_seconds 
    * Math.pow(0.9, militaryScienceLevel) 
    * Math.pow(0.995, heroAttack);

  return Math.max(1, Math.floor(perUnitSeconds * count));
}

module.exports = { UnitTypes, UNIT_DATABASE, calculateTrainingTime };

```
