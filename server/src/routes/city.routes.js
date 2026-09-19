const express = require("express");
const router = express.Router();
const pool = require("../database/db"); // Add pool import for DB queries

const cityService = require("../services/city.service");

// GET /cities/:id
router.get("/:id", async (req, res) => {
    try {
        const state = await cityService.getFullCityState(req.params.id);
        res.json(state);

    } catch (error) {
        console.error("Error loading city:", error);
        res.status(400).json({ error: error.message || "Failed to load city" });
    }
});

// GET /cities/:id/heroes — Added to resolve 404 in Feasting Hall
router.get("/:id/heroes", async (req, res) => {
    try {
        const cityId = parseInt(req.params.id, 10);
        if (isNaN(cityId)) {
            return res.status(400).json({ error: "Invalid City ID" });
        }

    const result = await pool.query(
        `SELECT 
           id, 
           name, 
           level, 
           politics, 
            attack, 
            intelligence, 
            loyalty, 
           is_mayor, 
            COALESCE(status, 'IDLE') AS status 
        FROM heroes 
        WHERE city_id = $1 AND hired = true
        ORDER BY level DESC, id ASC`,
        [cityId]
);

        res.json({ success: true, heroes: result.rows });
    } catch (error) {
        console.error("Error retrieving city heroes:", error);
        res.status(500).json({ error: error.message || "Failed to retrieve heroes" });
    }
});

router.patch("/:id/name", async (req, res) => {
    try {
        const result = await cityService.updateCityName(req.params.id, req.body.name);
        res.json(result);

    } catch (error) {
        console.error("Error renaming city:", error);
        res.status(400).json({ error: error.message || "Failed to rename city" });
    }
});

router.patch("/:id/taxRate", async (req, res) => {
    try {
        const taxRate = await cityService.setTaxRate(req.params.id, req.body.taxRate);
        res.json({ success: true, tax_rate: taxRate });

    } catch (error) {
        console.error("Error setting tax rate:", error);
        res.status(400).json({ error: error.message || "Failed to set tax rate" });
    }
});

router.post("/:id/collect", async (req, res) => {
    try {
        const result = await cityService.collectResource(req.params.id, req.body.buildingId);
        res.json(result);

    } catch (error) {
        console.error("Error collecting resource:", error);
        res.status(400).json({ error: error.message || "Failed to collect resource" });
    }
});
// POST /cities/:id/mayor
router.post("/:id/mayor", async (req, res) => {
    try {
        const cityId = parseInt(req.params.id, 10);
        const result = await cityService.assignMayor(cityId, req.body.heroId);
        res.json(result);
    } catch (error) {
        console.error("Error assigning mayor:", error);
        res.status(400).json({ error: error.message || "Failed to assign mayor" });
    }
});

// POST /cities/:id/heroes/:heroId/release
router.post("/:id/heroes/:heroId/release", async (req, res) => {
    try {
        const cityId = parseInt(req.params.id, 10);
        const heroId = parseInt(req.params.heroId, 10);
        const result = await cityService.releaseHero(cityId, heroId);
        res.json(result);
    } catch (error) {
        console.error("Error releasing hero:", error);
        res.status(400).json({ error: error.message || "Failed to release hero" });
    }
});

module.exports = router;
