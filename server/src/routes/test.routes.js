const express = require('express');
const cors = require('cors'); // <--- 1. Import cors

const app = express();

// 2. Enable CORS for all origins (or specifically http://localhost:3000)
app.use(cors());
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
