-- Add log file
ALTER DATABASE databaseName
ADD LOG FILE
(
  NAME = 'university_log_2',
  SIZE = 1MB,
  MAXSIZE = 2GB,
  FILEGROWTH = 16MB,
  FILENAME = '/var/opt/mssql/data/university_log_2.ldf'
);

-- Remove log file
USE databaseName;
ALTER DATABASE databaseName
REMOVE FILE fileName_log;