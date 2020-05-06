--
-- DATABASE ROLE
--
-- Database roles
-- db_owner
-- db_securityadmin
-- db_accessadmin
-- db_backupoperator
-- db_ddladmin
-- db_datawriter
-- db_datareader
-- db_denydatawriter
-- db_denydatareader

-- Add database role
ALTER SERVER ROLE server_role_name ADD MEMBER db_owner;

-- Remove database role
ALTER SERVER ROLE server_role_name DROP MEMBER db_owner;

--
-- SERVER ROLE
--
-- sysadmin
-- serveradmin
-- securityadmin
-- processadmin
-- setupadmin
-- bulkadmin
-- diskadmin
-- dbcreator
-- public

-- Add server role
ALTER ROLE db_owner ADD MEMBER userName;

-- Remove server role
ALTER ROLE db_owner DROP MEMBER userName;
