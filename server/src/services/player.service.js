const db = require("../database/db");
const bcrypt = require("bcrypt");


async function createPlayer(username, password) {

    const passwordHash = await bcrypt.hash(password, 10);

    const client = await db.connect();

    try {

        await client.query("BEGIN");


        // Create player
        const playerResult = await client.query(
            `
            INSERT INTO players
            (username, password_hash)
            VALUES ($1,$2)
            RETURNING id, username
            `,
            [
                username,
                passwordHash
            ]
        );


        const player = playerResult.rows[0];


        // Create starting city
        const cityResult = await client.query(
            `
            INSERT INTO cities
            (owner_id, name, x, y)
            VALUES ($1,'Capital',0,0)
            RETURNING id,name
            `,
            [
                player.id
            ]
        );


        const city = cityResult.rows[0];


        // Starting resources
        await client.query(
            `
            INSERT INTO city_resources
            (city_id)
            VALUES ($1)
            `,
            [
                city.id
            ]
        );


        // Starting Town Hall
        await client.query(
            `
            INSERT INTO city_buildings
            (
                city_id,
                building_type_id,
                level,
                position_x,
                position_y
            )

            VALUES
            (
                $1,
                1,
                1,
                5,
                5
            )
            `,
            [city.id]
        );

        await client.query("COMMIT");


        return {
            player,
            city
        };


    } catch(error){

        await client.query("ROLLBACK");
        throw error;

    } finally {

        client.release();

    }
}


async function getPlayerByCityId(cityId) {
    const result = await db.query(
        `
        SELECT p.id, p.username, p.title, p.prestige, p.honor, p.alliance
        FROM players p
        JOIN cities c ON c.owner_id = p.id
        WHERE c.id = $1
        `,
        [cityId]
    );
    if (result.rows.length === 0) {
        throw new Error("Player not found for this city");
    }
    return result.rows[0];
}


async function updatePlayerName(playerId, username) {
    const trimmed = String(username || "").trim();
    if (trimmed.length < 1 || trimmed.length > 50) {
        throw new Error("Player name must be between 1 and 50 characters");
    }

    try {
        const result = await db.query(
            `UPDATE players SET username = $1 WHERE id = $2 RETURNING id, username`,
            [trimmed, playerId]
        );
        if (result.rows.length === 0) {
            throw new Error("Player not found");
        }
        return result.rows[0];

    } catch (error) {
        if (error.code === "23505") {
            throw new Error("That name is already taken");
        }
        throw error;
    }
}


module.exports = {
    createPlayer,
    getPlayerByCityId,
    updatePlayerName
};
