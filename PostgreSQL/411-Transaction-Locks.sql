-- Locks

-- Row-Level Locks
--
-- | **Lock Type**       | **When Used**                    | **Effect**                                            |
-- | ------------------- | -------------------------------- | ----------------------------------------------------- |
-- | `FOR UPDATE`        | `SELECT ... FOR UPDATE`          | Blocks others from updating/deleting the row          |
-- | `FOR NO KEY UPDATE` | Implicit in some foreign key ops | Similar to `FOR UPDATE`, but allows FK changes        |
-- | `FOR SHARE`         | `SELECT ... FOR SHARE`           | Prevents updates but allows reads                     |
-- | `FOR KEY SHARE`     | Used with foreign keys           | Prevents key modification (e.g., primary key changes) |

-- Table-Level Locks
--
-- | **Lock Mode**            | **Conflicts With**                                    | **Common Usage**                        |
-- | ------------------------ | ----------------------------------------------------- | --------------------------------------- |
-- | `ACCESS SHARE`           | `ACCESS EXCLUSIVE`                                    | Regular `SELECT` queries                |
-- | `ROW SHARE`              | `EXCLUSIVE`, `ACCESS EXCLUSIVE`                       | `SELECT FOR UPDATE`, `SELECT FOR SHARE` |
-- | `ROW EXCLUSIVE`          | All except `ACCESS SHARE`, `ROW SHARE`                | `INSERT`, `UPDATE`, `DELETE`            |
-- | `SHARE UPDATE EXCLUSIVE` | Overlaps with most except `ACCESS SHARE`, `ROW SHARE` | `VACUUM`, `ANALYZE`                     |
-- | `SHARE`                  | `ROW EXCLUSIVE`, `SHARE ROW EXCLUSIVE`, etc.          | Explicit `LOCK TABLE ... IN SHARE MODE` |
-- | `SHARE ROW EXCLUSIVE`    | Almost all other modes                                | Rare — some DDL                         |
-- | `EXCLUSIVE`              | All except `ACCESS SHARE`                             | Explicit locks before sensitive updates |
-- | `ACCESS EXCLUSIVE`       | All other locks                                       | `ALTER TABLE`, `DROP TABLE`, etc.       |


-- -------------------
-- Example 1

BEGIN TRANSACTION;

SELECT *
FROM users
WHERE username = 'aaa'
  AND id = 1
    FOR UPDATE; -- locks the selected rows against concurrent updates until the end of the transaction

UPDATE users
SET email = '1@1.pl'
WHERE id = 22;

COMMIT;
