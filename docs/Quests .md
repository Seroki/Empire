Volume XI Quests 

Architectural Overview

Here is the complete GDS Volume XI — Quest & Progression Engine specification for a Node.js + SQLite deterministic runtime.

In classic MMORTS engines like Evony Age I, quests act as the primary operational tutorial—teaching UI navigation, building dependency trees, hero management, tax mechanics, and army scaling. Rather than hard-coding quest completion checks into UI endpoints, the quest engine operates as an Event-Driven Observer Pattern: game actions (building upgrades, research completions, tax changes, combat victories) emit events that evaluate active user quest requirements asynchronously.

                       +-----------------------------------+
                       |    Game Action / Client Event     |
                       |  (e.g., BUILD, TAX_SET, RECRUIT)  |
                       +-----------------------------------+
                                         |
                                         v
                       +-----------------------------------+
                       |    Quest Observer Event Bus       |
                       +-----------------------------------+
                                         |
                                         v
                       +-----------------------------------+
                       | Fetch Player's Active Quests (DB) |
                       +-----------------------------------+
                                         |
                                         v
                       +-----------------------------------+
                       | Match Action against Objective    |
                       |  (Type, Target Entity, Condition) |
                       +-----------------------------------+
                                         |
                       +-----------------+-----------------+
                       |                                   |
              Objective Satisfied                 Not Met / In Progress
                       |                                   |
                       v                                   v
        +----------------------------+           +-------------------+
        | Update quest_progress      |           |  No State Change  |
        | Check if Quest Complete    |           +-------------------+
        +----------------------------+
                       |
                       v
        +----------------------------+
        | Mark 'CLAIMABLE' & Notify  |
        | Client (Badge Indicator)   |
        +----------------------------+

💾 1. Quest Engine Database Schema (quest_schema.sql)

This normalized relational model stores static quest definitions, granular objective steps, prerequisites, reward payloads, and player progress state.
SQL

-- 1. Static Quest Catalog
CREATE TABLE IF NOT EXISTS quest_definitions (
    quest_id TEXT PRIMARY KEY,
    chain_id TEXT NOT NULL,
    sequence_index INTEGER NOT NULL,
    category TEXT CHECK(category IN ('tutorial', 'progression', 'system', 'daily')) NOT NULL,
    title TEXT NOT NULL,
    description TEXT NOT NULL,
    rewards_json JSON NOT NULL, -- { "resources": {...}, "items": {...}, "prestige": 100 }
    unlocks_json JSON DEFAULT NULL -- ["TUT_020_BUILD_INN", "FEATURE_HEROES"]
);

-- 2. Quest Prerequisites
CREATE TABLE IF NOT EXISTS quest_prerequisites (
    prereq_id INTEGER PRIMARY KEY AUTOINCREMENT,
    quest_id TEXT NOT NULL,
    dep_type TEXT CHECK(dep_type IN ('building', 'research', 'quest', 'town_hall', 'title')) NOT NULL,
    dep_target TEXT NOT NULL, -- e.g. 'TownHall', 'TUT_010', 'Baron'
    required_value INTEGER NOT NULL,
    FOREIGN KEY(quest_id) REFERENCES quest_definitions(quest_id) ON DELETE CASCADE
);

-- 3. Granular Objectives per Quest
CREATE TABLE IF NOT EXISTS quest_objectives (
    objective_id INTEGER PRIMARY KEY AUTOINCREMENT,
    quest_id TEXT NOT NULL,
    action_type TEXT CHECK(action_type IN (
        'build', 'upgrade', 'research', 'train', 'set_value', 
        'use_item', 'rename', 'change_flag', 'levy', 'comfort', 'spin_wheel'
    )) NOT NULL,
    target_entity TEXT NOT NULL, -- e.g., 'Cottage', 'TaxRate', 'Worker'
    target_count INTEGER DEFAULT 1,
    FOREIGN KEY(quest_id) REFERENCES quest_definitions(quest_id) ON DELETE CASCADE
);

-- 4. User Active / Completed Quest Progression State
CREATE TABLE IF NOT EXISTS user_quest_progress (
    user_id INTEGER NOT NULL,
    quest_id TEXT NOT NULL,
    status TEXT CHECK(status IN ('LOCKED', 'IN_PROGRESS', 'CLAIMABLE', 'COMPLETED')) DEFAULT 'LOCKED',
    current_count INTEGER DEFAULT 0,
    updated_at INTEGER NOT NULL,
    PRIMARY KEY (user_id, quest_id),
    FOREIGN KEY(quest_id) REFERENCES quest_definitions(quest_id)
);

⚙️ 2. Core Quest Runtime Engine (quest_engine.js)

This Node.js module processes incoming game actions, compares them against player progress, updates status flags, and awards resources/prestige upon client claim.
JavaScript

/**
 * Evony Age I Event-Driven Quest Engine
 */
class QuestEngine {
  constructor(db) {
    this.db = db;
  }

