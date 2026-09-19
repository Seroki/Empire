const express = require("express");
const router = express.Router();

const db = require("../database/db");

router.get("/", async (req, res) => {
    try {
        const result = await db.query(
            "SELECT NOW()"
        );

        res.json({
            database: "connected",
            time: result.rows[0].now
        });

    } catch (error) {

        console.error(error);

        res.status(500).json({
            database: "failed",
            error: error.message
        });
    }
});

module.exports = router;
