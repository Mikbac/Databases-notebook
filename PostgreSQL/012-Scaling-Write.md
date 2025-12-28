# Scaling write

## Queuing

Write queuing can help manage high write loads by temporarily storing write operations in a queue before they are

---------------------------------------------------------------------------

## Partitioning

Partitioning involves dividing a large table into smaller, more manageable pieces called partitions. Each partition can
be stored and accessed separately, which can improve write performance by reducing contention and allowing for parallel
writes.

With 8K blocks (PostgreSQL default) table can grow to 32TB. If more space is needed, partitioning can be used.

Access pattern -- main factor to consider when deciding on how to do make the partitioning ("where" or "join").

[240-Partitioning.sql](240-Partitioning.sql)

* Range Partitioning -- used with date/time or sequential fields.
* List Partitioning -- used with categorical fields.
* Hash Partitioning -- used to evenly distribute data across partitions. executed
  on the database. This can help smooth out spikes in write traffic and prevent the database from becoming overwhelmed.
* Composite Partitioning -- combination of two or more partitioning methods.

---------------------------------------------------------------------------

## Sharding

Sharding is a database architecture pattern that involves splitting a large database into smaller, more manageable
pieces called shards. Each shard is a separate database that contains a subset of the data. Sharding can help distribute
write loads across multiple database instances, improving write performance and scalability.

* Physical sharding -- a database node.
* Logical sharding -- a set of columns from the table that was obtained from splitting the table certain way.

Sharding key -- the column(s) used to determine how data is distributed across shards.
Sharding algorithm -- the method used to distribute data across shards (e.g. list partitioning, range partitioning, hash
partitioning).

Partitions are stored in the same database, while shards (still partitions) are stored in different servers.

---------------------------------------------------------------------------

## Multi-Master Replication

Multi-master replication allows multiple database instances to accept write operations simultaneously. This can help
distribute write loads and improve write performance. However, it also introduces challenges related to data consistency
and conflict resolution.