  /**
   * Universal Observer Hook called on any player activity
   */
  async notifyAction(userId, actionType, targetEntity, count = 1, absoluteValue = null) {
    // 1. Fetch active quests for user listening to this action type
    const activeQuests = await this.db.all(`
      SELECT q.quest_id, o.objective_id, o.target_count, u.current_count
      FROM user_quest_progress u
      JOIN quest_definitions q ON u.quest_id = q.quest_id
      JOIN quest_objectives o ON q.quest_id = o.quest_id
      WHERE u.user_id = ? AND u.status = 'IN_PROGRESS'
        AND o.action_type = ? AND o.target_entity = ?
    `, [userId, actionType, targetEntity]);

    for (const quest of activeQuests) {
      let newCount = absoluteValue !== null ? absoluteValue : quest.current_count + count;
      let isComplete = newCount >= quest.target_count;

      if (isComplete) {
        await this.db.run(`
          UPDATE user_quest_progress 
          SET status = 'CLAIMABLE', current_count = ?, updated_at = ?
          WHERE user_id = ? AND quest_id = ?
        `, [quest.target_count, Date.now(), userId, quest.quest_id]);
      } else {
        await this.db.run(`
          UPDATE user_quest_progress 
          SET current_count = ?, updated_at = ?
          WHERE user_id = ? AND quest_id = ?
        `, [newCount, Date.now(), userId, quest.quest_id]);
      }
    }
  }

  /**
   * Claim Quest Reward Endpoint
   */
  async claimReward(userId, questId) {
    const quest = await this.db.get(`
      SELECT q.*, u.status 
      FROM user_quest_progress u
      JOIN quest_definitions q ON u.quest_id = q.quest_id
      WHERE u.user_id = ? AND u.quest_id = ?
    `, [userId, questId]);

    if (!quest || quest.status !== 'CLAIMABLE') {
      throw new Error("Quest reward cannot be claimed.");
    }

    const rewards = JSON.parse(quest.rewards_json);
    const unlocks = quest.unlocks_json ? JSON.parse(quest.unlocks_json) : [];

    // Grant Resources, Items, and Prestige
    await this.applyRewards(userId, rewards);

    // Mark as COMPLETED
    await this.db.run(`
      UPDATE user_quest_progress 
      SET status = 'COMPLETED', updated_at = ?
      WHERE user_id = ? AND quest_id = ?
    `, [Date.now(), userId, questId]);

    // Unlock dependent downstream quests
    await this.evaluateUnlocks(userId, questId, unlocks);

    return { success: true, rewards, unlockedQuestIds: unlocks };
  }

  async applyRewards(userId, rewards) {
    if (rewards.resources) {
      await this.db.run(`
        UPDATE city_resources 
        SET food = food + ?, lumber = lumber + ?, stone = stone + ?, iron = iron + ?, gold = gold + ?
        WHERE city_id = (SELECT city_id FROM cities WHERE user_id = ? LIMIT 1)
      `, [
        rewards.resources.food || 0,
        rewards.resources.lumber || 0,
        rewards.resources.stone || 0,
        rewards.resources.iron || 0,
        rewards.resources.gold || 0,
        userId
      ]);
    }
    if (rewards.prestige) {
      await this.db.run(`UPDATE users SET prestige = prestige + ? WHERE user_id = ?`, [rewards.prestige, userId]);
    }
  }

  async evaluateUnlocks(userId, completedQuestId, unlocks) {
    for (const nextQuestId of unlocks) {
      // Check if all prerequisites for nextQuestId are fulfilled
      const unfulfilled = await this.db.get(`
        SELECT COUNT(*) as count FROM quest_prerequisites p
        LEFT JOIN user_quest_progress u ON p.dep_target = u.quest_id AND u.user_id = ? AND u.status = 'COMPLETED'
        WHERE p.quest_id = ? AND p.dep_type = 'quest' AND u.quest_id IS NULL
      `, [userId, nextQuestId]);

      if (unfulfilled.count === 0) {
        await this.db.run(`
          INSERT INTO user_quest_progress (user_id, quest_id, status, current_count, updated_at)
          VALUES (?, ?, 'IN_PROGRESS', 0, ?)
          ON CONFLICT(user_id, quest_id) DO UPDATE SET status = 'IN_PROGRESS'
        `, [userId, nextQuestId, Date.now()]);
      }
    }
  }
}

🏰 3. Town Hall Progression Mapping (TH 1 to 10)

Town Hall upgrades act as system progression gates. The matrix below defines how quests guide the player through each Town Hall tier, matching the classic Evony Age I flow alongside modern MMORTS unlock nodes (e.g., Rise of Kingdoms, Age of Z).
Town Hall Level	Unlocked Buildings & Systems	Hero & Valley Caps	Quest Focus & Teaching Mechanics
TH Level 1	Cottage, Farm, Sawmill, Quarry, Ironmine, Rally Spot	

Max Valleys: 1

Hero Cap: 1
	Beginner Guidelines: UI controls, building resource fields, adjusting production sliders to 100%, and setting initial taxes.
