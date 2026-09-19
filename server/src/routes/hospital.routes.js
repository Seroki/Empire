const express = require('express');

const router = express.Router();
const hospitalService = require("../services/hospital.service");

// GET /hospital/:cityId — full wounded roster, split by state (QUEUED /
// ADMITTED / HEALING). Resolves the queue first so timers/capacity are
// always current, same lazy-resolve pattern as research and levy pool.
router.get("/:cityId", async (req, res) => {
    try {
        const cityId = parseInt(req.params.cityId, 10);
        await hospitalService.resolveHospitalQueue(cityId);
        const roster = await hospitalService.getWoundedRoster(cityId);
        const capacity = await hospitalService.getHospitalCapacity(cityId);
        res.json({ success: true, capacity, roster });
    } catch (error) {
        res.status(500).json({ success: false, error: error.message });
    }
});

// GET /hospital/:cityId/heal-cost/:woundedId — preview cost before paying.
router.get("/:cityId/heal-cost/:woundedId", async (req, res) => {
    try {
        const cityId = parseInt(req.params.cityId, 10);
        const woundedId = parseInt(req.params.woundedId, 10);
        const cost = await hospitalService.getHealCost(cityId, woundedId);
        res.json({ success: true, ...cost });
    } catch (error) {
        res.status(400).json({ success: false, error: error.message });
    }
});

// POST /hospital/:cityId/heal/:woundedId — pay to start healing an
// ADMITTED batch. Manual by design; see hospital.service.js's header.
router.post("/:cityId/heal/:woundedId", async (req, res) => {
    try {
        const cityId = parseInt(req.params.cityId, 10);
        const woundedId = parseInt(req.params.woundedId, 10);
        const result = await hospitalService.startHealing(cityId, woundedId);
        res.json({ success: true, ...result });
    } catch (error) {
        res.status(400).json({ success: false, error: error.message });
    }
});

module.exports = router;
