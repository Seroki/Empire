CREATE TABLE building_types (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50) UNIQUE NOT NULL,

    base_food INTEGER NOT NULL,
    base_wood INTEGER NOT NULL,
    base_stone INTEGER NOT NULL,
    base_iron INTEGER NOT NULL,

    base_time INTEGER NOT NULL
);

INSERT INTO building_types
(name, base_food, base_wood, base_stone, base_iron, base_time)

VALUES

('Town Hall',200,200,200,200,60),
('Farm',100,50,20,0,30),
('Lumber Mill',50,100,20,0,30),
('Quarry',50,50,100,0,30),
('Iron Mine',50,50,20,100,30),
('Barracks',250,250,100,50,90);
