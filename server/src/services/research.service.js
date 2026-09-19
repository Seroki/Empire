// ============================================================================
// FILE: src/services/research.service.js
// RESEARCH SERVICE — matches the real database:
// research_nodes (discipline, branch_code, branch_name, level, step,
// effect_type, requires_academy_level, linked_building_id, gold_cost,
// food_cost, research_seconds, is_gateway — cost/time are per-node, not
// formula-derived; quarry_bonus_pct/requires_quarry_level exist but are not
// wired in yet),
// research_node_prerequisites (generalized as of the requirements migration:
// requirement_type = RESEARCH | ACADEMY | BUILDING. RESEARCH rows use
// prerequisite_node_id; ACADEMY rows use required_academy_level; BUILDING
// rows use required_building_type_id + required_building_level. Replaces
// both the old research-only prereq table AND research_nodes.
// requires_academy_level, which is now a legacy column left in place for
// transition but no longer read by this service),
// system_effects (branch_system -> step_bonus_pct, used for the per-branch
// production bonus), and research_queue (the active-research table).
// ============================================================================

const pool = require("../database/db");

// ----------------------------------------------------------------------------
// Cost / duration — research_nodes now has real columns for these
// (gold_cost, food_cost, research_seconds, is_gateway), set per node in the
// DB. Read them directly rather than deriving them from a level formula.
// research_nodes has no wood_cost/stone_cost/iron_cost columns, so research
// only ever consumes gold + food.
// ----------------------------------------------------------------------------

function isGatewayStep(node) {
  return !!node.is_gateway;
}

function calculateNodeCost(node) {
  return {
    gold: Number(node.gold_cost || 0),
    food: Number(node.food_cost || 0)
  };
}

// ActualTime = BaseTime / (1 + MayorINT/100) x 0.95^(AcademyLevel-1)
// BaseTime comes straight from research_nodes.research_seconds.
function calculateResearchTime(baseTimeSeconds, academyLevel, mayorInt) {
  const intFactor = 1 + (Number(mayorInt || 0) / 100);
  const academyFactor = Math.pow(0.95, Math.max(0, Number(academyLevel || 1) - 1));
  return Math.round((baseTimeSeconds / intFactor) * academyFactor);
}

// ----------------------------------------------------------------------------
// Shared lookups
// ----------------------------------------------------------------------------

async function getCityAcademyLevel(client, cityId) {
  const res = await client.query(`
    SELECT cb.level FROM city_buildings cb
    JOIN building_types bt ON cb.building_type_id = bt.id
    WHERE cb.city_id = $1 AND UPPER(bt.name) = 'ACADEMY'
  `, [cityId]);
  return res.rows[0]?.level || 0;
}

async function getCityMayorIntelligence(client, cityId) {
  const res = await client.query(
    `SELECT intelligence FROM heroes WHERE city_id = $1 AND is_mayor = true LIMIT 1`,
    [cityId]
  );
  return res.rows[0]?.intelligence ?? 0;
}

// Map of building_type_id -> level for every building this city has, used
// to resolve BUILDING-type requirements (Workshop, Barracks, Sawmill, etc.)
// generically instead of one-off queries per building.
async function getCityBuildingLevelsMap(client, cityId) {
  const res = await client.query(
    `SELECT building_type_id, level FROM city_buildings WHERE city_id = $1`,
    [cityId]
  );
  const map = {};
  for (const row of res.rows) map[row.building_type_id] = row.level;
  return map;
}

async function getBuildingTypeNameMap(client) {
  const res = await client.query(`SELECT id, name FROM building_types`);
  const map = {};
  for (const row of res.rows) map[row.id] = row.name;
  return map;
}

async function getPlayerCompletedNodeSet(client, playerId) {
  const res = await client.query(
    `SELECT research_node_id FROM player_completed_research_nodes WHERE player_id = $1`,
    [playerId]
  );
  return new Set(res.rows.map(r => r.research_node_id));
}

/**
 * A node is unlocked once every requirement row for it is satisfied.
 * research_node_prerequisites now holds three requirement shapes:
 *   - RESEARCH: prerequisite_node_id must be in the player's completed set
 *     (this is also how Craftsmanship's hidden level-gate works — it's just
 *     a RESEARCH-type row pointing at the relevant Craftsmanship node)
 *   - ACADEMY: academyLevel must meet required_academy_level
 *   - BUILDING: cityBuildingLevels[required_building_type_id] must meet
 *     required_building_level (e.g. Workshop combo requirements)
 */
