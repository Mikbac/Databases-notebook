-- https://www.postgresql.org/docs/current/sql-explain.html
-- EXPLAIN - show the execution plan of a statement
-- EXPLAIN ANALYZE -  causes the statement to be actually executed, not only planned

EXPLAIN
SELECT username, posts.caption
FROM users
         JOIN posts ON users.id = posts.user_id
WHERE username = 'Viviane70';

-- +-------------------------------------------------------------------------------------------+
-- |QUERY PLAN                                                                                 |
-- +-------------------------------------------------------------------------------------------+
-- |Hash Join  (cost=8.31..410.60 rows=2 width=69)                                             |
-- |  Hash Cond: (posts.user_id = users.id)                                                    |
-- |  ->  Seq Scan on posts  (cost=0.00..368.32 rows=12932 width=60)                           |
-- |  ->  Hash  (cost=8.30..8.30 rows=1 width=17)                                              |
-- |        ->  Index Scan using idx_users_username on users  (cost=0.28..8.30 rows=1 width=17)|
-- |              Index Cond: ((username)::text = 'Viviane70'::text)                           |
-- +-------------------------------------------------------------------------------------------+
-- rows - guess at how many rows this step reproduce
-- width - guess at the average number of bytes of each row


EXPLAIN ANALYSE
SELECT username, posts.caption
FROM users
         JOIN posts ON users.id = posts.user_id
WHERE username = 'Viviane70';

-- +-------------------------------------------------------------------------------------------------------------------------------------+
-- |QUERY PLAN                                                                                                                           |
-- +-------------------------------------------------------------------------------------------------------------------------------------+
-- |Hash Join  (cost=8.31..410.60 rows=2 width=69) (actual time=3.122..32.155 rows=3 loops=1)                                            |
-- |  Hash Cond: (posts.user_id = users.id)                                                                                              |
-- |  ->  Seq Scan on posts  (cost=0.00..368.32 rows=12932 width=60) (actual time=0.712..29.298 rows=12932 loops=1)                      |
-- |  ->  Hash  (cost=8.30..8.30 rows=1 width=17) (actual time=1.288..1.290 rows=1 loops=1)                                              |
-- |        Buckets: 1024  Batches: 1  Memory Usage: 9kB                                                                                 |
-- |        ->  Index Scan using idx_users_username on users  (cost=0.28..8.30 rows=1 width=17) (actual time=1.174..1.176 rows=1 loops=1)|
-- |              Index Cond: ((username)::text = 'Viviane70'::text)                                                                     |
-- |Planning Time: 0.207 ms                                                                                                              |
-- |Execution Time: 32.218 ms                                                                                                            |
-- +-------------------------------------------------------------------------------------------------------------------------------------+

-- ------------------------
-- get statistics
SELECT *
FROM pg_stats
WHERE tablename = 'users';
