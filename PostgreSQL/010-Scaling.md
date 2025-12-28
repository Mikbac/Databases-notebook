# Scaling

## CAP theory

The CAP theorem says that a distributed system can deliver only two of three desired characteristics:

* Consistency - Every read receives the most recent write or an error.
* Availability - Every request receives a (non-error) response, without guarantee that it contains the most recent
  write.
* Partition tolerance - The system continues to operate despite an arbitrary number of messages being dropped (or
  delayed) by the network between nodes.

E.g.

* Cassandra provides Availability and Partition tolerance, but not Consistency. -- Cassandra allows Partial failures (
  only some nodes needs to be available to continue operations) and is designed for high availability.
* Standard PostgreSQL provides Consistency and Availability, but not Partition tolerance.

### Consistency and Availability use case

* transactional systems
* banking systems
* inventory management systems

### Availability and Partition tolerance use case

* social media platforms -- requires high volume, consistency is less critical, availability is critical

## Performance issues (slow response times)

Indicators:

* high CPU utilization
* high disc reads/writes (IOPS)

solutions:

* add indexes
* optimize queries
* caching

Detect profile:

* read focused -- use read replicas, load balancers, caching, check connection pooling
* write focused -- queuing, partitioning, sharding, multi-master replication
* mixed read/write -- scale reads and writes separately

## Statistics

### pg_stat_statements

pg_stat_statements - tracks statistics on the queries executed by a Postgres database

run pg_stat_statements extension by adding to `shared_preload_libraries = 'pg_stat_statements'` to `postgresql.conf`:

```conf
# - Shared Library Preloading -

#local_preload_libraries = ''
#session_preload_libraries = ''
shared_preload_libraries = 'pg_stat_statements'		# (change requires restart)
#jit_provider = 'llvmjit'		# JIT library to use

# - pg_stat_statements -
pg_stat_statements.max = 10000
pg_stat_statements.track = all
pg_stat_statements.track_utility = off
pg_stat_statements.save = on
```

and after run postgres:

```sql
CREATE EXTENSION pg_stat_statements;
```

top 10 time-consuming queries:

```sql
SELECT round((100 * total_exec_time / sum(total_exec_time)
                                      OVER ())::numeric, 2) percent,
       round(total_exec_time::numeric, 2) AS                total,
       calls,
       round(mean_exec_time::numeric, 2)  AS                mean,
       substring(query, 1, 200)
FROM pg_stat_statements
ORDER BY total_exec_time DESC
LIMIT 10;
```

### pgbench

Initializes the test_db database with the standard pgbench tables and test data for benchmarking:

```shell
pgbench -i -U postgres test_db
```

Runs a benchmark on test_db using 8 concurrent clients, each executing 25,000 transactions:

```shell
pgbench -c 8 -t 25000 -U postgres test_db
```

##

* Patroni
* PgPool II
