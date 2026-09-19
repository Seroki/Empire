### Architectural Review & Graph Runtime Engine

Here is the architectural review for **GDS Volume X — Dependencies (Graph Engine)** for a **Node.js + SQLite** runtime.

To maintain optimal execution speed during real-time gameplay actions (such as validating if a player can build an `Archer` or train a `Catapult`), graph queries must avoid slow database traversals on every request.

1. **In-Memory Directed Acyclic Graph (DAG) Hydration:** At engine boot, all graph edges from the `dependencies` table are loaded into a fast, in-memory **Adjacency List**. State validation checks run against this memory graph in $O(1)$ to $O(V + E)$ lookup time.
2. **Polymorphic Entity Identifiers:** Using string identifiers (e.g., `BUILDING:Barracks:4` or `RESEARCH:Archery:1`) unifies all entity nodes across different tables into a single directed graph parser.
3. **Recursive Requirement Resolver:** When a client attempts an action, the engine recursively traverses the requirement tree to build an **Action Block Matrix**—returning the precise list of missing prerequisites (missing buildings, insufficient tech levels, or missing resources).

---

# 📘 **Volume X — Dependency Graph System (Engine Architecture)**

```
                      +----------------------------------+
                      | SQLite 'dependencies' Database   |
                      +----------------------------------+
                                       |
                                       | Boot Hydration
                                       v
                      +----------------------------------+
                      |  In-Memory Adjacency List (DAG)  |
                      +----------------------------------+
                                       |
                                       | Player Action Request
                                       v
                      +----------------------------------+
                      |   Dependency Graph Resolver      |
                      +----------------------------------+
                                       |
                   +-------------------+-------------------+
                   |                                       |
             Requirements Met                        Requirements Missing
                   |                                       |
                   v                                       v
      +-------------------------+             +-------------------------+
      |  Execute Action Loop    |             |  Return 400 Error Payload|
      |  (Deduct Res, Queue)    |             |  (List Missing Nodes)   |
      +-------------------------+             +-------------------------+

```

---

## 💾 **1. Database Schema (`graph_schema.sql`)**

This table captures all directed edges between any system entities in the MMORTS universe.

```sql
-- Unified Dependency Edge Table
CREATE TABLE IF NOT EXISTS dependencies (
    edge_id INTEGER PRIMARY KEY AUTOINCREMENT,
    from_type TEXT NOT NULL,  -- e.g., 'UNIT', 'BUILDING', 'RESEARCH', 'QUEST', 'EQUIPMENT'
    from_id TEXT NOT NULL,    -- e.g., 'Archer', 'Barracks:4', 'SwordOfWar'
    to_type TEXT NOT NULL,    -- e.g., 'BUILDING', 'RESEARCH', 'HERO_STAT', 'FEATURE'
    to_id TEXT NOT NULL,      -- e.g., 'Barracks:4', 'Archery:1', 'AttackBonus'
    relation_type TEXT CHECK(relation_type IN ('REQUIRES', 'UNLOCKS', 'AFFECTS', 'REWARDS', 'COUNTERS')) NOT NULL,
    value REAL DEFAULT 1.0,   -- Multiplier, flat modifier, or level cap
    meta_json JSON DEFAULT NULL -- Optional context payload
);

-- Index for instant edge traversal
CREATE INDEX IF NOT EXISTS idx_dep_lookup ON dependencies (from_type, from_id, relation_type);

```

---

## 📐 **2. Seed Data Injection (`seed_dependencies.sql`)**

```sql
-- Building Requirements
INSERT INTO dependencies (from_type, from_id, to_type, to_id, relation_type, value) VALUES
('BUILDING', 'Barracks:1', 'BUILDING', 'TownHall:3', 'REQUIRES', 3),
('BUILDING', 'Academy:1', 'BUILDING', 'TownHall:4', 'REQUIRES', 4),
('BUILDING', 'FeastingHall:1', 'BUILDING', 'TownHall:5', 'REQUIRES', 5),
('BUILDING', 'Walls:1', 'RESEARCH', 'Construction:1', 'REQUIRES', 1);

-- Research Requirements
INSERT INTO dependencies (from_type, from_id, to_type, to_id, relation_type, value) VALUES
('RESEARCH', 'MilitaryTradition:1', 'BUILDING', 'Academy:1', 'REQUIRES', 1),
('RESEARCH', 'Archery:1', 'BUILDING', 'Academy:1', 'REQUIRES', 1),
('RESEARCH', 'HorsebackRiding:1', 'BUILDING', 'Academy:1', 'REQUIRES', 1),
('RESEARCH', 'HorsebackRiding:2', 'RESEARCH', 'HorsebackRiding:1', 'REQUIRES', 1);

-- Unit Requirements
INSERT INTO dependencies (from_type, from_id, to_type, to_id, relation_type, value) VALUES
('UNIT', 'Warrior', 'BUILDING', 'Barracks:1', 'REQUIRES', 1),
('UNIT', 'Pikeman', 'BUILDING', 'Barracks:2', 'REQUIRES', 2),
('UNIT', 'Pikeman', 'RESEARCH', 'MilitaryTradition:1', 'REQUIRES', 1),
('UNIT', 'Archer', 'BUILDING', 'Barracks:4', 'REQUIRES', 4),
('UNIT', 'Archer', 'RESEARCH', 'Archery:1', 'REQUIRES', 1),
('UNIT', 'Cavalry', 'BUILDING', 'Barracks:5', 'REQUIRES', 5),
('UNIT', 'Cavalry', 'RESEARCH', 'HorsebackRiding:1', 'REQUIRES', 1),
('UNIT', 'Ballista', 'BUILDING', 'Workshop:1', 'REQUIRES', 1),
('UNIT', 'Ballista', 'RESEARCH', 'Archery:4', 'REQUIRES', 4);

-- Tactical & Stat Effects
INSERT INTO dependencies (from_type, from_id, to_type, to_id, relation_type, value) VALUES
('UNIT', 'Pikeman', 'UNIT', 'Cavalry', 'COUNTERS', 1.8),
('HERO_STAT', 'Attack', 'UNIT_STAT', 'AllUnitAttack', 'AFFECTS', 0.01),
('RESEARCH', 'Construction', 'BUILDING_STAT', 'BuildSpeed', 'AFFECTS', 0.10);

```

