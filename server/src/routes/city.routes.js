// ============================================================================
// FILE: src/routes/city.routes.js
// CITY ROUTES ONLY
// ============================================================================
const express = require('express');
const router = express.Router();
const cityService = require("../services/city.service");
const buildingService = require("../services/building.service");

router.get("/:id", async (req, res) => {
    try {
        const state = await cityService.getFullCityState(req.params.id);
        res.json(state);
    } catch (error) {
        console.error("Error loading city:", error);
        res.status(400).json({ error: error.message || "Failed to load city" });
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
        const result = await buildingService.collectResource(req.params.id, req.body.buildingId);
        res.json(result);
    } catch (error) {
        console.error("Error collecting resource:", error);
        res.status(400).json({ error: error.message || "Failed to collect resource" });
    }
});

module.exports = router;
