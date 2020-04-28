-- USER
-- New user -> user: 'aaaa', host: '%', password: 'pass123'
CREATE USER 'aaaa'@'%'
    IDENTIFIED BY 'pass123';

CREATE USER 'bbbb'@'%'
    IDENTIFIED WITH mysql_native_password
        BY 'admin1';

CREATE USER 'cccc'@'%'
    IDENTIFIED WITH mysql_no_login;
-- Remove user
DROP USER 'aaaa'@'%';

-- Change password
ALTER USER 'aaaa'@'%'
    IDENTIFIED BY 'newPass1';

-- Expire password
ALTER USER 'aaaa'@'%'
    PASSWORD EXPIRE;

-- Add permissions to user -> database: 'smart_data', table: 'animals'
GRANT
    SELECT,
    INSERT,
    DROP
    ON smart_data.animals TO 'aaaa'@'%';

GRANT ALL
    ON *.*
    TO 'root'@'%'
    WITH GRANT OPTION;

-- Show permissions
SHOW GRANTS FOR 'aaaa'@'%';

-- Remove permissions
REVOKE INSERT
    ON smart_data.animals
    FROM 'aaaa'@'%';

-- ==================================================
-- ROLE
-- New role
CREATE ROLE 'read_all',
    'write_all';

-- Remove role
DROP ROLE 'read_all';

-- Set role to the current user
SET ROLE 'read_all';

-- Add permissions to role
GRANT INSERT, UPDATE, DELETE
    ON smart_data.bank TO 'write_all';

-- Update role
REVOKE UPDATE
    ON smart_data.bank
    FROM 'write_all';

-- Assign the role to the user
GRANT 'read_all' TO 'aaaa'@'%';

-- Remove user role
REVOKE 'read_all' FROM 'aaaa'@'%';
