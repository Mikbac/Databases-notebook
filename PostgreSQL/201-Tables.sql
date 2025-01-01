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
VALUES
    (1, 'Diane', 'hamster', 'f', 2, '1999-03-30'),
    (1, 'Diane', 'hamster', 'f', 2, '1999-03-30'),
    (1, 'Diane', 'hamster', 'f', 2, '1999-03-30');

DROP TABLE tableName1;

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
VALUES
    ('Delhi', 'India', 28125000, 2240),
    ('Shanghai', 'China', 22125000, 4015),
    ('Sao Paulo', 'Brazil', 20935000, 3043);

UPDATE cities
SET population = 30935000
WHERE name = 'Sao Paulo';

DELETE FROM cities
WHERE name = 'Delhi';

-- Example 3
-- Primary Key - uniquely identifies record  in table
-- Foreign Key - identifies a record (usually in another table); that row is associated with it

-- Example 4

-- One-to-Many / Many-to-One
-- A user has many photos. | Company has many employee.


-- One-to-One
-- Company - CEO

-- Many-to-Many
-- Tasks - Engineers | Movies - Actors
