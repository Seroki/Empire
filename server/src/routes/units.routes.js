// Units routes
const express = require('express');

const router = express.Router();
const { getBarracksData, startRecruitment, getArmyOverview } = require('../services/units.service');

// GET /units/barracks?cityId=123
// GET /units/barracks?cityId=123&barracksId=456
router.get('/barracks', async (req, res) => {
  try {
    const { cityId, barracksId } = req.query;
    const data = await getBarracksData(cityId, barracksId);
    res.json({ success: true, ...data });
  } catch (err) {
    res.status(500).json({ success: false, error: err.message });
  }
});

// GET /units/overview?cityId=123
router.get('/overview', async (req, res) => {
  try {
    const { cityId } = req.query;
    const army = await getArmyOverview(cityId);
    res.json({ success: true, army });
  } catch (err) {
    res.status(500).json({ success: false, error: err.message });
  }
});

// POST /units/train
router.post('/train', async (req, res) => {
  try {
    const { cityId, unitCode, quantity, barracksId } = req.body;
    const result = await startRecruitment(cityId, unitCode, quantity, barracksId);
    res.json(result);
  } catch (err) {
    res.status(400).json({ success: false, error: err.message });
  }
});

module.exports = router;



/**            troop unlocks must always be considered
Warrior	(blg) Barracks 1—(blg) Cottage 1 – (blg)Farm 1 = troop Warrior opened
Pikeman	(blg) Iron-mine 1 – (blg) Academy 1 (rec) troop 1 (footman) -- (rec) craftsmen 1-- (rec) general 1
Swordsmen	(blg)Iron mine 2- (blg)barracks 2-(rec)Ore production 1 – (rec)blacksmithing 1 – (rec)weapons 1—(rec)swordsmen = troop swordsmen opened
Scouts	(blg)Barracks 2-(blg)beacon tower 2 – (rec)academy 2-(rec) horse husbandry 1 (rec)1-speed 1-(rec)scouts = troop scout opened
Archer	(blg)Barracks 3 – (blg) sawmill 3 – (rec) troop 1 (archers) -- (rec) troop improvement 1-(rec) weapons 1-(rec) Bowery and Fletching 1 –(rec) general 2 = troop Archer opened
Long bowmen	(blg)Barracks 6 – (blg) sawmill 6 – (rec) troop 1 (archers) -- (rec) troop improvement 3-(rec) weapons 3-(rec) Bowery and Fletching 2 –(rec) general 5 = troop long bowmen opened
Cross bowmen	(blg)Barracks 8– (blg) sawmill 8– (rec) troop 1 (archers) -- (rec) troop improvement 4-(rec) weapons 4-(rec) Bowery and Fletching 3 –(rec) general 7 = troop crossbowmen opened
Light Calvary	(blg) Barracks 4 – (blg) stable 4 – (rec) horse husbandry 1-- (rec) general 4-(rec) weapons 2 –(rec) speed 2 = troop Light Calvary opened
Transporters	(blg) Work shop 5 – (blg) Stables 5 – (rec)horse husbandry 2 –(rec) armor 2 – (rec) Mechanisms 1 = troop Transporters opened
Cataphracts	(blg) Barracks 6 – (blg) Stables 6 – (blg) work shop 6 – (rec) speed 3 -- (rec) horse husbandry 3 -(rec) general 6 – (rec) farm production 6 = Troop Cataphract opened
Battering rams	(blg) Barracks 7 – (blg) sawmill 7 – (blg) workshop 7 – (rec) woodworking 3 – (rec) troop 4 (siege) – (rec)  Engineering 2 – (rec) Mechanisms 2 = Troop Battering ram opened
Catapults	(blg) Barracks 9 – (blg) sawmill 9 – (blg) workshop 9 – (rec) weapons 4 – (rec) troop 4 (siege) – (rec)  Engineering 3 – (rec) Mechanisms 3 = Troop Catapults opened
Barista	(blg) Barracks 10 – (blg) sawmill 10 – (blg) workshop 10 – (rec) weapons 4 – (rec) troop 4 (siege) – (rec)  Engineering 4 – (rec) Mechanisms 4 = Troop Balista opened

 */