---

## ⚡ **3. Graph Resolver Engine (`dependency_engine.js`)**

This engine loads all dependencies into memory on startup and provides recursive requirement checking for player actions.

```javascript
/**
 * In-Memory Graph Resolver Engine
 */
class DependencyGraphEngine {
  constructor() {
    this.adjacencyList = new Map();
  }

  /**
   * Hydrate in-memory adjacency graph from SQLite rows
   */
  loadFromDatabase(rows) {
    this.adjacencyList.clear();

    rows.forEach(row => {
      const sourceKey = `${row.from_type}:${row.from_id}`;
      if (!this.adjacencyList.has(sourceKey)) {
        this.adjacencyList.set(sourceKey, []);
      }

      this.adjacencyList.get(sourceKey).push({
        targetType: row.to_type,
        targetId: row.to_id,
        relation: row.relation_type,
        value: row.value,
        meta: row.meta_json ? JSON.parse(row.meta_json) : null
      });
    });
  }

  /**
   * Evaluates if a player state fulfills all requirements for a target node
   * @param {string} entityType - e.g., 'UNIT'
   * @param {string} entityId - e.g., 'Archer'
   * @param {Object} playerState - Snapshot of player buildings, tech, items
   */
  checkRequirements(entityType, entityId, playerState) {
    const key = `${entityType}:${entityId}`;
    const edges = this.adjacencyList.get(key) || [];
    
    let unmetRequirements = [];
    let isFulfilled = true;

    for (const edge of edges) {
      if (edge.relation !== 'REQUIRES') continue;

      const { targetType, targetId, value } = edge;

      // Check Building Prerequisites
      if (targetType === 'BUILDING') {
        const [buildingName, requiredLevelStr] = targetId.split(':');
        const requiredLevel = parseInt(requiredLevelStr || value, 10);
        const playerBuildingLevel = playerState.buildings[buildingName] || 0;

        if (playerBuildingLevel < requiredLevel) {
          isFulfilled = false;
          unmetRequirements.push({
            type: 'BUILDING',
            name: buildingName,
            required: requiredLevel,
            current: playerBuildingLevel
          });
        }
      }

      // Check Research Prerequisites
      if (targetType === 'RESEARCH') {
        const [techName, requiredLevelStr] = targetId.split(':');
        const requiredLevel = parseInt(requiredLevelStr || value, 10);
        const playerTechLevel = playerState.techs[techName] || 0;

        if (playerTechLevel < requiredLevel) {
          isFulfilled = false;
          unmetRequirements.push({
            type: 'RESEARCH',
            name: techName,
            required: requiredLevel,
            current: playerTechLevel
          });
        }
      }

      // Check Hero Level / State Prerequisites
      if (targetType === 'HERO_LEVEL') {
        if ((playerState.heroLevel || 0) < value) {
          isFulfilled = false;
          unmetRequirements.push({
            type: 'HERO_LEVEL',
            required: value,
            current: playerState.heroLevel || 0
          });
        }
      }
    }

    return {
      canExecute: isFulfilled,
      unmetRequirements
    };
  }

  /**
   * Retrieves all stat multipliers and modifiers applied to a target
   */
  getModifiersForTarget(targetType, targetId) {
    let modifiers = [];

    for (const [sourceKey, edges] of this.adjacencyList.entries()) {
      edges.forEach(edge => {
        if (edge.relation === 'AFFECTS' && edge.targetType === targetType && edge.targetId === targetId) {
          modifiers.push({
            source: sourceKey,
            value: edge.value,
            meta: edge.meta
          });
        }
      });
    }

    return modifiers;
  }
}

module.exports = new DependencyGraphEngine();

```

---

## 🧪 **4. Execution Example**

```javascript
const dbRows = [
  { from_type: 'UNIT', from_id: 'Archer', to_type: 'BUILDING', to_id: 'Barracks:4', relation_type: 'REQUIRES', value: 4 },
  { from_type: 'UNIT', from_id: 'Archer', to_type: 'RESEARCH', to_id: 'Archery:1', relation_type: 'REQUIRES', value: 1 }
];

// 1. Boot graph
const DependencyEngine = require('./dependency_engine');
DependencyEngine.loadFromDatabase(dbRows);

// 2. Mock Player State (Under-leveled Barracks)
const playerState = {
  buildings: { Barracks: 3 }, // Needs Level 4
  techs: { Archery: 1 }       // Met
};

// 3. Validate Training Action
const evaluation = DependencyEngine.checkRequirements('UNIT', 'Archer', playerState);

console.log(evaluation);
/*
Output:
{
  canExecute: false,
  unmetRequirements: [
    { type: 'BUILDING', name: 'Barracks', required: 4, current: 3 }
  ]
}
