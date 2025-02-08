-- Views
-- query is executed every time

-- Creating view
CREATE VIEW myview AS
SELECT 1 AS N1, 2 AS N2;

SELECT *
FROM myview;

-- or

CREATE VIEW tags AS
WITH old_dags AS (SELECT user_id, created_at
                  FROM photo_tags
                  UNION ALL
                  SELECT user_id, created_at
                  FROM comment_tags)
SELECT u.username, COUNT(u.username)
FROM users AS u
         JOIN old_dags AS t ON u.id = t.user_id
WHERE t.created_at > '2015-01-01'
GROUP BY u.username;


SELECT *
FROM tags;

-- or

CREATE VIEW tags AS
SELECT user_id, created_at
FROM photo_tags
UNION ALL
SELECT user_id, created_at
FROM comment_tags;

SELECT u.username, COUNT(u.username)
FROM users AS u
         JOIN tags AS t ON u.id = t.user_id
WHERE t.created_at > '2015-01-01'
GROUP BY u.username;

-- or

CREATE VIEW tags AS
SELECT user_id, created_at, 'photo' AS type
FROM photo_tags
UNION ALL
SELECT user_id, created_at, 'comment' AS type
FROM comment_tags;

SELECT u.username, t.type
FROM users AS u
         JOIN tags AS t ON u.id = t.user_id
WHERE t.type = 'comment';

-- -------------------
-- Changing view
CREATE OR REPLACE VIEW myview AS
SELECT 3 AS N1, 4 AS N2;

SELECT *
FROM myview;

-- -------------------
-- Deleting view
DROP VIEW tags;

