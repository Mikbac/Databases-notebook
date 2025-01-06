-- from lowest to highest

SELECT *
FROM products
ORDER BY price;

SELECT *
FROM products
ORDER BY price ASC;

-- from highest to lowest

SELECT *
FROM products
ORDER BY price DESC;

-- if products have the same price check weight

SELECT *
FROM products
ORDER BY price, weight;

-- OFFSET - skip first n elements
-- LIMIT - get n first elements

SELECT *
FROM products
OFFSET 40;

SELECT *
FROM products
LIMIT 10;

-- pagination
SELECT *
FROM products
ORDER BY price
LIMIT 10
    OFFSET 40;

-- second and third most expensive phones
SELECT name
FROM phones
ORDER BY price DESC
LIMIT 2
    OFFSET 1;
