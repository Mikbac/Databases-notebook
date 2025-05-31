# Extensions

## Check for available extensions

```shell
SELECT * FROM pg_available_extensions;
```

## Install the extension

```shell
# e.g install hstore 
CREATE EXTENSION hstore;
```

## Verify the installation

```shell
SELECT * FROM pg_extension;
```

## Extensions

* PostGIS - introduces additional data types such as geometry, geography, raster, and more, along with a suite of
  functions, operators, and indexing capabilities tailored to these spatial types
* pg_stat_statements - tracks statistics on the queries executed by a Postgres database
* pgcrypto - offers a variety of functions for hash creation, data encryption, and decryption, allowing you to perform
  secure cryptographic operations on your data
* pg_partman - create and manage both time-based and number-based table partition sets
* postgres_fdw - can be used to access data stored in external PostgreSQL servers
* pgvector - adds support for vector operations in PostgreSQL
* hstore - allows you to store sets of key/value pairs within a single PostgreSQL data type
