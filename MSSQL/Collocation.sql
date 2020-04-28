-- All collocations on server
SELECT *
FROM sys.fn_helpcollations();

-- Current collocation
SELECT SERVERPROPERTY('Collation');

-- Collocation for database
SELECT DATABASEPROPERTYEX('databaseName', 'collation');

-- Collocation for columns
SELECT COLUMN_NAME, COLLATION_NAME
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_CATALOG = 'db_pl'
  AND TABLE_NAME = 't1';

-- Update Collocation
ALTER TABLE tabela
    ALTER COLUMN imie NVARCHAR(20) COLLATE Polish_CS_AS;