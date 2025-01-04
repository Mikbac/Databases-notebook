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
