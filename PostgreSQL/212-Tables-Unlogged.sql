-- Unlogged table
-- Data written to unlogged tables is not written to the write-ahead log, which makes them considerably faster than ordinary tables.
-- However, they are not crash-safe: an unlogged table is automatically truncated after a crash or unclean shutdown.
--
-- https://www.postgresql.org/docs/current/sql-createtable.html#SQL-CREATETABLE-UNLOGGED
--

CREATE UNLOGGED TABLE users
(
    id   SERIAL PRIMARY KEY,
    username TEXT
);
