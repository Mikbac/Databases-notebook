-- Subquery in SELECT (subquery results should always be one value)
SELECT name, (SELECT count(*) FROM products)
FROM products;

SELECT name, price, price / (SELECT MAX(price) FROM phones) AS price_ratio
FROM phones;

-- ====================
-- Subquery in FROM (alias (AS) is required)
SELECT p.name, p.price
FROM (SELECT * FROM products WHERE department = 'Toys') AS p;

SELECT p.name, p.pri
FROM (SELECT name, price AS pri FROM products WHERE department = 'Toys') AS p;

-- highest average price
SELECT MAX(pap.avg_price) AS max_average_price
FROM (SELECT AVG(price) AS avg_price
      FROM phones
      GROUP BY manufacturer) AS pap;

-- ====================
-- Subquery in JOIN
SELECT first_name, last_name, uo.user_orders
FROM users
         JOIN (SELECT user_id, COUNT(*) AS user_orders
               FROM orders
               GROUP BY user_id) AS uo
              ON uo.user_id = users.id;

-- ====================
-- Subquery in WHERE
SELECT name, price
FROM products
WHERE price > (SELECT MAX(price)
               FROM products
               WHERE department = 'Toys')

SELECT id
FROM orders
WHERE product_id IN (SELECT id
                     FROM products
                     WHERE price / weight > 20);

SELECT id, name, price
FROM products
WHERE products.price > (SELECT AVG(price)
                        FROM products);

SELECT name, price
FROM phones
WHERE price > (SELECT price
               FROM phones
               WHERE name = 'S5620 Monte'
                 AND manufacturer = 'Samsung');
