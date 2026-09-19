BEGIN;

INSERT INTO building_types (id, name, category, max_level, description) VALUES
(2,  'Keep',           'Core',           10, 'Defensive command center; determines wall durability and garrison capacity.'),
(3,  'Walls',           'Core',           10, 'City perimeter defense; increases fortification slots and defense bonuses.'),
(4,  'Gate',            'Core',           10, 'Controls whether troops defend or hide during attacks.'),
(5,  'Farm',            'Economy',        10, 'Produces food; required for troop upkeep.'),
(6,  'Sawmill',         'Economy',        10, 'Produces lumber; used for construction.'),
(7,  'Quarry',          'Economy',        10, 'Produces stone; used for walls and heavy structures.'),
(8,  'Iron Mine',       'Economy',        10, 'Produces iron; used for advanced troops and buildings.'),
(9,  'Gold Mine',       'Economy',        10, 'Produces gold; used for research and heroes.'),
(10, 'Cottage',         'Infrastructure', 10, 'Increases population and worker availability.'),
(11, 'Warehouse',       'Infrastructure', 10, 'Protects resources from plunder.'),
(12, 'Market',          'Infrastructure', 10, 'Enables resource trading with other players or NPC merchants.'),
(13, 'Barracks',        'Military',       10, 'Trains infantry, cavalry, archers, siege units.'),
(14, 'Stable',          'Military',       10, 'Trains mounted units; increases cavalry speed.'),
(15, 'Workshop',        'Military',       10, 'Builds siege engines and traps.'),
(16, 'Forge',           'Military',       10, 'Produces weapons and armor; unlocks advanced troop tiers.'),
(17, 'Beacon Tower',    'Military',       10, 'Provides scouting reports and early warnings of enemy attacks.'),
(18, 'Academy',         'Research',       10, 'Researches technologies for economy, military, and logistics.'),
(19, 'Embassy',         'Research',       10, 'Allows alliances, reinforcements, and coalition defense.'),
(20, 'Inn',             'Research',       10, 'Recruits heroes with random stats.'),
(21, 'Feasting Hall',   'Research',       10, 'Houses heroes; increases hero capacity.'),
(22, 'Trap Factory',    'Defense',        10, 'Builds traps for walls (spikes, abatis, rolling logs).'),
(23, 'Archer Tower',    'Defense',        10, 'Automated defense structure that fires on attackers.'),
(24, 'Relief Station',  'Optional',       10, 'Boosts troop movement speed.'),
(25, 'Hospital',        'Optional',       10, 'Heals wounded troops instead of losing them permanently.');

SELECT setval(
    pg_get_serial_sequence('building_types', 'id'),
    (SELECT MAX(id) FROM building_types)
);

COMMIT;
