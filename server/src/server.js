const express = require("express");
const cors = require("cors");
const path = require("path");
require("dotenv").config();

const testRoutes = require("./routes/test.routes");
const playerRoutes = require("./routes/player.routes");
const cityRoutes = require("./routes/city.routes");
const buildingRoutes = require("./routes/building.routes");
const researchRoutes = require('./routes/research.routes');




const app = express();

app.use(cors());
app.use(express.json());

app.use(express.static(path.join(__dirname, "..", "public")));

app.use("/db-test", testRoutes);
app.use("/players", playerRoutes);
app.use("/cities", cityRoutes);
app.use("/buildings", buildingRoutes);
app.use('/api/research', researchRoutes);

app.get("/api/status", (req, res) => {
    res.json({
        message: "Empire Core Online"
    });
});

// Base worker cost per level (e.g. Level 1 = 100 workers, Level 2 = 200 workers)
const WORKERS_PER_LEVEL = 100;

function calculateCityLabor(population, buildings) {
  const workersUsed = (buildings || []).reduce((total, b) => {
    // Only count active/built structures
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
