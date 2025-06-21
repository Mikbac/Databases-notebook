-- Multicolumn/Composite Index
-- An index can be defined on more than one column of a table.
-- Correct order is important; ESR (Equality, Sort, Range)
-- * Equality -> =.
-- * Sort -> ORDER BY.
-- * Range -> >, <, BETWEEN.

CREATE INDEX index_name ON table_name (column1, column2, ...);

-- e.g

CREATE INDEX idx_user_status ON users (last_name, first_name);

-- correct index for:
-- WHERE last_name = 'Smith'
-- WHERE last_name = 'Smith' AND first_name = 'John'
--
-- incorrect index for:
-- WHERE first_name = 'John'
