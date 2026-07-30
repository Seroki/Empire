INSERT INTO building_types
(name, category, max_level, description)

VALUES

(
'Town Hall',
'Core',
10,
'The heart of every city.'
);

INSERT INTO building_levels
(
building_type_id,
level,

food_cost,
wood_cost,
stone_cost,
iron_cost,
gold_cost,

build_seconds
)

VALUES

(1,1,0,0,0,0,0,0),

(1,2,500,500,500,500,0,60),

(1,3,1000,1000,1000,1000,0,120);
