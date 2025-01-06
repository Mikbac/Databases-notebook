SELECT *
FROM pet
WHERE name LIKE '%e_';
-- Bowser, Whistler

-- ====================
-- Pattern matching
-- https://www.postgresql.org/docs/current/functions-matching.html#FUNCTIONS-POSIX-REGEXP
-- 'abcd' ~ 'bc'     true
-- 'abcd' ~ 'a.c'    true — dot matches any character
-- 'abcd' ~ 'a.*d'   true — * repeats the preceding pattern item
-- 'abcd' ~ '(b|x)'  true — | means OR, parentheses group
-- 'abcd' ~ '^a'     true — ^ anchors to start of string
-- 'abcd' ~ '^(b|c)' false — would match except for anchoring
SELECT *
FROM pet
WHERE name ~ '^.*(g|s)$';
-- Claws, Fang

-- ====================
-- SIMILAR TO operator returns true or false depending on whether its pattern matches the given string
SELECT *
FROM pet
WHERE name SIMILAR TO '%(l|p)_';
-- Chirpy, Puffball

-- ====================
-- Removes duplicate rows from a result set
SELECT DISTINCT name
FROM pet;

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
FROM cities;

-- ====================
-- String operators
-- https://www.postgresql.org/docs/9.1/functions-string.html
SELECT name || country AS location
FROM cities;

SELECT UPPER(CONCAT(name, ', ', country)) AS location
FROM cities;

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
