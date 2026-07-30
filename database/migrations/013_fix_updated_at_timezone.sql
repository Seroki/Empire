BEGIN;

-- TIMESTAMP (no timezone) is ambiguous: Postgres writes it in the
-- session's local time, but Node reads it back assuming UTC. This
-- silently corrupted elapsed-time math. TIMESTAMPTZ stores an
-- unambiguous instant and fixes it.

ALTER TABLE city_resources
ALTER COLUMN updated_at TYPE TIMESTAMPTZ
USING updated_at AT TIME ZONE current_setting('TIMEZONE');

ALTER TABLE city_resources
ALTER COLUMN updated_at SET DEFAULT CURRENT_TIMESTAMP;

-- Reset to "right now" cleanly, since the pre-conversion value for
-- our one test row was already thrown off by testing this bug.
UPDATE city_resources SET updated_at = NOW();

COMMIT;
