-- Set default masking
ALTER TABLE tableName
    ALTER COLUMN columnName VARCHAR(100) MASKED WITH (FUNCTION = 'default()');

-- Set masking
ALTER TABLE tableName
    ALTER COLUMN columnName VARCHAR(50) MASKED WITH (FUNCTION = 'email()');

-- Masking part of data
ALTER TABLE tableName
    ALTER COLUMN FirstName VARCHAR(16) MASKED WITH (FUNCTION = 'partial(1,"XXXXXXX",0)');
-- 1 RXXXXXXX Tamburello 555.123.4567 RTamburello@contoso.com

-- Random masking
ALTER TABLE tableName
    ALTER COLUMN salary MONEY MASKED WITH (FUNCTION = 'random(1000, 15000)');

-- Remove masking
ALTER TABLE tableName
    ALTER COLUMN columnName DROP MASKED;
