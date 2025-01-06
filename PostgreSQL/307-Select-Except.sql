-- EXCEPT returns all rows that are in the result of query1 but not in the result of query2.
-- EXCEPT - remove duplicates (remove duplicates only from the same SELECT)
(SELECT *
 FROM products
 ORDER BY price DESC
 LIMIT 5)
EXCEPT
(SELECT *
 FROM products
 ORDER BY price / weight DESC
 LIMIT 5);
-- EXCEPT - keeps duplicates from the same SELECT
(SELECT *
 FROM products
 ORDER BY price DESC
 LIMIT 5)
EXCEPT ALL
(SELECT *
 FROM products
 ORDER BY price / weight DESC
 LIMIT 5);
