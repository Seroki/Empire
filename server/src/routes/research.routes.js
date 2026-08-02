// research.routes //
const express = require('express');
const cors = require('cors'); // <--- 1. Import cors

const app = express();

// 2. Enable CORS for all origins (or specifically http://localhost:3000)
app.use(cors());
const router = express.Router();
const researchController = require('../controllers/research.controller');

// Dummy middleware pass-through for testing if needed
const authenticateToken = (req, res, next) => next(); 

router.get('/', authenticateToken, researchController.getResearchTree);
router.post('/start', authenticateToken, researchController.startResearch);

module.exports = router;
