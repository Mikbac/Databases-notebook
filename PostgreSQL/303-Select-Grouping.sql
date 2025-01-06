-- Aggregate Functions
-- https://www.postgresql.org/docs/current/functions-aggregate.html

-- avg ( numeric  ) → numeric
-- max ( see text ) → same as input type
-- min ( see text ) → same as input type
-- sum ( numeric ) → numeric
-- count ( * ) → bigint
-- https://www.postgresql.org/docs/current/functions-aggregate.html#FUNCTIONS-AGGREGATE-TABLE

SELECT MAX(user_id)
FROM comments;
-- +---+
-- |max|
-- +---+
-- |5  |
-- +---+

SELECT COUNT(*)
FROM photos;

SELECT user_id, count(contents)
FROM comments
GROUP BY user_id;
-- +-------+-----+
-- |user_id|count|
-- +-------+-----+
-- |1      |23   |
-- |3      |17   |
-- |5      |20   |
-- |4      |22   |
-- |2      |18   |
-- +-------+-----+

SELECT photo_id, COUNT(*)
FROM comments
GROUP BY photo_id;

SELECT authors.name, COUNT(*)
FROM books
         JOIN authors ON authors.id = books.author_id
GROUP BY authors.name;

SELECT photo_id, COUNT(*)
FROM comments
WHERE photo_id < 3
GROUP BY photo_id
HAVING COUNT(*) > 2;

SELECT manufacturer, SUM(price * units_sold)
FROM phones
GROUP BY manufacturer
HAVING SUM(price * units_sold) > 2000000;

