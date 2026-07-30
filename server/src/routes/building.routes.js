const express = require("express");
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


module.exports = router;
