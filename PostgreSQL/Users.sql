-- Creating a new user
CREATE USER userName;
ALTER ROLE userName PASSWORD 'pass123#';

-- Adding owner to DB
CREATE DATABASE databaseName OWNER userName;

