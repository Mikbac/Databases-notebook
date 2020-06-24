-- Add group
ALTER DATABASE databaseName ADD FILEGROUP FG1;

-- Add file to group
ALTER DATABASE databaseName
ADD FILE
(
  NAME = 'fileName',
  FILENAME = '/var/opt/mssql/data/path.ndf'
)
TO FILEGROUP FG1;

-- Partition functions
CREATE
PARTITION FUNCTION fn_function_name (INT)
AS RANGE RIGHT
FOR
VALUES (100,
        1000);

-- Partition schema
CREATE PARTITION SCHEME schema_name
AS PARTITION function_name
TO (FG1, FG2, FG3);

-- Create table with partition schema
CREATE TABLE tableName
(
    id       INT,
    name     VARCHAR(50),
    surname VARCHAR(50),
    email    VARCHAR(50),
    points   INT
)
ON schemaName(points)

-- Select value from second partition
SELECT *
FROM tableName
WHERE
    $PARTITION.fn_schema_name(points) = 2;

-- Remove limit from partition
ALTER PARTITION FUNCTION fn_name() MERGE RANGE (1000);

-- Remove function
USE databaseName;
go

DROP TABLE tableName;
go

DROP PARTITION SCHEME schemaName;
go

DROP PARTITION FUNCTION functionName;
go