-- Trigger

-- https://www.postgresql.org/docs/current/sql-createtrigger.html


CREATE TRIGGER check_update
    BEFORE UPDATE ON accounts
    FOR EACH ROW
EXECUTE FUNCTION check_account_update();
