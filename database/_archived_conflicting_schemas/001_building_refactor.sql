BEGIN;

-- Master list of building definitions
CREATE TABLE IF NOT EXISTS building_types (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50) UNIQUE NOT NULL,

    base_food INTEGER NOT NULL,
    base_wood INTEGER NOT NULL,
    base_stone INTEGER NOT NULL,
    base_iron INTEGER NOT NULL,

    build_time INTEGER NOT NULL
);

INSERT INTO building_types
(name, base_food, base_wood, base_stone, base_iron, build_time)

VALUES
('Town Hall',200,200,200,200,60),
('Farm',100,50,20,0,30),
('Lumber Mill',50,100,20,0,30),
('Quarry',50,50,100,0,30),
('Iron Mine',50,50,20,100,0),
('Barracks',250,250,100,50,90)

ON CONFLICT(name) DO NOTHING;

ALTER TABLE city_buildings
ADD COLUMN IF NOT EXISTS building_type_id INTEGER;

ALTER TABLE city_buildings
ADD COLUMN IF NOT EXISTS position_x INTEGER DEFAULT 0;

ALTER TABLE city_buildings
ADD COLUMN IF NOT EXISTS position_y INTEGER DEFAULT 0;

UPDATE city_buildings cb
SET building_type_id = bt.id
FROM building_types bt
WHERE cb.building_type = bt.name;

ALTER TABLE city_buildings
ALTER COLUMN building_type_id SET NOT NULL;

ALTER TABLE city_buildings
ADD CONSTRAINT fk_building_type
FOREIGN KEY(building_type_id)
REFERENCES building_types(id);

ALTER TABLE city_buildings
DROP COLUMN building_type;

COMMIT;
