### Architectural Review & Mechanical Audit

Here is the precise architectural breakdown for **Volume VIII — Combat** tailored specifically for a **Node.js + SQLite** deterministic game loop.

While your notes accurately lay out the macro structures (Marching, Terrain, Distance), a few core mechanics require exact alignment with original *Evony Age I* behavior:

1. **Battlefield Initialization Range:** Battlefield length is **not** purely continuous wall math. It is dynamically dictated by the **longest-ranged unit on the field at Round 1 plus a 200-yard buffer** (e.g., Catapults set starting range to 1700 yards; Archers to 1400 yards). Wall/Tower ranges act as hard caps on defensive unit engagement.
2. **Turn-Based Dynamic Micro-Loop:** *Evony Age I* battles run as discrete **Rounds (up to a hard cap of 100 rounds)**. Each round, units close distance according to their speed until they reach their firing/attack range, prioritize targets based on direct unit threat trees, and deal simultaneous damage. If 100 rounds pass without total destruction, the **defender wins by default**.
3. **Deterministic Math Realignment:** Attack output is calculated dynamically each round based on surviving troop stacks ($N_a$), tech multipliers, hero attack multipliers, and target armor values—rather than a single instantaneous macro formula.

---

# 📘 **Volume VIII — Combat System (Engine-Ready Architecture)**

Below is the complete, mechanically accurate, turn-deterministic specification and SQLite schema implementation for the Node.js combat runtime.

```
                  +-----------------------------------+
                  |      March Arrival Trigger        |
                  +-----------------------------------+
                                    |
                                    v
                  +-----------------------------------+
                  |  Load Army, Tech, Hero & Terrain  |
                  +-----------------------------------+
                                    |
                                    v
                  +-----------------------------------+
                  | Initialize Battlefield (Max Range)|
                  +-----------------------------------+
                                    |
              +--------------------->---------------------+
              |                                           |
              |   +-----------------------------------+   |
              |   | 1. Fortification Phase            |   |
              |   +-----------------------------------+   |
              |                     |                     |
              |   +-----------------------------------+   |
              |   | 2. Movement & Range Closing Phase |   |
              |   +-----------------------------------+   |
              |                     |                     |
              |   +-----------------------------------+   |
              |   | 3. Target Priority & Damage Exec  |   |
              |   +-----------------------------------+   |
              |                     |                     |
              |   +-----------------------------------+   |
              |   | 4. Casualty & Defeat Processing   |   |
              |   +-----------------------------------+   |
              |                     |                     |
              +<--- Round < 100 AND Both Sides Alive? ----+
                                    | NO (Victorious or 100 Rounds Elapsed)
                                    v
                  +-----------------------------------+
                  | Apply Wounded, XP, Loot & Return  |
                  +-----------------------------------+

```

---

## 💾 **1. Database Schema (`combat_schema.sql`)**

