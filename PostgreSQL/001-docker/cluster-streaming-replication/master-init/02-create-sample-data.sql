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
