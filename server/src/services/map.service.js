// ============================================================================
// FILE: src/services/map.service.js
// WORLD MAP SERVICE
// ============================================================================

const pool = require("../database/db");

const MAP_SIZE = 100; // 100x100 grid, 0-99 on each axis

// Generation distribution. EMPTY makes up the remainder.
const TILE_WEIGHTS = {
  NPC: 0.05,
  RESOURCE: 0.08,
  VALLEY: 0.02
};

const RESOURCE_TYPES = ["food", "wood", "stone", "iron"];

function rollTileType() {
  const roll = Math.random();
  if (roll < TILE_WEIGHTS.NPC) return "NPC";
  if (roll < TILE_WEIGHTS.NPC + TILE_WEIGHTS.RESOURCE) return "RESOURCE";
  if (roll < TILE_WEIGHTS.NPC + TILE_WEIGHTS.RESOURCE + TILE_WEIGHTS.VALLEY) return "VALLEY";
  return "EMPTY";
}

function randomLevel(min, max) {
  return Math.floor(Math.random() * (max - min + 1)) + min;
}

/**
 * Generate the full 100x100 map. Idempotent — refuses to run if the map
 * already has tiles, so it's safe to call from a setup script without
 * accidentally wiping an in-progress world.
 */
async function generateWorldMap() {
  const existing = await pool.query(`SELECT COUNT(*)::int AS count FROM map_tiles`);
  if (existing.rows[0].count > 0) {
    throw new Error(`Map already generated (${existing.rows[0].count} tiles exist). Call resetWorldMap() first if you want to regenerate.`);
  }

  const tiles = [];
  for (let x = 0; x < MAP_SIZE; x++) {
    for (let y = 0; y < MAP_SIZE; y++) {
      const tileType = rollTileType();

      const tile = {
        x, y,
        tile_type: tileType,
        resource_type: null,
        resource_level: null,
        npc_level: null,
        name: null
      };

      if (tileType === "RESOURCE") {
        tile.resource_type = RESOURCE_TYPES[Math.floor(Math.random() * RESOURCE_TYPES.length)];
        tile.resource_level = randomLevel(1, 5);
      } else if (tileType === "NPC") {
        tile.npc_level = randomLevel(1, 10);
        tile.name = `Barbarian Camp (Lv ${tile.npc_level})`;
      } else if (tileType === "VALLEY") {
        tile.name = `Valley (${x}, ${y})`;
      }

      tiles.push(tile);
    }
  }

  // Bulk insert in chunks to avoid one enormous query for 10,000 rows.
  const CHUNK_SIZE = 500;
  const client = await pool.connect();
  try {
    await client.query("BEGIN");
    for (let i = 0; i < tiles.length; i += CHUNK_SIZE) {
      const chunk = tiles.slice(i, i + CHUNK_SIZE);
      const values = [];
      const placeholders = chunk.map((t, idx) => {
        const base = idx * 7;
        values.push(t.x, t.y, t.tile_type, t.resource_type, t.resource_level, t.npc_level, t.name);
        return `($${base + 1}, $${base + 2}, $${base + 3}, $${base + 4}, $${base + 5}, $${base + 6}, $${base + 7})`;
      }).join(", ");

      await client.query(`
        INSERT INTO map_tiles (x, y, tile_type, resource_type, resource_level, npc_level, name)
        VALUES ${placeholders}
      `, values);
    }
    await client.query("COMMIT");
  } catch (err) {
    await client.query("ROLLBACK");
    throw err;
  } finally {
    client.release();
  }

  return { tilesGenerated: tiles.length, mapSize: MAP_SIZE };
}

/**
 * Wipes the map. Only for test/dev use between iterations — not exposed
 * as a route by default, call directly from a script if you need to
 * regenerate.
 */
async function resetWorldMap() {
  await pool.query(`TRUNCATE map_tiles RESTART IDENTITY`);
}

