-- Current version
SELECT VERSION();

-- Current database
SELECT DATABASE();

-- All databases
SHOW DATABASES;

-- Tables in the current database
SHOW TABLES;

-- Table description
DESCRIBE tab1;

-- Charset and data collation in the current database
SELECT @@character_set_database,
       @@collation_database;

-- Information about columns in table tab1
SHOW FULL COLUMNS FROM tab1;