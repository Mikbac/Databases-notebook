-- Sequence
-- https://www.postgresql.org/docs/current/sql-createsequence.html
-- CREATE SEQUENCE creates a new sequence number generator.

-- Creating a sequence
CREATE SEQUENCE newSequence START 222;
-- or
CREATE SEQUENCE newSequence INCREMENT BY 10;

-- --------------------------------------------
-- Example
CREATE SEQUENCE seq_users INCREMENT BY 15 START 100;

CREATE TABLE users
(
    id       INT PRIMARY KEY DEFAULT nextval('seq_users'),
    username TEXT
);

-- or
-- CREATE SEQUENCE seq_users
--     INCREMENT BY 15
--     START 100
--     OWNED BY users.user_id;

SELECT nextval('seq_users');
-- -- +---+
-- -- |100|
-- -- +---+

INSERT INTO users (username)
VALUES
    ('Bob'),
    ('Alice');

SELECT *
FROM users;
-- +---+--------+
-- |id |username|
-- +---+--------+
-- |115|Bob     |
-- |130|Alice   |
-- +---+--------+
