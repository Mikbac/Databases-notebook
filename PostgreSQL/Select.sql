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
