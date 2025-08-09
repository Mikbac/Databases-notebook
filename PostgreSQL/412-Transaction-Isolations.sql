-- Transaction Isolation

-- | **Isolation Level** | **Dirty Read**        | **Nonrepeatable Read** | **Phantom Read**      | **Serialization Anomaly** |
-- | ------------------- | --------------------- | ---------------------- | --------------------- | ------------------------- |
-- | Read Uncommitted    | Allowed *(not in PG)* | Possible               | Possible              | Possible                  |
-- | Read Committed      | Not possible          | Possible               | Possible              | Possible                  |
-- | Repeatable Read     | Not possible          | Not possible           | Allowed *(not in PG)* | Possible                  |
-- | Serializable        | Not possible          | Not possible           | Not possible          | Not possible              |

BEGIN TRANSACTION ISOLATION LEVEL READ COMMITTED;

SELECT username
FROM users
WHERE id = 1;

COMMIT;
