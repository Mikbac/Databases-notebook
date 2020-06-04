-- Create group
ALTER DATABASE databaseName
ADD FILEGROUP groupName;

-- Add file to the group
USE databaseName;
ALTER DATABASE databaseName
ADD FILE
(
  NAME = 'university_2',
  SIZE = 1MB,
  FILEGROWTH = 8MB,
  FILENAME = '/var/opt/mssql/data/university_2.ndf'
)
TO FILEGROUP [PRIMARY]; --or TO FILEGROUP groupName;

-- Update file
USE databaseName;
ALTER DATABASE databaseName
MODIFY FILE
(
  NAME = 'university_2',
  MAXSIZE = 3GB
);

-- Create table and assign to the group
USE databaseName;
CREATE TABLE courses
(
    id INT,
    name VARCHAR(50)
)
ON groupName;