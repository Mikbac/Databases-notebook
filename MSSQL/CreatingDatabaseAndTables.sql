-- Create database
CREATE DATABASE test;
CREATE DATABASE test COLLATE Polish_100_CS_AS;

-- Using database
USE test;

-- Current database
SELECT DB_NAME();

-- New table
-- VARCHAR - does not use unicode
-- NVARCHAR - uses unicode
CREATE TABLE people
(
    id      INT,
    name    NVARCHAR(200),
    surname VARCHAR(200)
);
CREATE TABLE self_isolations
(
    personId  INT,
    startDate DATE,
    endDate   DATE
);
CREATE TABLE producers
(
    id      INT,
    name    VARCHAR(200) COLLATE Latin1_General_100_CS_AS_SC,
    address VARCHAR(1000) COLLATE Latin1_General_100_CS_AS_SC
);

-- Information about tables in the current database
SELECT TABLE_NAME
FROM INFORMATION_SCHEMA.TABLES;

-- Drop table
DROP TABLE test;

-- Drop database
DROP DATABASE quarantine;