function isNodeUnlocked(node, requirementsByNodeId, completedSet, academyLevel, cityBuildingLevels) {
  const reqs = requirementsByNodeId[node.id] || [];
  return reqs.every(r => {
    if (r.requirement_type === 'ACADEMY') {
      return academyLevel >= Number(r.required_academy_level || 0);
    }
    if (r.requirement_type === 'BUILDING') {
      const currentLevel = cityBuildingLevels[r.required_building_type_id] || 0;
      return currentLevel >= Number(r.required_building_level || 0);
    }
    // RESEARCH (default/fallback)
    return completedSet.has(r.prerequisite_node_id);
  });
}

async function getAllRequirementsByNodeId(client) {
  const res = await client.query(`SELECT * FROM research_node_prerequisites`);
  const map = {};
  for (const row of res.rows) {
    if (!map[row.research_node_id]) map[row.research_node_id] = [];
    map[row.research_node_id].push(row);
  }
  return map;
}

async function getEffectsByBranchCode(client) {
  const res = await client.query(`SELECT * FROM system_effects`);
  const map = {};
  for (const row of res.rows) map[row.branch_system] = row;
  return map;
}

// ----------------------------------------------------------------------------
// Public: full tree for the Research modal
// ----------------------------------------------------------------------------

async function getResearchTree(playerId, cityId) {
  const client = await pool.connect();
  try {
    const academyLevel = await getCityAcademyLevel(client, cityId);
    const completedSet = await getPlayerCompletedNodeSet(client, playerId);
    const requirementsByNodeId = await getAllRequirementsByNodeId(client);
    const effectsByBranch = await getEffectsByBranchCode(client);
    const cityBuildingLevels = await getCityBuildingLevelsMap(client, cityId);
    const buildingTypeNameMap = await getBuildingTypeNameMap(client);

    const nodeNamesRes = await client.query(`SELECT id, name FROM research_nodes`);
    const nodeNameMap = {};
    for (const row of nodeNamesRes.rows) {
      nodeNameMap[row.id] = row.name;
    }

    const activeQueueRes = await client.query(
      `SELECT * FROM research_queue WHERE player_id = $1 AND status = 'IN_PROGRESS' LIMIT 1`,
      [playerId]
    );
    const activeQueueRow = activeQueueRes.rows[0] || null;
    // Aliases for the existing frontend, which expects tech_code and
    // finish_time (from an older schema) rather than research_node_id and
    // finish_at. Keeping the real column names as the source of truth and
    // aliasing here avoids touching the large, fragile index.html file.
    const activeQueue = activeQueueRow ? {
      ...activeQueueRow,
      tech_code: activeQueueRow.research_node_id,
      finish_time: activeQueueRow.finish_at
    } : null;

    const nodesRes = await client.query(
      `SELECT * FROM research_nodes ORDER BY discipline, branch_code, level, step`
    );

    const tree = {};

    for (const node of nodesRes.rows) {
      const gateway = isGatewayStep(node);
      const completed = completedSet.has(node.id);
      const unlocked = completed || isNodeUnlocked(node, requirementsByNodeId, completedSet, academyLevel, cityBuildingLevels);
      const effect = effectsByBranch[node.branch_code];
      // Gateway nodes carry their own specific bonus_pct (e.g. Construction's
      // 20/25/30...65%). Regular filler nodes fall back to the flat
      // system_effects step bonus (currently +2% across the branches that
      // have it). node.bonus_pct is NULL for nodes where no explicit value
      // was ever given (most completed branches besides Happiness/Construction).
      const bonusPct = node.bonus_pct !== null && node.bonus_pct !== undefined
        ? Number(node.bonus_pct)
        : (node.effect_type === 'BONUS' ? Number(effect?.step_bonus_pct ?? 0) : null);

      const discKey = node.discipline.toLowerCase();
      if (!tree[discKey]) tree[discKey] = {};

      if (!tree[discKey][node.branch_code]) {
        tree[discKey][node.branch_code] = {
          branchName: node.branch_name,
          linkedBuildingId: node.linked_building_id,
          nodes: []
        };
      }

      const rawReqs = requirementsByNodeId[node.id] || [];
      const formattedPrerequisites = rawReqs.map(r => {
        if (r.requirement_type === 'ACADEMY') {
          const requiredLevel = Number(r.required_academy_level || 0);
          return {
            type: 'BUILDING',
            id: 'ACADEMY',
            name: `Academy Level ${requiredLevel}`,
            requiredLevel,
            currentLevel: academyLevel,
            met: academyLevel >= requiredLevel
          };
        }
        if (r.requirement_type === 'BUILDING') {
          const requiredLevel = Number(r.required_building_level || 0);
          const currentLevel = cityBuildingLevels[r.required_building_type_id] || 0;
          const buildingName = buildingTypeNameMap[r.required_building_type_id] || `Building #${r.required_building_type_id}`;
          return {
            type: 'BUILDING',
            id: buildingName.toUpperCase(),
            name: `${buildingName} Level ${requiredLevel}`,
            requiredLevel,
            currentLevel,
            met: currentLevel >= requiredLevel
          };
        }
        // RESEARCH (default/fallback)
        return {
          type: 'RESEARCH',
          id: r.prerequisite_node_id,
          name: nodeNameMap[r.prerequisite_node_id] || r.prerequisite_node_id,
          met: completedSet.has(r.prerequisite_node_id)
        };
      });

      const academyReq = rawReqs.find(r => r.requirement_type === 'ACADEMY');
      const requiredAcademyLevel = academyReq ? Number(academyReq.required_academy_level || 0) : 0;

      tree[discKey][node.branch_code].nodes.push({
        researchId: node.id,
        level: node.level,
        step: node.step,
        name: node.name,
        description: node.description,
        benefitText: node.description, // alias — frontend card display expects this name
        effectType: node.effect_type,
        isGateway: gateway,
        bonusPct,
        requiresAcademyLevel: requiredAcademyLevel,
        cost: calculateNodeCost(node),
        completed,
        unlocked,
        isCurrentlyResearching: activeQueue?.research_node_id === node.id,
        prerequisites: formattedPrerequisites
      });
    }

    return { academyLevel, activeQueue, tree };
  } finally {
    client.release();
  }
}

