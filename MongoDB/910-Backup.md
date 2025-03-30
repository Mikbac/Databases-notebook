# Backup

## BSON (binary)

* mongodump (export)

```shell
mongodump <options> <connection-string>
```

* mongorestore (import)

```shell
mongoexport --collection=<coll> <options> <connection-string>
```

## JSON or CSV

* mongoexport (export)

```shell
mongoexport --collection=<coll> <options> <connection-string>
```

* mongoimport (import)

```shell
mongoimport <options> <connection-string> <file>
```
