-- Reindex
-- https://www.postgresql.org/docs/current/sql-reindex.html
-- REINDEX rebuilds an index using the data stored in the index's table, replacing the old copy of the index.

-- rebuild single index
REINDEX INDEX idx_users_username;

-- rebuild all the indexes on the table
REINDEX TABLE users;

-- rebuild all indexes in a particular database
REINDEX DATABASE test_db;
