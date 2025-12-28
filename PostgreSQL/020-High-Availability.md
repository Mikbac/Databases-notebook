# High Availability

## At least one standby replica

* log shipping
* streaming replication
* logical replication
* Cascade replication

## Failover and Failback

* Patroni
* Repmgr
* Pgpool-II
* PAF

## Pgpool-II

* Load Balancing (automatically provides write requests to primary and read requests to replicas)
* Connection Pooling
* Automatic Failover
* High Availability itself

```
                    ┌──────────────────┐
                    │   Application    │
                    │                  │
                    └─────────┬────────┘
                              │
                              │  all SQL queries
                              ▼
                    ┌──────────────────┐
                    │     Pgpool-II    │
                    │  (Connection &   │
                    │   Load Balancer) │
                    └───────┬─────┬────┘
                            │     │
        INSERT / UPDATE /   │     │      SELECT
        DELETE / DDL        │     │
                            │     │
                            ▼     ▼
                ┌────────────────┐   ┌────────────────┐
                │ PostgreSQL     │   │ PostgreSQL     │
                │ PRIMARY        │   │ STANDBY        │
                │ (read + write) │   │ (read-only)    │
                └───────┬────────┘   └────────────────┘
                        │
                        │  WAL (streaming replication)
                        ▼
                ┌────────────────┐
                │ PostgreSQL     │
                │ STANDBY        │
                │ (replica)      │
                └────────────────┘

```
