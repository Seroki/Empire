BEGIN;

-------------------------------------------------
-- PLAYERS
-------------------------------------------------

CREATE TABLE players (
    id SERIAL PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    password_hash TEXT NOT NULL,

    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    last_login TIMESTAMP
);

-------------------------------------------------
-- CITIES
-------------------------------------------------

CREATE TABLE cities (
    id SERIAL PRIMARY KEY,

    owner_id INTEGER NOT NULL
        REFERENCES players(id)
        ON DELETE CASCADE,

    name VARCHAR(100) NOT NULL,

    x INTEGER NOT NULL,
    y INTEGER NOT NULL,

    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-------------------------------------------------
-- RESOURCES
-------------------------------------------------

CREATE TABLE city_resources (

    city_id INTEGER PRIMARY KEY
        REFERENCES cities(id)
        ON DELETE CASCADE,

    food BIGINT DEFAULT 5000,
    wood BIGINT DEFAULT 5000,
    stone BIGINT DEFAULT 5000,
    iron BIGINT DEFAULT 5000,
    gold BIGINT DEFAULT 1000,

    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-------------------------------------------------
-- BUILDING TYPES
-------------------------------------------------

CREATE TABLE building_types (

    id SERIAL PRIMARY KEY,

    name VARCHAR(50) UNIQUE NOT NULL,

    category VARCHAR(30) NOT NULL,

    max_level INTEGER NOT NULL,

    description TEXT
);

-------------------------------------------------
-- BUILDING LEVELS
-------------------------------------------------

CREATE TABLE building_levels (

    id SERIAL PRIMARY KEY,

    building_type_id INTEGER NOT NULL
        REFERENCES building_types(id)
        ON DELETE CASCADE,

    level INTEGER NOT NULL,

    food_cost INTEGER NOT NULL,
    wood_cost INTEGER NOT NULL,
    stone_cost INTEGER NOT NULL,
    iron_cost INTEGER NOT NULL,
    gold_cost INTEGER NOT NULL,

    build_seconds INTEGER NOT NULL,

    food_per_hour INTEGER DEFAULT 0,
    wood_per_hour INTEGER DEFAULT 0,
    stone_per_hour INTEGER DEFAULT 0,
    iron_per_hour INTEGER DEFAULT 0,
    gold_per_hour INTEGER DEFAULT 0,

    UNIQUE(building_type_id, level)
);

-------------------------------------------------
-- CITY BUILDINGS
-------------------------------------------------

CREATE TABLE city_buildings (

    id SERIAL PRIMARY KEY,

    city_id INTEGER NOT NULL
        REFERENCES cities(id)
        ON DELETE CASCADE,

    building_type_id INTEGER NOT NULL
        REFERENCES building_types(id),

    level INTEGER NOT NULL DEFAULT 1,

    position_x INTEGER NOT NULL DEFAULT 0,
    position_y INTEGER NOT NULL DEFAULT 0,

    UNIQUE(city_id, building_type_id)
);

-------------------------------------------------
-- CONSTRUCTION QUEUE
-------------------------------------------------

CREATE TABLE construction_queue (

    id SERIAL PRIMARY KEY,

    city_id INTEGER NOT NULL
        REFERENCES cities(id)
        ON DELETE CASCADE,

    building_id INTEGER NOT NULL
        REFERENCES city_buildings(id)
        ON DELETE CASCADE,

    target_level INTEGER NOT NULL,

    started_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    finish_time TIMESTAMP NOT NULL
);

COMMIT;
