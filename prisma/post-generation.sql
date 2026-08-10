-- Constraints Prisma cannot express in schema.prisma.
-- Apply after `prisma migrate dev` — paste into the generated migration.sql,
-- or run once against the database. Without this the integrity model is
-- incomplete: seats can double-book and showtimes can overlap.
--
-- The enum CHECK constraints from the DBML are omitted on purpose: the
-- schema models role/status as native Postgres enum types instead.

CREATE EXTENSION IF NOT EXISTS btree_gist;

-- No overlapping showtimes in the same hall (ignores cancelled shows)
ALTER TABLE showtime
  ADD CONSTRAINT valid_time_range CHECK (end_time > start_time);

ALTER TABLE showtime ADD CONSTRAINT no_overlap_time
  EXCLUDE USING gist (
    hall_id WITH =,
    tstzrange(start_time, end_time) WITH &&
  ) WHERE (status <> 'cancelled');

-- One live ticket per seat per showtime. Cancelled rows are ignored,
-- so the seat is resold without losing history.
CREATE UNIQUE INDEX uq_active_seat
  ON reservation_seat (showtime_id, seat_id) WHERE is_active;

-- Money is never negative
ALTER TABLE showtime         ADD CONSTRAINT chk_base_price CHECK (base_price >= 0);
ALTER TABLE reservation      ADD CONSTRAINT chk_total      CHECK (total_price >= 0);
ALTER TABLE reservation_seat ADD CONSTRAINT chk_price      CHECK (price_at_purchase >= 0);

-- A pending reservation must carry a hold deadline
ALTER TABLE reservation ADD CONSTRAINT chk_hold
  CHECK (status <> 'pending' OR hold_expires_at IS NOT NULL);

-- updated_at does not maintain itself in Postgres.
-- Prisma's @updatedAt only covers writes that go through the client;
-- these triggers cover raw SQL and cleanup jobs too.
CREATE OR REPLACE FUNCTION touch_updated_at() RETURNS trigger AS $$
  BEGIN NEW.updated_at = now(); RETURN NEW; END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_users_touch  BEFORE UPDATE ON users
  FOR EACH ROW EXECUTE FUNCTION touch_updated_at();
CREATE TRIGGER trg_token_touch  BEFORE UPDATE ON refresh_token
  FOR EACH ROW EXECUTE FUNCTION touch_updated_at();
CREATE TRIGGER trg_res_touch    BEFORE UPDATE ON reservation
  FOR EACH ROW EXECUTE FUNCTION touch_updated_at();
