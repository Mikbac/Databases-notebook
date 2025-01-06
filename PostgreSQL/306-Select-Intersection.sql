-- INTERSECT returns all rows that are both in the result of query1 and in the result of query2.
-- Duplicate rows are eliminated unless INTERSECT ALL is used.
-- INTERSECT - remove duplicates (remove duplicates only from the same SELECT)
(SELECT *
 FROM products
 ORDER BY price DESC
 LIMIT 5)
INTERSECT
(SELECT *
 FROM products
 ORDER BY price / weight DESC
 LIMIT 5);
-- INTERSECT - keeps duplicates from the same SELECT
(SELECT *
 FROM products
 ORDER BY price DESC
 LIMIT 5)
INTERSECT ALL
(SELECT *
 FROM products
 ORDER BY price / weight DESC
 LIMIT 5);
