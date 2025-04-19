-- Collation 
-- https://www.postgresql.org/docs/current/collation.html
-- The collation feature allows specifying the sort order and character classification behavior of data per-column,
-- or even per-operation.
-- A collation is an SQL schema object that maps an SQL name to locales provided by libraries installed in the operating system.

SELECT *
FROM names
ORDER by name
             COLLATE "pl-PL-x-icu";

-- Change collocation
ALTER TABLE names
    ALTER COLUMN name
        SET DATA TYPE text
        COLLATE "pl-PL-x-icu";

-- --------------------------------------------
-- Example
