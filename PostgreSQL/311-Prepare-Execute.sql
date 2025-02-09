-- Handling SQL injection
PREPARE test_query(VARCHAR) AS
    SELECT *
    FROM users
    WHERE username = $1;

EXECUTE test_query('aaa');
