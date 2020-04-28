-- Turn off logger
SET sql_log_bin = OFF;

-- Load data from the file
CREATE DATABASE IF NOT EXISTS animals;
USE animals;
SOURCE my_backup.sql;

-- Load data from the file to the database
LOAD DATA LOCAL INFILE 'animals.csv'
    INTO TABLE animals
    FIELDS TERMINATED BY ','
    ENCLOSED BY '\"'
    LINES TERMINATED BY  '\r\n'
    IGNORE 1 LINES;