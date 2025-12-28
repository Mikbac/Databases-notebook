-- Create the test database on the subscriber
CREATE DATABASE test_db;
\c test_db
CREATE TABLE users
(
    id       SERIAL PRIMARY KEY,
    username TEXT
);
-- Create a subscription to the publication on the publisher
CREATE SUBSCRIPTION my_subscription
    CONNECTION 'host=postgres-publisher port=5432 dbname=test_db user=subscriber password=subscriber1'
    PUBLICATION my_publication;
