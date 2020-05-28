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