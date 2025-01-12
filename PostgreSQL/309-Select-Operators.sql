-- Init BD
CREATE TABLE users
(
    id       SERIAL PRIMARY KEY,
    username TEXT
);

CREATE TABLE cars
(
    id      SERIAL PRIMARY KEY,
    brand   TEXT,
    price   INTEGER,
    user_id INTEGER REFERENCES users (id) ON DELETE CASCADE
);


INSERT INTO users (username)
VALUES
    ('Bob'),
    ('Alice');

INSERT INTO cars (brand, price, user_id)
VALUES
    ('Dacia', 100, 1),
    ('Renault', 110, 1),
    ('Dacia', 120, 1),
    ('Dacia', 130, 1),
    ('Renault', 150, 2),
    ('Mazda', 200, 2);


-- ====================
-- >
-- >=
-- > ALL
-- > ANY or > SOME
-- <
-- <=
-- < ALL
-- < ANY or < SOME

-- price is the highest of ALL Dacia prices (in this case, the highest Dacia 130 price)
SELECT brand, price
FROM cars
WHERE price > ANY (SELECT price
                   FROM cars
                   WHERE brand = 'Dacia');
-- +-------+-----+
-- |brand  |price|
-- +-------+-----+
-- |Renault|150  |
-- |Mazda  |200  |
-- +-------+-----+

-- price is the highest of SOME/ANY Dacia price (in this case, the lowest Dacia 100 price)
SELECT brand, price
FROM cars
WHERE price > SOME (SELECT price
                    FROM cars
                    WHERE brand = 'Dacia');

-- +-------+-----+
-- |brand  |price|
-- +-------+-----+
-- |Renault|110  |
-- |Dacia  |120  |
-- |Dacia  |130  |
-- |Renault|150  |
-- |Mazda  |200  |
-- +-------+-----+

-- ====================
-- =
-- = ANY or = SOME
-- = ALL
-- <> or !=

SELECT brand, price
FROM cars
WHERE price = ALL (SELECT price
                   FROM cars
                   WHERE brand = 'Dacia');

-- +-----+-----+
-- |brand|price|
-- +-----+-----+

SELECT brand, price
FROM cars
WHERE price = ANY (SELECT price
                   FROM cars
                   WHERE brand = 'Dacia');

-- +-----+-----+
-- |brand|price|
-- +-----+-----+
-- |Dacia|100  |
-- |Dacia|120  |
-- |Dacia|130  |
-- +-----+-----+

SELECT brand, price
FROM cars
WHERE brand = 'Dacia';

SELECT brand, price
FROM cars
WHERE brand <> 'Dacia';

-- ====================
-- IN
-- NOT IN

SELECT brand, price
FROM cars
WHERE brand IN ('Dacia', 'Renault');

SELECT brand, price
FROM cars
WHERE brand NOT IN ('Dacia', 'Renault');

-- ====================
-- LIKE
-- NOT LIKE
-- https://www.postgresql.org/docs/current/functions-matching.html#FUNCTIONS-LIKE
--  an underscore  in pattern stands for (matches) any single character
--  a percent sign (%) matches any sequence of zero or more characters

SELECT brand, price
FROM cars
WHERE brand LIKE '%cia';

-- +-----+-----+
-- |brand|price|
-- +-----+-----+
-- |Dacia|100  |
-- |Dacia|120  |
-- |Dacia|130  |
-- +-----+-----+

SELECT brand, price
FROM cars
WHERE brand LIKE '_acia_';

-- +-----+-----+
-- |brand|price|
-- +-----+-----+

SELECT brand, price
FROM cars
WHERE brand LIKE '_acia';

-- +-----+-----+
-- |brand|price|
-- +-----+-----+
-- |Dacia|100  |
-- |Dacia|120  |
-- |Dacia|130  |
-- +-----+-----+

-- ====================
-- ~ (pattern matching)
-- https://www.postgresql.org/docs/current/functions-matching.html#FUNCTIONS-POSIX-REGEXP
-- 'abcd' ~ 'bc'     true
-- 'abcd' ~ 'a.c'    true — dot matches any character
-- 'abcd' ~ 'a.*d'   true — * repeats the preceding pattern item
-- 'abcd' ~ '(b|x)'  true — | means OR, parentheses group
-- 'abcd' ~ '^a'     true — ^ anchors to start of string
-- 'abcd' ~ '^(b|c)' false — would match except for anchoring

SELECT brand, price
FROM cars
WHERE brand ~ 'ci';

-- +-----+-----+
-- |brand|price|
-- +-----+-----+
-- |Dacia|100  |
-- |Dacia|120  |
-- |Dacia|130  |
-- +-----+-----+

SELECT brand, price
FROM cars
WHERE brand ~ 'D.*a';

-- +-----+-----+
-- |brand|price|
-- +-----+-----+
-- |Dacia|100  |
-- |Dacia|120  |
-- |Dacia|130  |
-- +-----+-----+

-- ====================
-- SIMILAR TO
--  _ and % as wildcard characters denoting any single character and any string, respectively
-- 'abc' SIMILAR TO 'abc'          true
-- 'abc' SIMILAR TO 'a'            false
-- 'abc' SIMILAR TO '%(b|d)%'      true
-- 'abc' SIMILAR TO '(b|c)%'       false
-- '-abc-' SIMILAR TO '%\mabc\M%'  true
-- 'xabcy' SIMILAR TO '%\mabc\M%'  false

SELECT brand, price
FROM cars
WHERE brand SIMILAR TO '%ci_';

-- +-----+-----+
-- |brand|price|
-- +-----+-----+
-- |Dacia|100  |
-- |Dacia|120  |
-- |Dacia|130  |
-- +-----+-----+
