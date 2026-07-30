BEGIN;

ALTER TABLE city_resources
ADD COLUMN IF NOT EXISTS tax_rate INTEGER NOT NULL DEFAULT 30;

ALTER TABLE city_resources
ADD COLUMN IF NOT EXISTS population INTEGER NOT NULL DEFAULT 200;

ALTER TABLE building_levels
ADD COLUMN IF NOT EXISTS population_capacity INTEGER NOT NULL DEFAULT 0;

-- Each Cottage grants +100 population capacity (flat for now — can
-- differentiate by level later)
UPDATE building_levels
SET population_capacity = 100
WHERE building_type_id = 10;

COMMIT;