// ----------------------------------------------------------------------------
// Public: start research on a single node
// ----------------------------------------------------------------------------

async function startResearchNode(playerId, cityId, researchId) {
  const client = await pool.connect();
  try {
    await client.query("BEGIN");

    const nodeRes = await client.query(
      `SELECT * FROM research_nodes WHERE id = $1`,
      [researchId]
    );
    if (nodeRes.rows.length === 0) {
      throw new Error(`Unknown research node: ${researchId}`);
    }
    const node = nodeRes.rows[0];

    // 1. No concurrent research.
    const activeRes = await client.query(
      `SELECT * FROM research_queue WHERE player_id = $1 AND status = 'IN_PROGRESS' LIMIT 1`,
      [playerId]
    );
    if (activeRes.rows.length > 0) {
      throw new Error(`Already researching node #${activeRes.rows[0].research_node_id}. Wait until it finishes.`);
    }

    // 2. Not already completed.
    const completedRes = await client.query(
      `SELECT 1 FROM player_completed_research_nodes WHERE player_id = $1 AND research_node_id = $2`,
      [playerId, researchId]
    );
    if (completedRes.rows.length > 0) {
      throw new Error(`${node.name} is already researched.`);
    }

    // 3. Academy level (city-wide, needed below for cost/time too).
    const academyLevel = await getCityAcademyLevel(client, cityId);

    // 4. Requirements — every row for this node must be satisfied:
    //    RESEARCH (must be completed), ACADEMY (level met), or BUILDING
    //    (city's building of that type meets the level, e.g. Workshop combo
    //    requirements, or Craftsmanship's hidden-level RESEARCH-type gate).
    const reqRes = await client.query(
      `SELECT * FROM research_node_prerequisites WHERE research_node_id = $1`,
      [researchId]
    );
    const completedSet = await getPlayerCompletedNodeSet(client, playerId);
    const cityBuildingLevels = await getCityBuildingLevelsMap(client, cityId);

    for (const r of reqRes.rows) {
      if (r.requirement_type === 'ACADEMY') {
        const requiredLevel = Number(r.required_academy_level || 0);
        if (academyLevel < requiredLevel) {
          throw new Error(`Requires Academy Level ${requiredLevel}.`);
        }
      } else if (r.requirement_type === 'BUILDING') {
        const requiredLevel = Number(r.required_building_level || 0);
        const currentLevel = cityBuildingLevels[r.required_building_type_id] || 0;
        if (currentLevel < requiredLevel) {
          const buildingTypeNameMap = await getBuildingTypeNameMap(client);
          const buildingName = buildingTypeNameMap[r.required_building_type_id] || `Building #${r.required_building_type_id}`;
          throw new Error(`Requires ${buildingName} Level ${requiredLevel}.`);
        }
      } else {
        // RESEARCH (default/fallback)
        if (!completedSet.has(r.prerequisite_node_id)) {
          const prereqNodeRes = await client.query(
            `SELECT name FROM research_nodes WHERE id = $1`,
            [r.prerequisite_node_id]
          );
          const prereqName = prereqNodeRes.rows[0]?.name || `node #${r.prerequisite_node_id}`;
          throw new Error(`Requires ${prereqName} to be researched first.`);
        }
      }
    }

    // 5. Cost — straight from the node's own gold_cost/food_cost columns.
    const cost = calculateNodeCost(node);
    const resResult = await client.query(`SELECT * FROM city_resources WHERE city_id = $1 FOR UPDATE`, [cityId]);
    if (resResult.rows.length === 0) throw new Error("City resources not found.");
    const resources = resResult.rows[0];

    if (resources.food < cost.food || resources.gold < cost.gold) {
      throw new Error("Insufficient resources for this research.");
    }

    await client.query(`
      UPDATE city_resources
      SET food = food - $1, gold = gold - $2, updated_at = NOW()
      WHERE city_id = $3
    `, [cost.food, cost.gold, cityId]);

    // 6. Duration — node's own research_seconds, reduced by mayor's
    // intelligence and further discounted by academy level.
    const mayorInt = await getCityMayorIntelligence(client, cityId);
    const baseTime = Number(node.research_seconds || 0);
    const durationSeconds = calculateResearchTime(baseTime, academyLevel, mayorInt);

    const startedAt = new Date();
    const finishAt = new Date(startedAt.getTime() + durationSeconds * 1000);

    const insertRes = await client.query(`
      INSERT INTO research_queue (player_id, city_id, research_node_id, started_at, finish_at, status)
      VALUES ($1, $2, $3, $4, $5, 'IN_PROGRESS')
      RETURNING *
    `, [playerId, cityId, researchId, startedAt, finishAt]);

    await client.query("COMMIT");
    return insertRes.rows[0];

  } catch (err) {
    await client.query("ROLLBACK");
    throw err;
  } finally {
    client.release();
  }
}

