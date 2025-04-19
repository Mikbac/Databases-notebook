-- Partial indexes
-- A partial index is an index built over a subset of a table; the subset is defined by a conditional expression
-- (called the predicate of the partial index).
-- The index contains entries only for those table rows that satisfy the predicate.
-- Partial indexes are a specialized feature, but there are several situations in which they are useful.
-- https://www.postgresql.org/docs/current/indexes-partial.html

CREATE INDEX ON users (username)
    WHERE status = 'active';
