-- Create a sample table and publication for logical replication
CREATE TABLE users
(
    id       SERIAL PRIMARY KEY,
    username TEXT
);

INSERT INTO users (username)
VALUES
    ('Bob'),
    ('Alice'),
    ('Alice');

-- Create sample data and publication for logical replication
-- CREATE PUBLICATION my_publication FOR ALL TABLES;
CREATE PUBLICATION my_publication FOR TABLE public.users;
