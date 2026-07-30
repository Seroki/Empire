BEGIN;

-- Gold comes from population/tax (via Cottage), not a mining building
DELETE FROM building_types WHERE id = 9;

-- Add slot pool and uniqueness metadata
ALTER TABLE building_types ADD COLUMN IF NOT EXISTS slot_pool VARCHAR(20);
ALTER TABLE building_types ADD COLUMN IF NOT EXISTS is_unique BOOLEAN NOT NULL DEFAULT true;

UPDATE building_types
SET slot_pool = 'inner'
WHERE id IN (1,2,10,11,12,13,14,15,16,17,18,19,20,21,22,24,25);

UPDATE building_types
SET slot_pool = 'wall'
WHERE id IN (3,4);

UPDATE building_types
SET slot_pool = 'outer'
WHERE id IN (5,6,7,8);

UPDATE building_types
SET slot_pool = 'wall_fortification'
WHERE id = 23;

-- Multi-instance buildings (compete for open slots instead of being capped at 1)
UPDATE building_types
SET is_unique = false
WHERE id IN (5,6,7,8,10,13,14,15);

-- Most building types can have multiple instances (Barracks, Cottage,
-- Farm, etc.), competing for limited slots instead of being capped by type.
-- Singleton enforcement happens at the application layer using is_unique.
ALTER TABLE city_buildings
DROP CONSTRAINT IF EXISTS city_buildings_city_id_building_type_id_key;

COMMIT;
