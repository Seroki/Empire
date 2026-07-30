// /home/steve/empire-core/server/src/routes/research.routes.js
const express = require('express');
const router = express.Router();
const researchController = require('../controllers/research.controller');

// Dummy middleware pass-through for testing if needed
const authenticateToken = (req, res, next) => next(); 

router.get('/', authenticateToken, researchController.getResearchTree);
router.post('/start', authenticateToken, researchController.startResearch);

module.exports = router;
