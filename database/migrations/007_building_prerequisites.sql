BEGIN;

ALTER TABLE building_types
ADD COLUMN IF NOT EXISTS requires_building_id INTEGER REFERENCES building_types(id);

-- Barracks unlocks these support buildings
UPDATE building_types
SET requires_building_id = 13 -- Barracks
WHERE id IN (
    26, -- Rally Spot
    16, -- Forge
    14, -- Stable
    15, -- Workshop
    17, -- Beacon Tower
    24  -- Relief Station
);

-- Inn unlocks Feasting Hall
UPDATE building_types
SET requires_building_id = 20 -- Inn
WHERE id = 21; -- Feasting Hall

COMMIT;
