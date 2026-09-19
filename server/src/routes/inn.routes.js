const express = require('express');
const router = express.Router();
const innController = require('../controllers/inn.controller');

const authenticateToken = (req, res, next) => next();

router.get('/', authenticateToken, innController.getInnState);
router.post('/hire', authenticateToken, innController.hireHero);
router.post('/refresh', authenticateToken, innController.refreshHeroPool);

module.exports = router;
