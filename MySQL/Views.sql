-- New view
CREATE VIEW personal_data AS
SELECT id, surname, address
FROM bank;

-- Remove view
DROP VIEW IF EXISTS personal_data;