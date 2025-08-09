-- VACUUM
-- VACUUM — garbage-collect and optionally analyze a database
-- VACUUM reclaims storage occupied by dead tuples. In normal PostgreSQL operation, tuples that are deleted or
-- obsoleted by an update are not physically removed from their table; they remain present until a VACUUM is done.
-- Therefore it's necessary to do VACUUM periodically, especially on frequently-updated tables.


VACUUM FULL my_table;

-- | Option / Variant                  | Removes dead tuples  | Updates stats (`ANALYZE`)  | Shrinks file size   | Locks table                 | Main use case                               |
-- | --------------------------------- | -------------------- | -------------------------- | ------------------- | --------------------------- | ------------------------------------------- |
-- | `VACUUM`                          | ✅                   | ❌                         | ❌                 | ❌ (only lightweight locks) | Quick cleanup, space reused internally      |
-- | `VACUUM ANALYZE`                  | ✅                   | ✅                         | ❌                 | ❌                          | Cleanup + refresh optimizer statistics      |
-- | `VACUUM FULL`                     | ✅                   | ❌                         | ✅                 | ✅ (full lock)              | Compact table & indexes, reclaim disk space |
-- | `VACUUM FULL ANALYZE`             | ✅                   | ✅                         | ✅                 | ✅                          | Full cleanup + stats refresh                |
-- | `VACUUM FREEZE`                   | ✅ (with XID freeze) | ❌                         | ❌                 | ❌                          | Prevent transaction ID wraparound           |
-- | `VACUUM VERBOSE`                  | ✅                   | ❌                         | ❌                 | ❌                          | Cleanup with detailed logging               |
-- | `VACUUM (FULL, VERBOSE, ANALYZE)` | ✅                   | ✅                         | ✅                 | ✅                          | Max cleanup + stats + logs                  |


-- Quick cleanup
VACUUM my_table;

-- Cleanup + update statistics
VACUUM ANALYZE my_table;

-- Fully compact table and indexes, reclaim disk space
VACUUM FULL my_table;

-- Full cleanup + update statistics
VACUUM FULL ANALYZE my_table;

-- Freeze tuples to prevent wraparound
VACUUM FREEZE my_table;

-- Detailed logging
VACUUM VERBOSE my_table;

-- Combine multiple options
VACUUM (FULL, ANALYZE, VERBOSE) my_table;
