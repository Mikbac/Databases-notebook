-- Show roles
\du

-- Current role
SELECT CURRENT_USER;

-- Creating role
CREATE ROLE exampleRole1;
CREATE USER exampleRole2 PASSWORD 'pass';
CREATE USER exampleRole3 LOGIN PASSWORD 'pass';

-- Attributes:
-- | SUPERUSER      | NOSUPERUSER
-- | CREATEDB       | NOCREATEDB
-- | CREATEROLE     | NOCREATEROLE
-- | INHERIT        | NOINHERIT
-- | LOGIN          | NOLOGIN
-- | REPLICATION    | NOREPLICATION
-- | BYPASSRLS      | NOBYPASSRLS

-- Add privileges
GRANT CONNECT ON DATABASE databaseName TO exampleRole1;


-- Modification role
ALTER ROLE exampleRole1 CREATEROLE;
ALTER ROLE "exampleRole2" PASSWORD 'pass';

-- Removing role
DROP ROLE exampleRole1;

-- Adding role to role
GRANT group_role TO role1, ... ;

-- Removing role from role
REVOKE group_role FROM role1, ... ;

-- Removing membership
REVOKE exampleRole1 FROM roleToRemove;

-- Connections limit
ALTER ROLE limited CONNECTION LIMIT 10;

-- Password validity
ALTER ROLE userName VALID UNTIL '2020-05-31 00:00:00';