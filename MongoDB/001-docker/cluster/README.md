# Cluster

Create containers:

```shell
docker compose up -d
```

Init replica set:

```shell
docker exec -it mongo-db-1 mongosh --eval "rs.initiate({
 _id: \"myTestReplSet\",
 members: [
   {_id: 0, host: \"mongo-db-1\"},
   {_id: 1, host: \"mongo-db-2\"},
   {_id: 2, host: \"mongo-db-3\"}
 ]
})"
```

Test:

```shell
docker exec -it mongo-db-1 mongosh --eval "rs.status()"
docker exec -it mongo-db-2 mongosh --eval "rs.status()"
docker exec -it mongo-db-3 mongosh --eval "rs.status()"
```
