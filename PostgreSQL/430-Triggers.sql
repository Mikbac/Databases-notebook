-- Trigger

-- https://www.postgresql.org/docs/current/sql-createtrigger.html

-- Drop trigger

DROP TRIGGER "trigger_name" ON "table_name";

-- ---------------------------------------------
-- Example 1

-- Init table
CREATE TABLE users
(
    id       SERIAL PRIMARY KEY,
    username TEXT
);

CREATE TABLE users_log
(
    id           SERIAL PRIMARY KEY,
    user_id      INT,
    old_username TEXT,
    new_username TEXT,
    updated_at   TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- Create function
CREATE OR REPLACE FUNCTION update_user_log()
    RETURNS trigger
    LANGUAGE plpgsql
AS
$$
BEGIN
    insert into users_log(user_id, old_username, new_username)
    values (old.id, old.username, new.username);
    return new;
END;
$$;

-- Create trigger
CREATE TRIGGER check_insect
    BEFORE UPDATE
    ON users
    FOR EACH ROW
EXECUTE FUNCTION update_user_log();

-- Insert to table
UPDATE users
SET username = 'Boby'
WHERE id = 2;

-- Check
SELECT *
FROM users_log;

-- +--+-------+------------+------------+---------------------------------+
-- |id|user_id|old_username|new_username|updated_at                       |
-- +--+-------+------------+------------+---------------------------------+
-- |1 |2      |Alice       |Boby        |2025-04-19 19:48:06.644542 +00:00|
-- +--+-------+------------+------------+---------------------------------+
