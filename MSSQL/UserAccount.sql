-- Create user account
CREATE USER userName FOR LOGIN userLoginAccount;

-- Update user account name
ALTER USER userName WITH NAME = userName2;

-- Remove user account
DROP USER userName;

-- Executing as user
EXECUTE AS USER = 'uzytkownik';
SELECT * FROM student; -- <-example
REVERT; -- <- return to the previous status