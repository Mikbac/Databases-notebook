-- Set system variable
SET GLOBAL check_proxy_users = ON;
SET GLOBAL mysql_native_password_proxy_users = ON;

-- Check system variables
SHOW VARIABLES WHERE
            Variable_Name LIKE 'check_proxy_users' OR
            Variable_Name LIKE 'mysql_native_password_proxy_users';

