// CRITICAL: must be the very first thing that runs, before any other
// require() — Postgres timestamp columns here are "timestamp without time
// zone" (raw UTC clock values, no zone label). node-postgres interprets
// those naive values as being in the CURRENT PROCESS's local timezone when
// building JS Date objects, not UTC. Without this, a server running in
// America/Chicago (UTC-5/-6) reads every finish_time ~5-6 hours later than
// it actually is — corrupting every countdown in the app: construction,
// research, recruitment, Levy Pool refill, morale drift, all of it. Forcing
// the process's own timezone to UTC makes "naive timestamp" == "UTC
// timestamp" == correct, with zero schema changes needed.
// MUST BE LINE 1 — Before any require() statements
const _origExit = process.exit;
process.exit = function (code) {
  console.trace(`process.exit(${code}) was called from:`);
  return _origExit.apply(this, arguments);
};

process.env.TZ = 'UTC';
const express = require("express");
const cors = require("cors");
// ... rest of server.js
const path = require("path");
const app = express();
require("dotenv").config();

// Bump this on every meaningful backend change, matching the frontend's
// version badge convention (index.html, bottom-right corner) — lets you
// confirm what's actually deployed via GET /api/status or the startup log,
// instead of guessing whether a file copy + restart actually took.
const BACKEND_VERSION = "v2026.08.23-tz-fix";

// Route imports
const testRoutes = require("./routes/test.routes");
const playerRoutes = require("./routes/player.routes");   // FIXED
const cityRoutes = require("./routes/city.routes");
const buildingRoutes = require("./routes/building.routes");
const researchRoutes = require("./routes/research.routes");
const innRoutes = require("./routes/inn.routes");         // ADDED: Inn & Hero system
const unitsRoutes = require("./routes/units.routes");
const mapRoutes = require("./routes/map.routes");
const npcRoutes = require("./routes/npc.routes");
const valleyRoutes = require("./routes/valley.routes");
const resourcefieldRoutes = require('./routes/resourceField.routes');
const holdingsRoutes = require('./routes/holdings.routes');
const marketRoutes = require("./routes/market.routes");
const defenseRoutes = require("./routes/defense.routes"); // ADDED

app.use(cors());
app.use(express.json());

// Serve GUI static files correctly
app.use(express.static(path.join(__dirname, "..", "public")));

// Serve index.html on root
app.get("/", (req, res) => {
    res.sendFile(path.join(__dirname, "..", "public", "index.html"));
});

// API Routes
app.use("/db-test", testRoutes);
app.use("/players", playerRoutes);
app.use("/cities", cityRoutes);
app.use("/buildings", buildingRoutes);

// Research routes (aliased for both /research and /api/research)
app.use("/research", researchRoutes);
app.use("/api/research", researchRoutes);

// Units routes (aliased for both /units and /api/units)
app.use("/units", unitsRoutes);
app.use("/api/units", unitsRoutes);


// Mount market API endpoints
app.use("/market", marketRoutes); //
app.use("/defenses", defenseRoutes); // ADDED

// Inn & Hero routes (aliased for both /inn and /api/inn)
app.use("/inn", innRoutes);
app.use("/api/inn", innRoutes);
app.use('/holdings', holdingsRoutes);
app.use("/units", unitsRoutes);
app.use("/map", mapRoutes);
app.use("/npc", npcRoutes);
app.use("/valley", valleyRoutes);
app.use('/resource-field', resourcefieldRoutes);
app.get("/api/status", (req, res) => {
    res.json({ message: "Empire Core Online", version: BACKEND_VERSION });
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

const PORT = process.env.PORT || 5000;

const server = app.listen(PORT, () => {
    console.log(`Server running on port ${PORT} — ${BACKEND_VERSION} — TZ=${process.env.TZ}`);
    console.log("Active handles count:", process._getActiveHandles().length);
});

server.on('close', () => {
    console.log('HTTP Server instance was closed!');
});

process.on('exit', (code) => {
    console.log(`Process exited with code: ${code}`);
});

process.on('uncaughtException', (err) => {
    console.error('Uncaught Exception:', err);
});

process.on('unhandledRejection', (reason, promise) => {
    console.error('Unhandled Rejection at:', promise, 'reason:', reason);
});
