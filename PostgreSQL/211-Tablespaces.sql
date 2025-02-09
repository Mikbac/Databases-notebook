-- Tablespaces
-- https://www.postgresql.org/docs/current/manage-ag-tablespaces.html
--
-- Tablespaces in PostgreSQL allow database administrators to define locations in the file system where
-- the files representing database objects can be stored. Once created,
-- a tablespace can be referred to by name when creating database objects.

-- Tablespaces list
\db

-- New tablespace
CREATE TABLESPACE tablespaceName LOCATION '/var/abd/path';

-- Create database in tablespace
CREATE DATABASE databaseName
    OWNER userName
    TABLESPACE tablespaceName;

-- Set permissions
GRANT CREATE ON TABLESPACE tablespaceName TO userName;

-- Create table in tablespace
CREATE TABLE tableName
(
    id  INT,
    url TEXT
) TABLESPACE tablespaceName;

-- Remove tablespace
DROP TABLESPACE tablespaceName;
