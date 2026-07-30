BEGIN;

ALTER TABLE building_types
ADD COLUMN IF NOT EXISTS unlock_th_level INTEGER;

-- Buildings confirmed as available at Town Hall level 1
UPDATE building_types
SET unlock_th_level = 1
WHERE id IN (
    1,  -- Town Hall
    2,  -- Keep
    3,  -- Walls
    4,  -- Gate
    5,  -- Farm
    6,  -- Sawmill
    7,  -- Quarry
    8,  -- Iron Mine
    10, -- Cottage
    11, -- Warehouse
    13, -- Barracks
    17, -- Beacon Tower
    20, -- Inn
    21  -- Feasting Hall
);

-- Everything else (Gold Mine, Market, Academy, Stable, Forge, Workshop,
-- Embassy, Relief Station, Trap Factory, Archer Tower, Hospital) stays
-- unlock_th_level = NULL until you decide those levels.

COMMIT;
