-- UNION effectively appends the result of query2 to the result of query1
-- combination two selects (remove duplicates)
(SELECT *
 FROM products
 ORDER BY price DESC
 LIMIT 5)
UNION
(SELECT *
 FROM products
 ORDER BY price / weight DESC
 LIMIT 5);

(SELECT manufacturer
 FROM phones
 WHERE price < 170)
UNION
(SELECT manufacturer
 FROM phones
 GROUP BY manufacturer
 HAVING count(*) > 2);

(SELECT name, department
 FROM products)
UNION
(SELECT first_name, last_name
 FROM users);

-- combination two selects (keeps duplicates)
(SELECT *
 FROM products
 ORDER BY price DESC
 LIMIT 5)
UNION ALL
(SELECT *
 FROM products
 ORDER BY price / weight DESC
 LIMIT 5);

-- example
SELECT u.username, COUNT(u.username)
FROM users AS u
         JOIN
     (SELECT user_id, created_at
      FROM photo_tags
      UNION ALL
      SELECT user_id, created_at
      FROM comment_tags) AS t ON u.id = t.user_id
WHERE t.created_at > '2015-01-01'
GROUP BY u.username;
