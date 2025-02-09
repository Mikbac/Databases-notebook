-- The COALESCE function returns the first of its arguments that is not null.
SELECT COALESCE(NULL, 3, NULL, 6, NULL);
-- 3

