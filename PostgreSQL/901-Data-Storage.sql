-- directory used to store data
SHOW data_directory;
-- e.g. /var/lib/postgresql/data
-- ls /var/lib/postgresql/data/base
-- 1  16384  4  5

-- get catalog name with database data
SELECT oid, datname
FROM pg_database;
-- +-----+---------+
-- |oid  |datname  |
-- +-----+---------+
-- |5    |postgres |
-- |16384|test_db  |
-- |1    |template1|
-- |4    |template0|
-- +-----+---------+

-- get info about object inside database catalog
SELECT * FROM pg_class;
-- +-----+--------------------+------------+-------+---------+--------+-----+-----------+-------------+--------+---------+-------------+-------------+-----------+-----------+--------------+-------+--------+---------+-----------+--------------+--------------+--------------+-------------------+--------------+------------+--------------+----------+------------+----------+----------------------------------------+----------+------------+
-- |oid  |relname             |relnamespace|reltype|reloftype|relowner|relam|relfilenode|reltablespace|relpages|reltuples|relallvisible|reltoastrelid|relhasindex|relisshared|relpersistence|relkind|relnatts|relchecks|relhasrules|relhastriggers|relhassubclass|relrowsecurity|relforcerowsecurity|relispopulated|relreplident|relispartition|relrewrite|relfrozenxid|relminmxid|relacl                                  |reloptions|relpartbound|
-- +-----+--------------------+------------+-------+---------+--------+-----+-----------+-------------+--------+---------+-------------+-------------+-----------+-----------+--------------+-------+--------+---------+-----------+--------------+--------------+--------------+-------------------+--------------+------------+--------------+----------+------------+----------+----------------------------------------+----------+------------+
-- |16557|users_id_seq        |2200        |0      |0        |10      |0    |16557      |0            |1       |1        |0            |0            |false      |false      |p             |S      |3       |0        |false      |false         |false         |false         |false              |true          |n           |false         |0         |0           |0         |null                                    |null      |null        |
-- |16652|caption_tags        |2200        |16654  |0        |10      |2    |16652      |0            |125     |19495    |125          |0            |true       |false      |p             |r      |4       |0        |false      |true          |false         |false         |false              |true          |d           |false         |0         |800         |1         |null                                    |null      |null        |
-- |16565|pg_toast_16558      |99          |0      |0        |10      |2    |16565      |0            |0       |-1       |0            |0            |true       |false      |p             |t      |3       |0        |false      |false         |false         |false         |false              |true          |n           |false         |0         |784         |1         |null                                    |null      |null        |
-- |16566|pg_toast_16558_index|99          |0      |0        |10      |403  |16566      |0            |1       |0        |0            |0            |false      |false      |p             |i      |2       |0        |false      |false         |false         |false         |false              |true          |n           |false         |0         |0           |0         |null                                    |null      |null        |
-- |16567|users_pkey          |2200        |0      |0        |10      |403  |16567      |0            |17      |5345     |0            |0            |false      |false      |p             |i      |1       |0        |false      |false         |false         |false         |false              |true          |n           |false         |0         |0           |0         |null                                    |null      |null        |
-- |2619 |pg_statistic        |11          |10029  |0        |10      |2    |2619       |0            |19      |410      |19           |2840         |true       |false      |p             |r      |31      |0        |false      |false         |false         |false         |false              |true          |n           |false         |0         |731         |1         |{postgres=arwdDxtm/postgres}            |null      |null        |
-- |1247 |pg_type             |11          |71     |0        |10      |2    |0          |0            |15      |617      |15           |4171         |true       |false      |p             |r      |32      |0        |false      |false         |false         |false         |false              |true          |n           |false         |0         |731         |1         |{postgres=arwdDxtm/postgres,=r/postgres}|null      |null        |
-- |16569|posts_id_seq        |2200        |0      |0        |10      |0    |16569      |0            |1       |1        |0            |0            |false      |false      |p             |S      |3       |0        |false      |false         |false         |false         |false              |true          |n           |false         |0         |0           |0         |null                                    |null      |null        |
-- |2615 |pg_namespace        |11          |10047  |0        |10      |2    |2615       |0            |1       |4        |1            |4163         |true       |false      |p             |r      |4       |0        |false      |false         |false         |false         |false              |true          |n           |false         |0         |731         |1         |{postgres=arwdDxtm/postgres,=r/postgres}|null      |null        |
-- +-----+--------------------+------------+-------+---------+--------+-----+-----------+-------------+--------+---------+-------------+-------------+-----------+-----------+--------------+-------+--------+---------+-----------+--------------+--------------+--------------+-------------------+--------------+------------+--------------+----------+------------+----------+----------------------------------------+----------+------------+

-- https://www.postgresql.org/docs/current/storage-fsm.html
-- https://www.postgresql.org/docs/current/storage-vm.html
-- ls | grep 2615
-- 2615 - heap file
-- 2615_fsm - Free Space Map (FSM) (keep track of available space in the relation)
-- 2615_vm - Visibility Map (VM) track of which pages contain only tuples that are known to be visible to all active transactions

-- Heap file contains block/pages
-- Block/pages contains tuple/items.
--
-- Heap file holds all data for a single table.
-- Block/pages stores some number of tuples (the default block size is 8192 bytes (8kb)).
-- Tuple/items holds all information for one record stored in a table.

-- Get all bds
\l
-- or
SELECT * FROM pg_database;

-- Get db size
SELECT pg_size_pretty(pg_database_size('test_db'));

-- Get table size or index
SELECT pg_size_pretty(pg_relation_size('users'));
SELECT pg_size_pretty(pg_relation_size('idx_users_username'));