TH Level 2	Barracks, Embassy, Market, Inn	

Max Valleys: 2

Hero Cap: 2
	Army & Commerce: Constructing Barracks, recruiting Workers/Warriors, trading on Market, recruiting first Inn hero.
TH Level 3	Academy, Feasting Hall, Forge	

Max Valleys: 3

Hero Cap: 3
	Governance & Research: Appointing Mayor to Feasting Hall, starting Agriculture/Lumbering research, Levy/Comfort actions.
TH Level 4	Warehouse, Workshop, Beacon Tower	

Max Valleys: 4

Hero Cap: 4
	Protection Threshold: Maxing early resource caps, Archery tech, scouting valleys. (Note: Player retains Beginner Protection).
TH Level 5	Walls, Archer Towers, Traps	

Max Valleys: 5

Hero Cap: 5
	Beginner Protection Drops: Wall fortifications, training Archers, expanding to first 2nd city slot (Knight rank).
TH Level 6	Advanced Techs (Horseback Riding, Compass)	

Max Valleys: 6

Hero Cap: 6
	Mid-game Mobility: Training Cavalry/Transporters, scouting level 4–5 Valleys.
TH Level 7	Siege Works (Ballistae, Battering Rams)	

Max Valleys: 7

Hero Cap: 7
	Mechanized Warfare: Advanced research (Metal Casting, Construction), building siege engines for NPC farming.
TH Level 8	High-tier Fortifications (Trebuchets, Logs)	

Max Valleys: 8

Hero Cap: 8
	Regional Domination: Intermediate Alliance warfare, conquering Level 8 Valleys/NPCs.
TH Level 9	Level 9 Field Expansions	

Max Valleys: 9

Hero Cap: 9
	Late-Game Escalation: Field expansion, preparing for Title promotions (Baron/Viscount).
TH Level 10	Michelangelo's Script Unlocks	

Max Valleys: 10

Hero Cap: 10
	Imperial Conquest: Level 10 NPC conquest, maximum march limits, end-game hero gearing.
🔄 4. Daily Routine & System Quest Definitions (seed_quests.sql)

Daily routine tasks reset every 24 hours at 00:00 UTC and reinforce optimal account maintenance habits.
SQL

-- Seed Daily & Routine System Quests
INSERT INTO quest_definitions (quest_id, chain_id, sequence_index, category, title, description, rewards_json, unlocks_json) VALUES
('DAILY_001_LOGIN_REWARD', 'CHAIN_DAILY', 1, 'daily', 'Daily Attendance', 'Log in daily to collect your sovereign supplies.', 
 '{"resources":{"food":2000,"lumber":2000,"stone":2000,"iron":2000,"gold":1000},"prestige":50}', NULL),

('DAILY_002_SPIN_WHEEL', 'CHAIN_DAILY', 2, 'daily', 'Aries Wheel of Fortune', 'Spin the Wheel of Fortune using your daily amulet.', 
 '{"resources":{"gold":2000},"items":{"AriesAmulet":1},"prestige":100}', NULL),

('SYS_001_LEVY_RESOURCES', 'CHAIN_SYSTEM', 1, 'system', 'Resource Levy', 'Perform a resource levy from your Town Hall overview.', 
 '{"resources":{"food":1000,"lumber":1000},"prestige":150}', NULL),

('SYS_002_COMFORT_POP', 'CHAIN_SYSTEM', 2, 'system', 'Disaster Relief & Comforting', 'Offer comforting to reduce public grievance and raise loyalty.', 
 '{"resources":{"gold":1000},"prestige":200}', NULL);

-- Objectives for Dailies & System Quests
INSERT INTO quest_objectives (quest_id, action_type, target_entity, target_count) VALUES
('DAILY_001_LOGIN_REWARD', 'use_item', 'DailyLoginTag', 1),
('DAILY_002_SPIN_WHEEL', 'spin_wheel', 'WheelOfFortune', 1),
('SYS_001_LEVY_RESOURCES', 'levy', 'AnyResource', 1),
('SYS_002_COMFORT_POP', 'comfort', 'DisasterRelief', 1);

🔄 5. Comparative Structural Analysis (Classic vs. Modern Node Models)

Modern MMORTS titles refine the classic Evony Age I node architecture while preserving its core mechanics:

    Explicit System Unlock Nodes: In classic Age I, building an Inn unlocks the hero pool. Modern titles (Rise of Kingdoms) express this explicitly as a graph edge: Building:Inn:1 → UnlocksSystem:HeroRecruitment.

    Flexible Quest Dependency Graphs: Instead of rigid linear tutorial chains, modern engines utilize directed acyclic graphs (DAGs) with multiple convergence nodes. A player can finish troop training or field upgrades in any sequence, converging on the TownHallUpgrade node.

    Dynamic Scaling Objective Multipliers: Modern daily quests adjust objective counts dynamically (e.g., train N troops based on player Town Hall level) using parameter tags in target_count formulas rather than fixed integer values.
