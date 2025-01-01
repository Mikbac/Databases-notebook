SELECT *
FROM pet
WHERE name LIKE '%e_';
-- Bowser, Whistler

-- ====================

SELECT *
FROM pet
WHERE name ~ '^.*(g|s)$';
-- Claws, Fang

-- ====================

SELECT *
FROM pet
WHERE name SIMILAR TO '%(l|p)_';
-- Chirpy, Puffball

-- ====================
-- Password validity
SELECT (CASE WHEN valuntil >= NOW() THEN 't' ELSE 'f' END) AS "valid"
FROM pg_user
WHERE usename = 'userName';

-- ====================
-- Limits for userName1 and userName2
SELECT rolname, rolconnlimit
FROM pg_roles
WHERE rolname SIMILAR TO 'userName1|userName2';

-- ====================
-- Mathematical operators
-- https://www.postgresql.org/docs/current/functions-math.html
SELECT name, population / area AS population_density
FROM cities

-- ====================
-- String operators
-- https://www.postgresql.org/docs/9.1/functions-string.html
SELECT name || country AS location
FROM cities

SELECT UPPER(CONCAT(name, ', ', country)) AS location
FROM cities

-- ====================
-- Comparison operators
-- https://www.postgresql.org/docs/current/functions-comparison.html
SELECT name, country, area
FROM cities
WHERE area BETWEEN 4000 AND 5000;

SELECT name, country
FROM cities
WHERE name IN ('Delhi', 'Shanghai');

SELECT name, country
FROM cities
WHERE name NOT IN ('Delhi', 'Shanghai');

SELECT name, population / area AS population_density
FROM cities
WHERE population / area > 6000;
