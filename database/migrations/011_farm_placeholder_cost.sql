BEGIN;

-- Rough placeholder cost, to be balanced later
INSERT INTO building_levels
(building_type_id, level, food_cost, wood_cost, stone_cost, iron_cost, gold_cost, build_seconds, food_per_hour)
VALUES
(5, 1, 0, 200, 150, 0, 0, 30, 50)
ON CONFLICT (building_type_id, level) DO NOTHING;

COMMIT;
