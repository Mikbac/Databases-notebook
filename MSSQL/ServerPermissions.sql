-- Add permissions
USE important_data;
GRANT SELECT ON OBJECT::tab2 TO zwarty;

-- Dissalow permissions
-- table -> houses;
-- column -> address;
-- user -> barry
USE important_data;
DENY SELECT ON OBJECT::houses(address) TO barry;

-- Remove permissions
REVOKE SELECT ON OBJECT::tab2 TO zwarty;

-- Current user permissions
SELECT * FROM fn_my_permissions('tab2', 'object');

