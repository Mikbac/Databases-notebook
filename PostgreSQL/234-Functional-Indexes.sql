-- Functional index (Indexes on Expressions)
-- An index column need not be just a column of the underlying table, but can be a function or scalar expression computed
-- from one or more columns of the table. This feature is useful to obtain fast access to tables based on the results of computations.
-- https://www.postgresql.org/docs/current/indexes-expressional.html

CREATE INDEX idx_users_lower_email ON users (lower(email));

SELECT *
FROM users
WHERE lower(email) = 'user@example.com';
