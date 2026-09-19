process.env.TZ = 'UTC';

const express = require("express");
const cors = require("cors");
const path = require("path");
require("dotenv").config();

// Route imports
const testRoutes = require("./routes/test.routes");
const playerRoutes = require("./routes/player.routes");
const cityRoutes = require("./routes/city.routes");
const buildingRoutes = require("./routes/building.routes");
const researchRoutes = require("./routes/research.routes");
const unitsRoutes = require("./routes/units.routes");
const marketRoutes = require("./routes/market.routes");
const defenseRoutes = require("./routes/defense.routes");
const innRoutes = require("./routes/inn.routes");
const holdingsRoutes = require("./routes/holdings.routes");
const mapRoutes = require("./routes/map.routes");
const npcRoutes = require("./routes/npc.routes");
const valleyRoutes = require("./routes/valley.routes");
const resourcefieldRoutes = require('./routes/resourceField.routes');
const hospitalRoutes = require("./routes/hospital.routes");
const app = express();
const BACKEND_VERSION = "v2026.08.23-tz-fix";

app.use(cors());
app.use(express.json());

// Serve static frontend files
app.use(express.static(path.join(__dirname, "..", "public")));

// API Route mounts
app.use("/db-test", testRoutes);
app.use("/players", playerRoutes);
app.use("/cities", cityRoutes);
app.use("/buildings", buildingRoutes);
app.use("/research", researchRoutes);
app.use("/api/research", researchRoutes);
app.use("/units", unitsRoutes);
app.use("/api/units", unitsRoutes);
app.use("/market", marketRoutes);
app.use("/defenses", defenseRoutes);
app.use("/inn", innRoutes);
app.use("/api/inn", innRoutes);
app.use('/holdings', holdingsRoutes);
app.use("/map", mapRoutes);
app.use("/npc", npcRoutes);
app.use("/valley", valleyRoutes);
app.use('/resource-field', resourcefieldRoutes);
app.use("/hospital", hospitalRoutes);
app.use("/api/hospital", hospitalRoutes);


app.get("/", (req, res) => {
    res.sendFile(path.join(__dirname, "..", "public", "index.html"));
});

app.get("/api/status", (req, res) => {
    res.json({ message: "Empire Core Online", version: BACKEND_VERSION });
});

const PORT = process.env.PORT || 5000;

const server = app.listen(PORT, () => {
    console.log(`Server running on port ${PORT} — ${BACKEND_VERSION} — TZ=${process.env.TZ}`);
    console.log("Listening on:", server.address());
});
