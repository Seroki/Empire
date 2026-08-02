const express = require('express');
const cors = require('cors'); // <--- 1. Import cors

const app = express();

// 2. Enable CORS for all origins (or specifically http://localhost:3000)
app.use(cors());
const router = express.Router();

const playerService = require("../services/player.service");


router.post("/create", async (req, res) => {
    try {
        const { username, password } = req.body;
        const result = await playerService.createPlayer(username, password);
        res.json(result);
    } catch (error) {
        console.error(error);
        res.status(500).json({ error: error.message });
    }
});


router.get("/city/:cityId", async (req, res) => {
    try {
        const player = await playerService.getPlayerByCityId(req.params.cityId);
        res.json(player);
    } catch (error) {
        res.status(404).json({ error: error.message });
    }
});


router.patch("/:id/name", async (req, res) => {
    try {
        const result = await playerService.updatePlayerName(
            req.params.id,
            req.body.username
        );
        res.json(result);
    } catch (error) {
        res.status(400).json({ error: error.message });
    }
});


module.exports = router;