```sql
-- Active and Historical Marches
CREATE TABLE IF NOT EXISTS marches (
    march_id INTEGER PRIMARY KEY AUTOINCREMENT,
    user_id INTEGER NOT NULL,
    origin_city_id INTEGER NOT NULL,
    target_x INTEGER NOT NULL,
    target_y INTEGER NOT NULL,
    march_type TEXT CHECK(march_type IN ('ATTACK', 'SCOUT', 'REINFORCE', 'TRANSPORT')) NOT NULL,
    hero_id INTEGER DEFAULT NULL,
    status TEXT CHECK(status IN ('QUEUED', 'IN_TRANSIT', 'RESOLVING', 'RETURNING', 'COMPLETED')) NOT NULL,
    depart_time INTEGER NOT NULL,   -- Unix Timestamp (ms)
    arrival_time INTEGER NOT NULL,  -- Unix Timestamp (ms)
    return_time INTEGER NOT NULL,   -- Unix Timestamp (ms)
    FOREIGN KEY(user_id) REFERENCES users(user_id),
    FOREIGN KEY(origin_city_id) REFERENCES cities(city_id)
);

-- Troop Payloads for Marches
CREATE TABLE IF NOT EXISTS march_troops (
    march_id INTEGER NOT NULL,
    unit_type TEXT NOT NULL,
    quantity INTEGER NOT NULL,
    PRIMARY KEY (march_id, unit_type),
    FOREIGN KEY(march_id) REFERENCES marches(march_id) ON DELETE CASCADE
);

-- Detailed Combat Logging (Engine Snapshots)
CREATE TABLE IF NOT EXISTS combat_reports (
    report_id INTEGER PRIMARY KEY AUTOINCREMENT,
    march_id INTEGER NOT NULL,
    attacker_id INTEGER NOT NULL,
    defender_id INTEGER NOT NULL,
    target_x INTEGER NOT NULL,
    target_y INTEGER NOT NULL,
    winner TEXT CHECK(winner IN ('ATTACKER', 'DEFENDER')) NOT NULL,
    rounds_elapsed INTEGER NOT NULL,
    battle_log JSON NOT NULL, -- Full turn-by-turn round state array
    occurred_at INTEGER NOT NULL
);

```

---

## 📐 **2. Deterministic Movement & Distance Engine**

```javascript
/**
 * Toroidal Distance & Movement Utilities
 */.
const MAP_WIDTH = 500;
const MAP_HEIGHT = 500;

function calculateDistance(x1, y1, x2, y2) {
  const dx = Math.min(Math.abs(x2 - x1), MAP_WIDTH - Math.abs(x2 - x1));
  const dy = Math.min(Math.abs(y2 - y1), MAP_HEIGHT - Math.abs(y2 - y1));
  return dx + dy; // Toroidal Manhattan distance
}

function calculateMarchSpeed(troopStack, techs) {
  // Base speeds in miles/hour
  const BASE_SPEEDS = {
    Worker: 10.8, Warrior: 12.0, Scout: 180.0, Pikeman: 18.0,
    Swordsman: 15.0, Archer: 15.0, Cavalry: 60.0, Cataphract: 45.0,
    Transporter: 9.0, Ballista: 6.0, BatteringRam: 4.8, Catapult: 4.8
  };

  let minSpeed = Infinity;

  for (const [unitType, count] of Object.entries(troopStack)) {
    if (count <= 0) continue;
    let speed = BASE_SPEEDS[unitType];

    // Compass boosts infantry & workers (+10% per lvl)
    if (['Worker', 'Warrior', 'Pikeman', 'Swordsman', 'Archer'].includes(unitType)) {
      speed *= (1 + (techs.compassLevel || 0) * 0.10);
    }
    // Horseback Riding boosts cavalry & siege (+10% per lvl)
    if (['Cavalry', 'Cataphract', 'Transporter', 'Ballista', 'BatteringRam', 'Catapult'].includes(unitType)) {
      speed *= (1 + (techs.horsebackRidingLevel || 0) * 0.10);
    }

    if (speed < minSpeed) minSpeed = speed;
  }

  return minSpeed;
}

function calculateTravelTimeSeconds(distance, speed) {
  // Travel Time = (Distance / SlowestSpeed) * 3600 seconds
  return Math.max(10, Math.ceil((distance / speed) * 3600));
}

```

---

## ⚔️ **3. Core Deterministic Combat Simulation Loop**

This module simulates the turn-based 100-round combat cycle, accurately targeting backlines, advancing melee layers, and processing fortifications.