/**
 * Full grid, with city/owner names joined in for display. Fine to return
 * in one shot at this map size (10,000 rows) — revisit with a bounding-box
 * query param if the map ever grows much larger than 100x100.
 */
async function getFullMap() {
  const result = await pool.query(`
    SELECT
      mt.x, mt.y, mt.tile_type, mt.resource_type, mt.resource_level,
      mt.npc_level, mt.name,
      mt.city_id, c.name AS city_name, c.owner_id AS city_owner_id,
      th.level AS city_th_level,
      mt.owner_city_id, oc.name AS owner_city_name
    FROM map_tiles mt
    LEFT JOIN cities c ON mt.city_id = c.id
    LEFT JOIN LATERAL (
      SELECT cb.level
      FROM city_buildings cb
      JOIN building_types bt ON cb.building_type_id = bt.id
      WHERE cb.city_id = c.id AND UPPER(bt.name) = 'TOWN HALL'
      LIMIT 1
    ) th ON mt.tile_type = 'CITY'
    LEFT JOIN cities oc ON mt.owner_city_id = oc.id
    ORDER BY mt.y, mt.x
  `);
  return result.rows;
}

async function getTile(x, y) {
  const result = await pool.query(`
    SELECT
      mt.x, mt.y, mt.tile_type, mt.resource_type, mt.resource_level,
      mt.npc_level, mt.name,
      mt.city_id, c.name AS city_name, c.owner_id AS city_owner_id, c.created_at AS city_founded_at,
      th.level AS city_th_level,
      mt.owner_city_id, oc.name AS owner_city_name
    FROM map_tiles mt
    LEFT JOIN cities c ON mt.city_id = c.id
    LEFT JOIN LATERAL (
      SELECT cb.level
      FROM city_buildings cb
      JOIN building_types bt ON cb.building_type_id = bt.id
      WHERE cb.city_id = c.id AND UPPER(bt.name) = 'TOWN HALL'
      LIMIT 1
    ) th ON mt.tile_type = 'CITY'
    LEFT JOIN cities oc ON mt.owner_city_id = oc.id
    WHERE mt.x = $1 AND mt.y = $2
  `, [x, y]);

  if (result.rows.length === 0) {
    throw new Error(`Tile (${x}, ${y}) is out of bounds.`);
  }
  return result.rows[0];
}

/**
 * Pick a random EMPTY tile — for auto-placing a new city. Not yet wired
 * into player.service.js's createPlayer(), which still hardcodes every
 * new Capital to (0,0). That's a real collision bug now that map_tiles
 * enforces a real grid, but changing player creation flow is a separate
 * decision — see SESSION_NOTES for this flagged as a follow-up.
 */
async function findRandomEmptyTile() {
  const result = await pool.query(`
    SELECT x, y FROM map_tiles
    WHERE tile_type = 'EMPTY'
    OFFSET floor(random() * (SELECT COUNT(*) FROM map_tiles WHERE tile_type = 'EMPTY'))::int
    LIMIT 1
  `);
  if (result.rows.length === 0) {
    throw new Error("No empty tiles remaining on the map.");
  }
  return result.rows[0];
}

/**
 * Claim a specific EMPTY tile for a newly founded city.
 */
async function claimTileForCity(x, y, cityId) {
  const result = await pool.query(`
    UPDATE map_tiles
    SET tile_type = 'CITY', city_id = $3
    WHERE x = $1 AND y = $2 AND tile_type = 'EMPTY'
    RETURNING *
  `, [x, y, cityId]);

  if (result.rows.length === 0) {
    throw new Error(`Tile (${x}, ${y}) is not available to found a city on.`);
  }
  return result.rows[0];
}

module.exports = {
  MAP_SIZE,
  generateWorldMap,
  resetWorldMap,
  getFullMap,
  getTile,
  findRandomEmptyTile,
  claimTileForCity
};
