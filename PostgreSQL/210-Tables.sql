-- Example 1
CREATE TABLE tableName1
(
    id      INTEGER PRIMARY KEY,
    name1   TEXT,
    name2   VARCHAR(30),
    name3   TEXT COLLATE "C",
    "naME4" INTEGER,
    "naME5" DATE
);

INSERT INTO tableName1
VALUES (1, 'Diane', 'hamster', 'f', 2, '1999-03-30'),
       (1, 'Diane', 'hamster', 'f', 2, '1999-03-30'),
       (1, 'Diane', 'hamster', 'f', 2, '1999-03-30');

DROP TABLE tableName1;

-- ====================
-- Example 2
-- Keywords - uppercase
-- Identifiers - lowercase
CREATE TABLE cities
(
    name       VARCHAR(50),
    country    VARCHAR(50),
    population INTEGER,
    area       INTEGER
);

INSERT INTO cities (name, country, population, area)
VALUES ('Delhi', 'India', 28125000, 2240),
       ('Shanghai', 'China', 22125000, 4015),
       ('Sao Paulo', 'Brazil', 20935000, 3043);

UPDATE cities
SET population = 30935000
WHERE name = 'Sao Paulo';

DELETE
FROM cities
WHERE name = 'Delhi';

-- ====================
-- Example 3
-- Primary Key - uniquely identifies record  in table
-- Foreign Key - identifies a record (usually in another table); that row is associated with it
CREATE TABLE users
(
    id       SERIAL PRIMARY KEY,
    username VARCHAR(50)
);

INSERT INTO users (username)
VALUES ('aaa'),
       ('bbb'),
       ('ccc'),
       ('ddd');

CREATE TABLE photos
(
    id      SERIAL PRIMARY KEY,
    url     VARCHAR(200),
    user_id INTEGER REFERENCES users (id)
);

INSERT INTO photos (url, user_id)
VALUES ('http://one.jpg', 4),
       ('http://two.jpg', (SELECT id FROM users WHERE username = 'ccc'));

-- or (technically the same)
CREATE TABLE photos
(
    id      SERIAL PRIMARY KEY,
    url     VARCHAR(200),
    user_id INTEGER,
    CONSTRAINT fk_users_user FOREIGN KEY (user_id) REFERENCES users (id)
);

INSERT INTO photos (url, user_id)
VALUES ('http://one.jpg', 4);

-- ====================
-- Example 4
-- https://www.postgresql.org/docs/current/ddl-constraints.html
-- ON DELETE RESTRICT
-- ON DELETE NO ACTION
-- ON DELETE CASCADE
-- ON DELETE SET NULL
-- ON DELETE SET DEFAULT

CREATE TABLE photos
(
    id      SERIAL PRIMARY KEY,
    url     VARCHAR(200),
    user_id INTEGER REFERENCES users (id) ON DELETE RESTRICT
);
-- test:
DELETE
FROM users
WHERE username = 'aaa';
SELECT *
FROM photos;

CREATE TABLE photos
(
    id      SERIAL PRIMARY KEY,
    url     VARCHAR(200),
    user_id INTEGER REFERENCES users (id) ON DELETE CASCADE
);
-- test:
DELETE
FROM users
WHERE username = 'aaa';
SELECT *
FROM photos;

CREATE TABLE photos
(
    id      SERIAL PRIMARY KEY,
    url     VARCHAR(200),
    user_id INTEGER REFERENCES users (id) ON DELETE SET NULL
);
-- test:
DELETE
FROM users
WHERE username = 'aaa';
SELECT *
FROM photos;

-- ====================
-- Example 5

-- One-to-Many / Many-to-One
-- A user has many photos. | Company has many employee.

CREATE TABLE users
(
    id   INTEGER PRIMARY KEY,
    name TEXT
);

CREATE TABLE photos
(
    id      INTEGER PRIMARY KEY,
    user_id INTEGER REFERENCES users (id)
);

-- One-to-One
-- Company - CEO

CREATE TABLE ceo
(
    id    INTEGER PRIMARY KEY,
    name  VARCHAR(100),
    email text
);

CREATE TABLE company
(
    employee_id INTEGER REFERENCES ceo (id) UNIQUE
);

-- Many-to-Many
-- Tasks - Engineers | Movies - Actors

CREATE TABLE tasks
(
    id   INTEGER PRIMARY KEY,
    name VARCHAR(100)
);

CREATE TABLE engineers
(
    id   INTEGER PRIMARY KEY,
    name VARCHAR(100)
);

CREATE TABLE tasks_engineers
(
    task_id     INTEGER REFERENCES tasks (id),
    engineer_id INTEGER REFERENCES engineers (id),
    PRIMARY KEY (task_id, engineer_id)
);

-- ====================
-- Example 6

-- The optional ON CONFLICT clause specifies an alternative action to raising a unique violation or
-- exclusion constraint violation error.

CREATE TABLE users
(
    id      INTEGER PRIMARY KEY,
    name   TEXT
);

INSERT INTO users (id, name)
VALUES
    (1, 'Alice'),
    (1, 'Bob')
ON CONFLICT (id) DO NOTHING;
