# Automatic Vacuuming

https://www.postgresql.org/docs/current/runtime-config-autovacuum.html

## Settings

* autovacuum_vacuum_threshold - Specifies the minimum number of updated or deleted tuples needed to trigger a VACUUM in
  any one table. The default is 50 tuples.
* autovacuum_vacuum_scale_factor - Specifies a fraction of the table size to add to autovacuum_vacuum_threshold when
  deciding whether to trigger a VACUUM. The default is 0.2 (20% of table size).
* autovacuum_analyze_threshold - Specifies the minimum number of inserted, updated or deleted tuples needed to trigger an ANALYZE in any one table. The default is 50 tuples. 
* autovacuum_analyze_scale_factor - Specifies a fraction of the table size to add to autovacuum_analyze_threshold when deciding whether to trigger an ANALYZE. The default is 0.1 (10% of table size).
* autovacuum_max_workers - Specifies the maximum number of autovacuum processes (other than the autovacuum launcher) that may be running at any one time. The default is three.
* autovacuum_naptime - Specifies the minimum delay between autovacuum runs on any given database. In each round the daemon examines the database and issues VACUUM and ANALYZE commands as needed for tables in that database. If this value is specified without units, it is taken as seconds. 
* autovacuum_freeze_max_age - Specifies the maximum age (in transactions) that a table's pg_class.relfrozenxid field can attain before a VACUUM operation is forced to prevent transaction ID wraparound within the table. Note that the system will launch autovacuum processes to prevent wraparound even when autovacuum is otherwise disabled.

e.g. autovacuum tuning for high-activity:

```conf
autovacuum = on
autovacuum_vacuum_threshold = 20
autovacuum_vacuum_scale_factor = 0.05

autovacuum_analyze_threshold = 20
autovacuum_analyze_scale_factor = 0.02

autovacuum_max_workers = 5
autovacuum_naptime = 30s

autovacuum_freeze_max_age = 200000000
```
