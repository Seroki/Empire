BEGIN;

CREATE TABLE IF NOT EXISTS town_hall_wall_requirements (
    town_hall_level INTEGER PRIMARY KEY,
    required_wall_level INTEGER NOT NULL
);

INSERT INTO town_hall_wall_requirements (town_hall_level, required_wall_level) VALUES
(3, 1),
(4, 2),
(5, 3),
(6, 4),
(7, 5),
(8, 6),
(9, 7),
(10, 8)
ON CONFLICT (town_hall_level) DO NOTHING;

COMMIT;
