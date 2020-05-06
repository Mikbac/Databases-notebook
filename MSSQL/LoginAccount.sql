-- Login Accounts list
SELECT name,
       type_desc,
       is_disabled
FROM sys.sql_logins;

SELECT name,
       type_desc
FROM sys.server_principals
WHERE type_desc LIKE 'WINDOWS%';

-- Creating login account
CREATE LOGIN userName WITH PASSWORD = 'P@ssword';

-- Updating login account
ALTER LOGIN uzytkownik
WITH PASSWORD = 'P@ssword2'
    OLD_PASSWORD = 'P@ssword';

-- Removing login account
DROP LOGIN loginToRemove;

