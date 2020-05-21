-- Creating schema
CREATE SCHEMA chemaName;

-- Remove schema
DROP SCHEMA MySchema;

-- Set schema owner
ALTER AUTHORIZATION ON schema::MySchemat TO userName;

-- Default user schema
ALTER USER userName WITH DEFAULT_SCHEMA = MySchema;

-- Transfer table to schema
ALTER SCHEMA MySchema TRANSFER dbo.tableName;

-- Show all schemas assignments
SELECT *
FROM INFORMATION_SCHEMA.TABLES;