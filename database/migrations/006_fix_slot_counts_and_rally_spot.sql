BEGIN;

-- Town Hall has its own fixed position and does not consume an inner slot
UPDATE building_types
SET slot_pool = NULL
WHERE id = 1;

-- Add Rally Spot (missing from original roster)
INSERT INTO building_types (id, name, category, max_level, unlock_th_level, slot_pool, is_unique, description)
VALUES (26, 'Rally Spot', 'Military', 10, 1, 'inner', true, 'Organizes group attacks and troop rallies.');

SELECT setval(
    pg_get_serial_sequence('building_types', 'id'),
    (SELECT MAX(id) FROM building_types)
);

COMMIT;
