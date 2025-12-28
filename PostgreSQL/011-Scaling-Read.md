# Scaling read

## Replication

Replication use-cases:

* handle extra read traffic
* high availability

Replication methods:

1. Streaming Replication
2. Logical Replication
3. 3rd Party Replication Tools (e.g. Pgpool-II)

### WAL

WAL (Write Ahead Log) is a critical component of PostgreSQL that ensures data integrity and durability. It records all
changes made to the database, allowing for recovery in case of crashes and enabling replication.

### Streaming Replication

Streaming Replication is a built-in feature of PostgreSQL that allows for real-time replication of data from a primary
server to one or more standby servers. It uses WAL to transmit changes to the standby servers, which can then apply
those changes to maintain an up-to-date copy of the primary database.

Asynchronous vs Synchronous Replication:

* Asynchronous Replication: The primary server does not wait for confirmation from the standby servers before committing
  transactions. This can lead to some data loss in case of a failure but offers better performance.
* Synchronous Replication: The primary server waits for confirmation from the standby servers before committing
  transactions. This ensures data consistency but can introduce latency.

### Configuration

#### Primary server

change listen addresses:

```postgresql.conf
listen_addresses = '*'
```

add new user for replication:

```sql
CREATE ROLE replicator REPLICATION LOGIN ENCRYPTED PASSWORD 'replicator1';
```

allow to connect for replication:

```pg_hba.conf
host    replication     replicator      0.0.0.0/0               md5
```

#### Replica server

```shell
pg_basebackup -h postgres-master \
  -U replicator \
  --checkpoint=fast \
  -D /var/lib/postgresql/data \
  --slot=replica_name_1 \
  -C \
  --port=5432 \
  -Fp \
  -Xs \
  -P \
  -R
```

| Option                        | Description                                         |
|-------------------------------|-----------------------------------------------------|
| `-h postgres-master`          | Hostname of the primary server                      |
| `-U replicator`               | Replication user                                    |
| `--checkpoint=fast`           | Forces a fast checkpoint before starting the backup |
| `-D /var/lib/postgresql/data` | Destination data directory                          |
| `--slot=replica-name-1`       | Replication slot name                               |
| `-C`                          | Create the replication slot                         |
| `--port=5432`                 | Port of the primary server                          |
| `-Fp`                         | Plain (physical) backup format                      |
| `-Xs`                         | Stream WAL files during the backup                  |
| `-P`                          | Show progress information                           |
| `-R`                          | Automatically configure the replica                 |

### Testing on primary

```sql
SELECT *
FROM pg_stat_replication;
```

### Testing on replica

```sql
SELECT *
FROM pg_stat_wal_receiver;
```

### Logical Replication

Logical Replication allows for more flexible replication setups, enabling selective replication of tables or
schemas. It uses a publish-subscribe model, where the primary server publishes changes to specific tables, and the
replica servers subscribe to those publications.

```
# LOGICAL REPLICATION (PostgreSQL)

## PUBLISHER (Primary)

+------------------------------------------------------------+
|                        WAL RECORDS                         |
|                    [ W1 | W2 | W3 | W4 ]                    |
+-----------------------------+------------------------------+
                              |
                              v
+------------------------------------------------------------+
|                   WAL DECODING PLUGIN                      |
|            (e.g. pgoutput / custom plugin)                 |
+-----------------------------+------------------------------+
                              |
                              v
+------------------------------------------------------------+
|                        WAL SENDER                          |
+-----------------------------+------------------------------+
                              |
                              |  logical changes
                              v
================================================================
                              |
                              v
## SUBSCRIBER (Replica)

+------------------------------------------------------------+
|                    REPLICATION WORKER                      |
+-----------------------------+------------------------------+
                              |
                              v
+------------------------------------------------------------+
|                          TABLES                            |
|              (applied logical changes)                     |
+-----------------------------+------------------------------+
                              |
                              v
+------------------------------------------------------------+
|                        WAL RECORDS                         |
|                    [ W1 | W2 | W3 | W4 ]                    |
+------------------------------------------------------------+
```

### Configuration

#### Publisher server

```postgresql.conf
listen_addresses = '*'
wal_level=logical
```

call on publisher:

```sql
CREATE PUBLICATION my_publication FOR ALL TABLES;
-- or for specific table
CREATE PUBLICATION my_publication FOR TABLE my_table;
```

### Monitoring Replication

```sql
SELECT *
FROM pg_stat_replication;
```

---------------------------------------------------------------------------

## Load Balancing with Replication

To effectively distribute read traffic across multiple replicas, a load balancer can be employed.

Read Replicas Pool -- A pool of read replicas can be created to handle read queries, reducing the load on the primary
node.

Haproxy -- A popular open-source load balancer that can be configured to distribute read queries among replicas.

---------------------------------------------------------------------------

## Connection Pooling

Each connection to PostgreSQL consumes resources. Connection pooling can help manage and reuse connections efficiently.

Tools for connection pooling:

* PgBouncer
* Pgpool-II

| Feature / Aspect                    | JDBC Connection Pool (HikariCP, etc.)           | PgBouncer                                                     | Pgpool-II                                                   |
|-------------------------------------|-------------------------------------------------|---------------------------------------------------------------|-------------------------------------------------------------|
| **Location**                        | Application                                     | Proxy between app and Postgres                                | Proxy between app and Postgres                              |
| **Pooling**                         | Yes, in the application                         | Yes, on the DB server                                         | Yes, plus load balancing and replication                    |
| **Scaling across multiple apps**    | Each app has its own pool → many DB connections | Shared pool for all clients → fewer DB connections            | Shared pool + read/write split + failover                   |
| **Reconnect / DB restart handling** | Limited, may cause temporary errors             | Handles reconnects automatically                              | Handles reconnects, failover, replication check             |
| **Advanced features**               | Timeout, leak detection                         | Pooling modes (session / transaction / statement), retry      | Pooling + load balancing + replication + query caching      |
| **Read/Write splitting**            | no                                              | no                                                            | yes                                                         |
| **Failover support**                | no                                              | no                                                            | yes                                                         |
| **Use case**                        | Small apps, few clients                         | Many clients, need transaction pooling, reduce DB connections | Large-scale systems with replicas, load balancing, failover |

### PgBouncer

Important PgBouncer settings:

* min_pool_size - It keeps a minimum size of connection ready to be used so that connections are not created on-demand.
* default_pool_size - When the PgBouncer pool reaches the maximum number of connections PgBouncer puts the extra
  connections in a wait queue.

Pooling modes:
* Session pooling - A client connection gets assigned a server connection for the entire duration of the session.
* Transaction pooling - A server connection is assigned to a client only during a transaction. Outside of transactions, the
  server connection is returned to the pool.
* Statement pooling - A server connection is assigned to a client only during the execution of a single statement.

