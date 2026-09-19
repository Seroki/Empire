const pool = require('../database/db');

function getRandomInt(min, max) {
  return Math.floor(Math.random() * (max - min + 1)) + min;
}

function generateStatWithBonus(baseMin, baseMax) {
  let stat = getRandomInt(baseMin, baseMax);
  if (stat === baseMax) {
    stat += getRandomInt(1, 10);
  }
  return stat;
}

const FIRST_NAMES = [
  'Arthur', 'Valerius', 'Gaius', 'Helena', 'Cassandra', 'Marcus', 'Aurelia', 'Leonidas', 'Thalia', 'Tiberius',
  'Octavius', 'Lucius', 'Flavia', 'Maximus', 'Agrippa', 'Livia', 'Severus', 'Cornelia', 'Vespasian', 'Zenobia',
  'Alexander', 'Perseus', 'Penelope', 'Achilles', 'Hippolyta', 'Ajax', 'Electra', 'Hector', 'Evander', 'Atalanta',
  'Bellerophon', 'Calliope', 'Diomedes', 'Iphigenia', 'Menelaus', 'Nausicaa', 'Odysseus', 'Penthesilea', 'Theseus', 'Althea',
  'Godfrey', 'Eleanor', 'Roland', 'Isolde', 'Percival', 'Guinevere', 'Gawain', 'Morgana', 'Tristan', 'Yvaine',
  'Hadrian', 'Valeria', 'Cassian', 'Lucilla', 'Julian', 'Drusilla', 'Trajan', 'Sabina', 'Claudius', 'Camilla',
  'Titus', 'Marcia', 'Constantine', 'Faustina', 'Domitian', 'Marcella', 'Antoninus', 'Octavia', 'Septimius', 'Antonia',
  'Aeneas', 'Dido', 'Camillus', 'Cloelia', 'Scipio', 'Volumnia', 'Sulla', 'Lucretia', 'Cincinnatus', 'Verginia',
  'Alaric', 'Theodora', 'Belisarius', 'Irene', 'Justinian', 'Pulcheria', 'Heraclius', 'Eudoxia', 'Basil', 'Zoe',
  'Coriolanus', 'Agrippina', 'Germanicus', 'Julia', 'Brutus', 'Tarpeia', 'Cassius', 'Veturia', 'Crassus', 'Servilia'
];

async function getInnLevel(cityId, db = pool) {
  const res = await db.query(
    `SELECT cb.level FROM city_buildings cb
     JOIN building_types bt ON cb.building_type_id = bt.id
     WHERE cb.city_id = $1 AND UPPER(bt.name) = 'INN'`,
    [cityId]
  );
  return res.rows[0]?.level || 0;
}

async function getFeastingHallLevel(cityId, db = pool) {
  const res = await db.query(
    `SELECT cb.level FROM city_buildings cb
     JOIN building_types bt ON cb.building_type_id = bt.id
     WHERE cb.city_id = $1 AND UPPER(bt.name) = 'FEASTING HALL'`,
    [cityId]
  );
  return res.rows[0]?.level || 0;
}

async function generateCandidatesForInn(cityId, innLevel) {
  const client = await pool.connect();
  try {
    await client.query('BEGIN');

    // Remove existing available candidate linkages for this city
    await client.query(
      `DELETE FROM hero_candidates WHERE city_id = $1 AND status = 'available'`,
      [cityId]
    );

    // Fetch unlocked tiers matching Inn level
    const maxPowerLevel = Math.min(Math.max(1, Math.floor(innLevel / 2) + 1), 4);
    const tiersRes = await client.query(
      `SELECT * FROM hero_hiring_tiers WHERE power_level <= $1 ORDER BY power_level ASC`,
      [maxPowerLevel]
    );
    const availableTiers = tiersRes.rows;

    const candidateCount = Math.max(1, innLevel);
    const newCandidates = [];

    for (let i = 0; i < candidateCount; i++) {
      const tier = availableTiers[getRandomInt(0, availableTiers.length - 1)];
      const name = FIRST_NAMES[getRandomInt(0, FIRST_NAMES.length - 1)] + ' ' + String.fromCharCode(65 + getRandomInt(0, 25)) + '.';

      const baseMin = tier.power_level * 15;
      const baseMax = tier.power_level * 25 + 10;

      const pol = generateStatWithBonus(baseMin, baseMax);
      const atk = generateStatWithBonus(baseMin, baseMax);
      const int = generateStatWithBonus(baseMin, baseMax);

      // Create base entity in heroes
      const heroRes = await client.query(
        `INSERT INTO heroes (name, type, power_level, level, politics, attack, intelligence, loyalty, hired, hire_cost, status, city_id)
         VALUES ($1, $2, $3, 1, $4, $5, $6, $7, false, $8, 'available', $9)
         RETURNING *`,
        [name, tier.name, tier.power_level, pol, atk, int, tier.loyalty_cost, tier.gold_cost, cityId]
      );
      const hero = heroRes.rows[0];

      // Link in hero_candidates junction table
      await client.query(
        `INSERT INTO hero_candidates (hero_id, city_id, status, selected_at)
         VALUES ($1, $2, 'available', NOW())`,
        [hero.id, cityId]
      );

      newCandidates.push(hero);
    }

    await client.query('COMMIT');
    return newCandidates;
  } catch (err) {
    await client.query('ROLLBACK');
    throw err;
  } finally {
    client.release();
  }
}

