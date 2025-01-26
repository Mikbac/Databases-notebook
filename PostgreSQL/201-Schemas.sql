-- Creating schema

CREATE SCHEMA schema_name;
-- or
CREATE SCHEMA userName AUTHORIZATION roleNameOrDBName;

-- Changing schema name
ALTER SCHEMA schemaName RENAME TO roleName;

-- Changing schema owner
ALTER SCHEMA schemaName OWNER TO roleName;

-- Creating table in schema public
CREATE TABLE public.tableName
(
    email TEXT
);

-- Moving table to another schema

ALTER TABLE table_name
    SET SCHEMA schema_name;

-- Insert to table in schema public
INSERT INTO public.tableName(email)
VALUES
    ('osoba@adres.tld');

-- Revoke permissions
REVOKE ALL ON SCHEMA public FROM roleName;
REVOKE USAGE ON SCHEMA public FROM roleName;
REVOKE CREATE ON SCHEMA public FROM roleName;

-- Grant permissions
GRANT USAGE ON SCHEMA public TO roleName;
GRANT CREATE ON SCHEMA public TO roleName;

-- Remove schema
DROP SCHEMA schemaName;

-- Schemas in DB
\dn
\dn+

-- Search path
-- https://www.postgresql.org/docs/current/ddl-schemas.html#DDL-SCHEMAS-PATH
--
SHOW search_path;
