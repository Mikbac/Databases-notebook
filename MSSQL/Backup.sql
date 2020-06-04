-- Create full backup
BACKUP DATABASE mssql12
    TO DISK = '/var/opt/mssql/data/mssql12.bak'
WITH
    NOFORMAT,
    NAME = 'mssql12 Full Backup';

-- Create differential backup
INSERT INTO tableName (id, name)
VALUES (1, 'name')

BACKUP DATABASE databaseName
    TO DISK = '/var/opt/mssql/data/example.bak'
WITH
    DIFFERENTIAL,
    NOFORMAT,
    NAME = 'backup Differential';

-- Create log backup
INSERT INTO tableName (id, name)
VALUES (1, 'name')

BACKUP LOG databaseName
    TO DISK = '/var/opt/mssql/data/example.bak'
WITH
    NOFORMAT,
    NAME = 'backup Log';

-- Restore full backup
ALTER DATABASE databaseName
SET OFFLINE WITH ROLLBACK IMMEDIATE;

RESTORE DATABASE databaseName
    FROM DISK = '/var/opt/mssql/data/example.bak'
WITH
    FILE = 1, -- 1 = full
    REPLACE;

-- Verify backup
RESTORE VERIFYONLY FROM DISK = '/var/opt/mssql/data/mssql12.bak';