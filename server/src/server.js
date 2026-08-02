const express = require("express");
const cors = require("cors");
const path = require("path");
const app = express();

require("dotenv").config();

// Route imports
const testRoutes = require("./routes/test.routes");
const playerRoutes = require("./routes/player.routes");   // FIXED
const cityRoutes = require("./routes/city.routes");
const buildingRoutes = require("./routes/building.routes");
const researchRoutes = require("./routes/research.routes");
const unitsRoutes = require("./routes/units.routes");

app.use(cors());
app.use(express.json());

// Serve GUI correctly
app.use(express.static(path.join(__dirname, "..", "public")));

// Serve index.html on root
app.get("/", (req, res) => {
    res.sendFile(path.join(__dirname, "..", "public", "index.html"));
});

app.use("/db-test", testRoutes);
app.use("/players", playerRoutes);
app.use("/cities", cityRoutes);
app.use("/buildings", buildingRoutes);
app.use("/research", researchRoutes);
app.use("/units", unitsRoutes);

app.get("/api/status", (req, res) => {
    res.json({ message: "Empire Core Online" });
});

const WORKERS_PER_LEVEL = 100;

function calculateCityLabor(population, buildings) {
    const workersUsed = (buildings || []).reduce((total, b) => {
        if (!b.level || b.level <= 0) return total;
        return total + (b.level * WORKERS_PER_LEVEL);
    }, 0);

    const idleWorkers = Math.max(0, population - workersUsed);

    return { workersUsed, idleWorkers };
}

const PORT = process.env.PORT || 3000;

app.listen(PORT, () => {
    console.log(`Server running on port ${PORT}`);
});

