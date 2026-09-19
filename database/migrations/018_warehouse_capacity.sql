BEGIN;

ALTER TABLE building_levels
ADD COLUMN IF NOT EXISTS storage_capacity NUMERIC NOT NULL DEFAULT 0;

-- Real Warehouse capacity curve, Volume XIV (Evony Age I verified).
-- Applies per resource type, including gold.
UPDATE building_levels SET storage_capacity = 10000  WHERE building_type_id = 11 AND level = 1;
UPDATE building_levels SET storage_capacity = 30000  WHERE building_type_id = 11 AND level = 2;
UPDATE building_levels SET storage_capacity = 60000  WHERE building_type_id = 11 AND level = 3;
UPDATE building_levels SET storage_capacity = 100000 WHERE building_type_id = 11 AND level = 4;
UPDATE building_levels SET storage_capacity = 150000 WHERE building_type_id = 11 AND level = 5;
UPDATE building_levels SET storage_capacity = 210000 WHERE building_type_id = 11 AND level = 6;
UPDATE building_levels SET storage_capacity = 280000 WHERE building_type_id = 11 AND level = 7;
UPDATE building_levels SET storage_capacity = 360000 WHERE building_type_id = 11 AND level = 8;
UPDATE building_levels SET storage_capacity = 450000 WHERE building_type_id = 11 AND level = 9;
UPDATE building_levels SET storage_capacity = 550000 WHERE building_type_id = 11 AND level = 10;

COMMIT;
