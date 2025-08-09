-- Reindex
-- https://www.postgresql.org/docs/current/sql-reindex.html
-- REINDEX rebuilds an index using the data stored in the index's table, replacing the old copy of the index.

-- rebuild single index
REINDEX INDEX idx_users_username;

-- rebuild all the indexes on the table
REINDEX TABLE users;

-- rebuild all indexes in a particular database
REINDEX DATABASE test_db;

-- rebuild the index without taking any locks that prevent concurrent inserts, updates, or deletes on the table;
-- whereas a standard index rebuild locks out writes (but not reads) on the table until it's done
REINDEX INDEX CONCURRENTLY index_name;
