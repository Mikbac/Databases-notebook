-- Transactions
-- https://www.postgresql.org/docs/current/tutorial-transactions.html
-- https://www.postgresql.org/docs/current/sql-commit.html

-- Commit - commits the current transaction
BEGIN;
-- ...
COMMIT;

-- Rollback - abort a transaction
BEGIN;
-- ...
ROLLBACK;

-- -------------------
-- Example
-- Termina - 1
CREATE TABLE accounts
(
    id           SERIAL PRIMARY KEY,
    account_name TEXT    NOT NULL,
    balance      NUMERIC NOT NULL
);

INSERT INTO accounts(account_name, balance)
VALUES
    ('aaa', 100.00),
    ('bbb', 100.00);

BEGIN;

UPDATE accounts
SET balance = balance - 20.0
WHERE account_name = 'aaa';

UPDATE accounts
SET balance = balance + 20.0
WHERE account_name = 'bbb';

-- If you execute the following command in another terminal (connection),
-- it will wait until "COMMIT" open transaction:
-- UPDATE accounts
-- SET balance = balance + 10.0
-- WHERE account_name = 'aaa';

COMMIT;

