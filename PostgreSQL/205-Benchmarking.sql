
EXPLAIN ANALYSE SELECT *
FROM users
WHERE username = 'Viviane70';
-- +-------------------------------------------------------------------------------------------------+
-- |QUERY PLAN                                                                                       |
-- +-------------------------------------------------------------------------------------------------+
-- |Seq Scan on users  (cost=0.00..175.81 rows=1 width=202) (actual time=0.062..3.117 rows=1 loops=1)|
-- |  Filter: ((username)::text = 'Viviane70'::text)                                                 |
-- |  Rows Removed by Filter: 5344                                                                   |
-- |Planning Time: 0.750 ms                                                                          |
-- |Execution Time: 3.195 ms                                                                         |
-- +-------------------------------------------------------------------------------------------------+
--
-- Execution Time - how long does this query take