async function hireCandidate(cityId, heroId) {
  const client = await pool.connect();
  try {
    await client.query('BEGIN');

    const cityRes = await client.query(`SELECT owner_id FROM cities WHERE id = $1`, [cityId]);
    if (cityRes.rows.length === 0) throw new Error('City not found.');
    const ownerId = cityRes.rows[0].owner_id;

    const fhLevel = await getFeastingHallLevel(cityId, client);
    const heroCountRes = await client.query(`SELECT COUNT(*) FROM heroes WHERE city_id = $1 AND hired = true`, [cityId]);
    if (parseInt(heroCountRes.rows[0].count, 10) >= fhLevel) {
      throw new Error(`Feasting Hall full (${heroCountRes.rows[0].count}/${fhLevel}). Upgrade Feasting Hall to hire more heroes.`);
    }

    const candRes = await client.query(
      `SELECT * FROM hero_candidates WHERE hero_id = $1 AND city_id = $2 AND status = 'available' FOR UPDATE`,
      [heroId, cityId]
    );
    if (candRes.rows.length === 0) throw new Error('Candidate is no longer available.');

    const heroRes = await client.query(`SELECT * FROM heroes WHERE id = $1 AND hired = false FOR UPDATE`, [heroId]);
    if (heroRes.rows.length === 0) throw new Error('Hero not found or already hired.');
    const hero = heroRes.rows[0];

    const resResult = await client.query(`SELECT gold FROM city_resources WHERE city_id = $1 FOR UPDATE`, [cityId]);
    const currentGold = resResult.rows[0]?.gold || 0;
    if (currentGold < hero.hire_cost) {
      throw new Error(`Insufficient Gold. Required: ${hero.hire_cost}, Available: ${currentGold}`);
    }

    await client.query(
      `UPDATE city_resources SET gold = gold - $1, updated_at = NOW() WHERE city_id = $2`,
      [hero.hire_cost, cityId]
    );

    const updatedHero = await client.query(
      `UPDATE heroes 
       SET hired = true, user_id = $1, status = 'idle', city_id = $2
       WHERE id = $3
       RETURNING *`,
      [ownerId, cityId, heroId]
    );

    await client.query(
      `UPDATE hero_candidates SET status = 'hired' WHERE hero_id = $1 AND city_id = $2`,
      [heroId, cityId]
    );

    await client.query('COMMIT');
    return updatedHero.rows[0];
  } catch (err) {
    await client.query('ROLLBACK');
    throw err;
  } finally {
    client.release();
  }
}
// Append to services/inn.service.js

/**
 * Fetch all hired heroes assigned to a city for the Feasting Hall
 */
async function getHeroesByCity(cityId) {
  const result = await pool.query(
    `SELECT 
       id, 
       name, 
       type, 
       power_level, 
       level, 
       politics, 
       attack, 
       intelligence, 
       loyalty, 
       is_mayor, 
       status,
       experience
     FROM heroes 
     WHERE city_id = $1 AND hired = true 
     ORDER BY is_mayor DESC, id ASC`,
    [cityId]
  );
  return result.rows;
}

/**
 * Unassigns current mayor and sets the new hero as city mayor atomically
 */
async function assignMayor(cityId, heroId) {
  const client = await pool.connect();
  try {
    await client.query('BEGIN');

    // Verify hero exists, belongs to city, and is hired
    const heroCheck = await client.query(
      `SELECT * FROM heroes WHERE id = $1 AND city_id = $2 AND hired = true FOR UPDATE`,
      [heroId, cityId]
    );
    if (heroCheck.rows.length === 0) {
      throw new Error('Hero is not available in this city.');
    }

    // Clear current mayor in this city
    await client.query(
      `UPDATE heroes SET is_mayor = false WHERE city_id = $1`,
      [cityId]
    );

    // Assign new mayor
    const updatedRes = await client.query(
      `UPDATE heroes 
       SET is_mayor = true, status = 'mayor' 
       WHERE id = $1 AND city_id = $2 
       RETURNING *`,
      [heroId, cityId]
    );

    await client.query('COMMIT');
    return updatedRes.rows[0];
  } catch (err) {
    await client.query('ROLLBACK');
    throw err;
  } finally {
    client.release();
  }
}

module.exports = {
  getInnLevel,
  getFeastingHallLevel,
  generateCandidatesForInn,
  hireCandidate,
  getHeroesByCity,
  assignMayor
};

