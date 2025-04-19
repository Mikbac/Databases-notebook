-- Example 1

-- The COALESCE function returns the first of its arguments that is not null.
SELECT COALESCE(NULL, 3, NULL, 6, NULL);
-- 3

-- ---------------------------------------------
-- Example 2

-- Init data
CREATE TABLE users
(
    id       SERIAL PRIMARY KEY,
    username TEXT
);

INSERT INTO users (username)
VALUES
    ('Bob'),
    ('Alice'),
    ('Alice');

-- Create function
CREATE OR REPLACE FUNCTION get_users_number_by_username(provided_username TEXT)
    RETURNS INT
    LANGUAGE plpgsql
AS
$$
DECLARE
    user_count integer;
BEGIN
    SELECT count(*)
    INTO user_count
    FROM users
    WHERE users.username = provided_username;

    return user_count;
END;
$$;

-- Call function
SELECT get_users_number_by_username('Alice');
