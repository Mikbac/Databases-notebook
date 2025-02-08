-- Materialized views
-- https://www.postgresql.org/docs/current/rules-materializedviews.html
-- Physical copy of the base table.
-- Query is executed only at specific time and results are saved.

-- Creating view
CREATE MATERIALIZED VIEW mymatview1 AS
(
SELECT 1 AS N1, 2 AS N2)
WITH DATA;

SELECT *
FROM mymatview1;
-- WITH DATA - load data into the materialized view at the creation time

CREATE MATERIALIZED VIEW mymatview2 AS
(
SELECT 1 AS N1, 2 AS N2);

SELECT *
FROM mymatview2;

-- -------------------
-- Refreshing view
REFRESH MATERIALIZED VIEW mymatview2;

-- -------------------
-- Deleting view
DROP MATERIALIZED VIEW mymatview2;

-- -------------------
-- Example

CREATE TABLE sample_table
(
    id       SERIAL PRIMARY KEY,
    username TEXT
);

INSERT INTO sample_table(username)
VALUES ('aaa');

CREATE MATERIALIZED VIEW sample_materialized_view AS
(
SELECT * FROM sample_table)
WITH DATA;

SELECT * FROM sample_materialized_view;
-- +--+--------+
-- |id|username|
-- +--+--------+
-- |1 |aaa     |
-- +--+--------+

INSERT INTO sample_table(username)
VALUES ('bbb');

SELECT * FROM sample_materialized_view;
-- +--+--------+
-- |id|username|
-- +--+--------+
-- |1 |aaa     |
-- +--+--------+

REFRESH MATERIALIZED VIEW sample_materialized_view;

SELECT * FROM sample_materialized_view;
-- +--+--------+
-- |id|username|
-- +--+--------+
-- |1 |aaa     |
-- |2 |bbb     |
-- +--+--------+
