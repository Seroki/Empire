const express = require('express');

const router = express.Router();

const buildingService = require("../services/building.service");


router.post("/upgrade", async (req,res)=>{

    try {

        const result =
            await buildingService.startUpgrade(
                req.body.cityId,
                req.body.buildingId
            );


        res.json(result);


    } catch(error){

        res.status(400).json({
            error:error.message
        });

    }

});


router.post("/construct", async (req,res)=>{

    try {

        const result =
            await buildingService.constructBuilding(
                req.body.cityId,
                req.body.buildingTypeId
            );


        res.json(result);


    } catch(error){

        res.status(400).json({
            error:error.message
        });

    }

});

// COLLECT RESOURCES ROUTE
router.post("/collect/:cityId/:buildingId", async (req, res) => {
    try {
        const { cityId, buildingId } = req.params;
        const result = await buildingService.collectResource(cityId, buildingId);
        res.json({ success: true, data: result });
    } catch (error) {
        res.status(400).json({
            success: false,
            error: error.message
        });
    }
});

router.get("/city/:cityId", async (req, res) => {
    try {
        // Settle any construction/upgrades whose finish_time has already
        // passed BEFORE reading buildings, so the levels we return are current.
        await buildingService.processCompletedConstruction(req.params.cityId);

        const buildings = await buildingService.getCityBuildings(req.params.cityId);
        res.json(buildings);
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

module.exports = router;