async function resolveCompletedResearch(playerId) {
  const completedRes = await pool.query(
    `SELECT * FROM research_queue WHERE player_id = $1 AND status = 'IN_PROGRESS' AND finish_at <= NOW()`,
    [playerId]
  );

  for (const item of completedRes.rows) {
    await pool.query(`
      INSERT INTO player_completed_research_nodes (player_id, research_node_id)
      VALUES ($1, $2)
      ON CONFLICT (player_id, research_node_id) DO NOTHING
    `, [playerId, item.research_node_id]);

    await pool.query(
      `UPDATE research_queue SET status = 'COMPLETED' WHERE id = $1`,
      [item.id]
    );

    // Collect this node's bonus into the player's running totals, if it
    // has one. Archery's gateways currently have no bonus_value (never
    // given an explicit cumulative % in the source design), so those are
    // skipped rather than adding NULL/0.
    const nodeRes = await pool.query(
      `SELECT bonus_type, bonus_value FROM research_nodes WHERE id = $1`,
      [item.research_node_id]
    );
    const node = nodeRes.rows[0];
    if (node && node.bonus_type && node.bonus_value != null) {
      await pool.query(`
        INSERT INTO player_bonus_totals (player_id, bonus_type, total_value)
        VALUES ($1, $2, $3)
        ON CONFLICT (player_id, bonus_type)
        DO UPDATE SET total_value = player_bonus_totals.total_value + EXCLUDED.total_value
      `, [playerId, node.bonus_type, node.bonus_value]);
    }
  }

  return completedRes.rows;
}

// Returns a map of bonus_type -> total_value for a player, e.g.
// { CONSTRUCTION_SPEED: 27.00, FARM_EFFECTIVENESS: 6.00 }. Other services
// (building speed/cost, resource production, combat, etc.) call this to
// look up the player's current stacked bonus for a given stat.
async function getPlayerBonusTotals(playerId) {
  const res = await pool.query(
    `SELECT bonus_type, total_value FROM player_bonus_totals WHERE player_id = $1`,
    [playerId]
  );
  const totals = {};
  for (const row of res.rows) {
    totals[row.bonus_type] = Number(row.total_value);
  }
  return totals;
}

module.exports = {
  calculateNodeCost,
  calculateResearchTime,
  getResearchTree,
  startResearchNode,
  resolveCompletedResearch,
  getPlayerBonusTotals
};