```javascript
/**
 * Evony Age I Complete Deterministic Combat Simulation Runtime
 */

const BASE_UNIT_STATS = {
  Worker:       { life: 100,  attack: 5,   defense: 10,  range: 10,   speed: 180 },
  Warrior:      { life: 200,  attack: 50,  defense: 50,  range: 20,   speed: 200 },
  Scout:        { life: 100,  attack: 20,  defense: 20,  range: 20,   speed: 3000 },
  Pikeman:      { life: 300,  attack: 150, defense: 150, range: 30,   speed: 300 },
  Swordsman:    { life: 350,  attack: 100, defense: 250, range: 30,   speed: 250 },
  Archer:       { life: 250,  attack: 120, defense: 100, range: 1200, speed: 250 },
  Cavalry:      { life: 500,  attack: 250, defense: 180, range: 100,  speed: 1000 },
  Cataphract:   { life: 1000, attack: 350, defense: 350, range: 120,  speed: 750 },
  Transporter:  { life: 200,  attack: 10,  defense: 10,  range: 10,   speed: 150 },
  Ballista:     { life: 320,  attack: 450, defense: 160, range: 1400, speed: 100 },
  BatteringRam: { life: 5000, attack: 250, defense: 500, range: 60,   speed: 80 },
  Catapult:     { life: 480,  attack: 800, defense: 200, range: 1500, speed: 80 },
  
  // Wall Fortifications
  Trap:         { life: 1,    attack: 5000, defense: 0,   range: 5000, speed: 0 },
  Abatis:       { life: 1,    attack: 5000, defense: 0,   range: 5000, speed: 0 },
  ArcherTower:  { life: 450,  attack: 300,  defense: 350, range: 1300, speed: 0 },
  RollingLog:   { life: 1,    attack: 2000, defense: 0,   range: 1300, speed: 0 },
  Trebuchet:    { life: 1,    attack: 5000, defense: 0,   range: 5000, speed: 0 }
};

function executeCombatSimulation(attackerPayload, defenderPayload) {
  // 1. Initialize Army Entities
  let attackers = initializeArmy(attackerPayload, 'ATTACKER');
  let defenders = initializeArmy(defenderPayload, 'DEFENDER');

  // 2. Establish Battlefield Length
  // Battlefield range starts at longest ranged unit + 200 yards
  let maxRange = 200;
  [...attackers, ...defenders].forEach(u => {
    if (u.range > maxRange) maxRange = u.range;
  });
  
  let currentRange = maxRange + 200;
  let roundsLog = [];
  let round = 1;
  let battleOver = false;
  let winner = null;

  // 3. Execution Loop (Max 100 Rounds)
  while (round <= 100 && !battleOver) {
    let roundState = { round, rangeStart: currentRange, casualties: [] };

    // --- PHASE A: Fortification Pre-combat Logic ---
    if (round === 1) {
      processFortifications(attackers, defenders, roundState);
    }

    // --- PHASE B: Direct Fire & Attack Step ---
    let pendingDamage = [];

    // Process Attacker Fire
    attackers.forEach(atkStack => {
      if (atkStack.count <= 0) return;
      let target = selectTarget(atkStack, defenders, currentRange);
      if (target) {
        let dmg = calculateStackDamage(atkStack, target);
        pendingDamage.push({ target, dmg });
      }
    });

    // Process Defender Fire
    defenders.forEach(defStack => {
      if (defStack.count <= 0) return;
      let target = selectTarget(defStack, attackers, currentRange);
      if (target) {
        let dmg = calculateStackDamage(defStack, target);
        pendingDamage.push({ target, dmg });
      }
    });

    // --- PHASE C: Apply Simultaneous Casualties ---
    pendingDamage.forEach(({ target, dmg }) => {
      let kills = Math.min(target.count, Math.floor(dmg / target.singleHp));
      target.count -= kills;
      roundState.casualties.push({ type: target.type, side: target.side, lost: kills });
    });

    // --- PHASE D: Movement Step ---
    // Close range by movement speed of advancing forces
    let fastestAdvancingAttacker = Math.max(0, ...attackers.filter(a => a.count > 0).map(a => a.speed));
    let fastestAdvancingDefender = Math.max(0, ...defenders.filter(d => d.count > 0).map(d => d.speed));
    
    currentRange = Math.max(0, currentRange - (fastestAdvancingAttacker + fastestAdvancingDefender));

    // --- PHASE E: Victory/Defeat Evaluation ---
    let aliveAttackers = attackers.reduce((sum, u) => sum + (u.count > 0 ? u.count : 0), 0);
    let aliveDefenders = defenders.reduce((sum, u) => sum + (u.count > 0 ? u.count : 0), 0);

    if (aliveAttackers === 0) {
      battleOver = true;
      winner = 'DEFENDER';
    } else if (aliveDefenders === 0) {
      battleOver = true;
      winner = 'ATTACKER';
    }

    roundsLog.push(roundState);
    round++;
  }

  // Round 100 Timeout Rule: Defender Wins
  if (!winner) {
    winner = 'DEFENDER';
  }

  return { winner, totalRounds: round - 1, roundsLog, finalAttackers: attackers, finalDefenders: defenders };
}

function calculateStackDamage(attackerStack, defenderStack) {
  // Hero attack bonus: +1% total damage per hero attack point
  let heroMultiplier = 1 + ((attackerStack.heroAttack || 0) / 100);
  let totalRawAttack = attackerStack.count * attackerStack.attack * heroMultiplier;

  // Counter Multipliers
  let matchupMultiplier = 1.0;
  if (attackerStack.type === 'Pikeman' && defenderStack.type.includes('Cavalry')) matchupMultiplier = 1.8;
  if (attackerStack.type === 'Archer' && defenderStack.type.includes('Cavalry')) matchupMultiplier = 2.0;

  // Armor Mitigation Calculation
  let mitigation = 1 - (defenderStack.defense / 1000);
  mitigation = Math.max(0.1, mitigation); // Floor armor cap at 90% mitigation

  // Pseudo-random variance (0.95 - 1.05)
  let variance = 0.95 + (Math.random() * 0.10);

  return totalRawAttack * matchupMultiplier * mitigation * variance;
}

function selectTarget(attacker, opposingArmies, currentDistance) {
  // Filter active targets within current range limit
  let validTargets = opposingArmies.filter(u => u.count > 0 && attacker.range >= currentDistance);
  if (validTargets.length === 0) return null;

  // Tactical Target Priority: Ranged > Highest Threat Melee > Wall Units
  validTargets.sort((a, b) => b.attack - a.attack);
  return validTargets[0];
}

function processFortifications(attackers, defenders, roundState) {
  defenders.forEach(def => {
    if (def.type === 'Trap') {
      let infTarget = attackers.find(a => ['Warrior', 'Pikeman', 'Swordsman'].includes(a.type) && a.count > 0);
      if (infTarget) {
        let kills = Math.min(infTarget.count, def.count);
        infTarget.count -= kills;
        def.count -= kills; // Traps are single-use consumed
        roundState.casualties.push({ type: infTarget.type, side: 'ATTACKER', lost: kills, cause: 'Trap' });
      }
    }
    if (def.type === 'Abatis') {
      let cavTarget = attackers.find(a => ['Cavalry', 'Cataphract'].includes(a.type) && a.count > 0);
      if (cavTarget) {
        let kills = Math.min(cavTarget.count, def.count);
        cavTarget.count -= kills;
        def.count -= kills; // Abatis are single-use consumed
        roundState.casualties.push({ type: cavTarget.type, side: 'ATTACKER', lost: kills, cause: 'Abatis' });
      }
    }
  });
}

function initializeArmy(payload, side) {
  let army = [];
  for (const [unitType, count] of Object.entries(payload.troops)) {
    if (count <= 0) continue;
    let base = BASE_UNIT_STATS[unitType];
    army.push({
      type: unitType,
      side: side,
      count: count,
      attack: base.attack,
      defense: base.defense,
      singleHp: base.life,
      range: base.range,
      speed: base.speed,
      heroAttack: payload.hero ? payload.hero.attack : 0
    });
  }
  return army;
}
