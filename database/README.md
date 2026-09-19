# Database Setup

## Source of truth
Run these two files, in order, against a fresh database:

1. `schema.sql` — creates all tables (players, cities, city_resources,
   building_types, building_levels, city_buildings, construction_queue)
2. `seed.sql` — inserts the Town Hall building type and its first 3 levels

```bash
psql -h <host> -U <user> -d <dbname> -f schema.sql
psql -h <host> -U <user> -d <dbname> -f seed.sql
```

With Docker Compose (from the project root):
```bash
docker-compose up -d
docker exec -i empire-db psql -U empire -d empire < database/schema.sql
docker exec -i empire-db psql -U empire -d empire < database/seed.sql
```

## What's in `_archived_conflicting_schemas/`
`buildings.sql` and `001_building_refactor.sql` were earlier, incompatible
attempts at the buildings table design. They define a different
`building_types` table (flat base_food/wood/stone/iron columns, no leveling)
that conflicts with the `building_types` + `building_levels` design in
`schema.sql`, which is what the actual server code
(`building.service.js`, `player.service.js`, `city.service.js`) queries.

Running either archived file against the current schema will fail or leave
the database in a shape the app can't use. They're kept only for reference
— don't run them. Safe to delete once you're confident you don't need them.

## Note on seed data
`seed.sql` only defines Town Hall levels 1–3, but `building_types.max_level`
is set to 10 for Town Hall. Trying to upgrade past level 3 will currently
throw "Maximum level reached" (not a bug — just missing level data). Add
more rows to `building_levels` for levels 4–10 when you're ready to expand
the building's progression.
