-- Init BD
CREATE TABLE users
(
    id       SERIAL PRIMARY KEY,
    username VARCHAR(50)
);

CREATE TABLE cars
(
    id      SERIAL PRIMARY KEY,
    brand   VARCHAR(200),
    user_id INTEGER REFERENCES users (id) ON DELETE CASCADE
);


INSERT INTO users (username)
VALUES
    ('Bob'),
    ('Alice');

INSERT INTO cars (brand, user_id)
VALUES
    ('Renault', 1),
    ('Infiniti', null);

-- Inner Join
SELECT username, brand
FROM users
         JOIN cars ON cars.user_id = users.id;
-- +--------+-------+
-- |username|brand  |
-- +--------+-------+
-- |Bob     |Renault|
-- +--------+-------+

-- Left Outer Join
SELECT username, brand
FROM users
         LEFT JOIN cars ON cars.user_id = users.id;
-- +--------+-------+
-- |username|brand  |
-- +--------+-------+
-- |Bob     |Renault|
-- |Alice   |null   |
-- +--------+-------+

-- Right Outer Join
SELECT username, brand
FROM users
         RIGHT JOIN cars ON cars.user_id = users.id;
-- +--------+--------+
-- |username|brand   |
-- +--------+--------+
-- |Bob     |Renault |
-- |null    |Infiniti|
-- +--------+--------+

-- Full Join
SELECT username, brand
FROM users
         FULL JOIN cars ON cars.user_id = users.id;
-- +--------+--------+
-- |username|brand   |
-- +--------+--------+
-- |Bob     |Renault |
-- |Alice   |null    |
-- |null    |Infiniti|
-- +--------+--------+
