-- Standard indexes
-- https://www.postgresql.org/docs/current/indexes.html
-- Indexes are a common way to enhance database performance.
-- An index allows the database server to find and retrieve specific rows much faster than it could do
-- without an index. But indexes also add overhead to the database system as a whole,
-- so they should be used sensibly.
--
-- Postgres automatically creates an index for:
-- * primary key column
-- * for any UNIQUE constraints
--
-- Downsides:
-- * requires additional disk space
-- * slows down insert/update/delete
-- * may not be used in some cases (some queries run faster without the index)
--
-- Index types:
-- * B-Tree - general purpose (default)
-- * Hash - speeds uup simple equality comparisons
-- * GiST - recommended for full-text search
-- * SP-GiST - recommended for clustered data
-- * GIN - appropriate for data values that contain multiple component values, such as arrays (recommended e.g. for json)
-- * BRIN - most effective for columns whose values are well-correlated with the physical order of the table rows (recommended fo large datasets)

-- -----------------------------------
-- get all indexes (alco created automatically)
SELECT relname, relkind
FROM pg_class
WHERE relkind = 'i';

-- -----------------------------------
-- get index metadata
CREATE EXTENSION pageinspect;

SELECT *
FROM bt_metap('idx_users_username');

SELECT *
FROM bt_page_items('idx_users_username', 3);
-- 4 <- page

-- -----------------------------------
-- get ctid (block, index) -> 901-Data-Storage.sql
SELECT ctid, *
FROM table_name
WHERE user = 'aaa';

-- -----------------------------------
-- create index
CREATE INDEX ON users (username);
-- creates index "users_username_idx"
-- or
CREATE INDEX idx_users_username
    ON users (username);
-- creates index "idx_users_username"

-- -----------------------------------
-- remove index
DROP INDEX users_username_idx;

-- -----------------------------------
-- get indexes
