BEGIN;

ALTER TABLE building_types
ADD COLUMN IF NOT EXISTS unlock_wall_level INTEGER;

CREATE TABLE IF NOT EXISTS wall_fortification_capacity (
    wall_level INTEGER PRIMARY KEY,
    capacity INTEGER NOT NULL
);

INSERT INTO wall_fortification_capacity (wall_level, capacity) VALUES
(1, 100),
(2, 300),
(3, 800),
(4, 1500),
(5, 2500),
(6, 4000),
(7, 6000),
(8, 9000),
(9, 12000),
(10, 16000)
ON CONFLICT (wall_level) DO NOTHING;

-- Archer Tower was previously flagged is_unique=true from an earlier
-- pass, before we knew Wall Fortifications are quantity-based. Fix it.
UPDATE building_types
SET is_unique = false,
    unlock_wall_level = 1
WHERE id = 23;

-- Add the remaining Wall Fortification types
INSERT INTO building_types (id, name, category, max_level, slot_pool, is_unique, unlock_wall_level, description) VALUES
(27, 'Trap',                 'Defense', 1, 'wall_fortification', false, 1, 'Basic anti-infantry trap; triggers on enemy ground troops.'),
(28, 'Abatis',                'Defense', 1, 'wall_fortification', false, 1, 'Anti-cavalry fortification; slows or kills mounted units.'),
(29, 'Rolling Logs',          'Defense', 1, 'wall_fortification', false, 1, 'Heavy logs rolled down the wall; high burst damage.'),
(30, 'Defensive Trebuchet',   'Defense', 1, 'wall_fortification', false, 1, 'Long-range siege defense; high damage vs. all troop types.');

SELECT setval(
    pg_get_serial_sequence('building_types', 'id'),
    (SELECT MAX(id) FROM building_types)
);

COMMIT;
