-- Install plugin
INSTALL PLUGIN mysql_no_login SONAME 'mysql_no_login.so';

-- Check plugin
SELECT PLUGIN_NAME, PLUGIN_STATUS
FROM INFORMATION_SCHEMA.PLUGINS
WHERE PLUGIN_NAME LIKE '%mysql_no_login%';

