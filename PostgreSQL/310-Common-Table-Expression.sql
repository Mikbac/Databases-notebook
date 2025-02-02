-- Common Table Expressions
-- https://www.postgresql.org/docs/current/queries-with.html
-- WITH provides a way to write auxiliary statements for use in a larger query

WITH usernames AS (SELECT users.username
                   FROM users)
SELECT *
FROM usernames;

WITH tags AS (SELECT user_id, created_at
              FROM photo_tags
              UNION ALL
              SELECT user_id, created_at
              FROM comment_tags)
SELECT u.username, COUNT(u.username)
FROM users AS u
         JOIN tags AS t ON u.id = t.user_id
WHERE t.created_at > '2015-01-01'
GROUP BY u.username;

-- ------------------------------
-- Recursive
-- https://www.postgresql.org/docs/current/queries-with.html#QUERIES-WITH-RECURSIVE

WITH RECURSIVE counter(val) AS (VALUES (0) -- initial value
                                UNION ALL
                                SELECT val + 1 -- recursive query
                                FROM counter
                                WHERE val < 5)
SELECT *
FROM counter;

-- or

WITH RECURSIVE counter(val) AS (SELECT 0 AS val -- initial value
                                UNION
                                SELECT val + 1 -- recursive query
                                FROM counter
                                WHERE val < 5)
SELECT *
FROM counter;
-- 0
-- 1
-- 2
-- 3
-- 4
-- 5

-- ---
WITH RECURSIVE t(n) AS (VALUES (1)
                        UNION ALL
                        SELECT n + 1
                        FROM t
                        WHERE n < 100)
SELECT sum(n)
FROM t;
-- 55

-- ---
WITH RECURSIVE sug(lid, fid, dep) AS (SELECT leader_id, follower_id, 1 as dep
                                      FROM followers
                                      WHERE follower_id = 1000
                                      UNION
                                      SELECT leader_id, follower_id, dep + 1
                                      FROM followers
                                               JOIN sug ON sug.lid = followers.follower_id
                                      WHERE dep < 3)
SELECT DISTINCT users.id, users.username
FROM sug
         JOIN users ON users.id = sug.lid
WHERE dep > 1
LIMIT 10;
