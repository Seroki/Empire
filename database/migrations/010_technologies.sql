BEGIN;

CREATE TABLE IF NOT EXISTS technologies (
    id SERIAL PRIMARY KEY,

    name VARCHAR(50) UNIQUE NOT NULL,
    category VARCHAR(30) NOT NULL,
    max_level INTEGER NOT NULL,

    requires_technology_id INTEGER REFERENCES technologies(id),

    description TEXT
);

INSERT INTO technologies (id, name, category, max_level, description) VALUES
(1,  'Agriculture',        'Economic',     10, 'Increases food production.'),
(2,  'Lumbering',          'Economic',     10, 'Increases lumber production.'),
(3,  'Masonry',            'Economic',     10, 'Increases stone production.'),
(4,  'Mining',             'Economic',     10, 'Increases iron production.'),
(6,  'Military Science',   'Military',     10, 'Root technology for the military research branches.');

INSERT INTO technologies (id, name, category, max_level, requires_technology_id, description) VALUES
(5,  'Construction',       'Construction', 10, 3,  'Reduces building time and gates advanced buildings.'),
(7,  'Informatics',        'Military',     10, 6,  'Improves scouting range, accuracy, and enemy intel.'),
(8,  'Archery',            'Military',     10, 6,  'Unlocks and improves archer troops.'),
(9,  'Military Tradition', 'Military',     10, 6,  'Increases march capacity and army command bonuses.'),
(10, 'Logistics',          'Economic',     10, 1,  'Increases troop carrying capacity.'),
(11, 'Stockpile',          'Economic',     10, 1,  'Increases warehouse capacity.'),
(12, 'Horseback Riding',   'Military',     10, 6,  'Unlocks and improves mounted troops.'),
(13, 'Compass',            'Military',     10, 12, 'Increases march, attack, return, and reinforcement speed.'),
(14, 'Medicine',           'Economic',     10, 1,  'Reduces troop casualties and improves recovery.'),
(15, 'Engineering',        'Military',     10, 6,  'Unlocks and improves siege units.');

SELECT setval(
    pg_get_serial_sequence('technologies', 'id'),
    (SELECT MAX(id) FROM technologies)
);

COMMIT;
