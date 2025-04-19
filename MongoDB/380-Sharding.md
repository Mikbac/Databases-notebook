# Sharding

Sharding is a method for distributing data across multiple machines. MongoDB uses sharding to support deployments with
very large data sets and high throughput operations.

Horizontal Scaling involves dividing the system dataset and load over multiple servers, adding additional servers to
increase capacity as required.

MongoDB supports horizontal scaling through sharding.

https://www.mongodb.com/docs/manual/sharding/

A MongoDB sharded cluster consists of the following components:

* shard: Each shard contains a subset of the sharded data. Each shard must be deployed as a replica set.
* mongos: The mongos acts as a query router, providing an interface between client applications and the sharded cluster.
* config servers: Config servers store metadata and configuration settings for the cluster. Config servers must be deployed as a replica set (CSRS).
