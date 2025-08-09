# Instance config

## shared_buffers

The Amount of memory the database server uses for shared memory buffers. If you have a dedicated database server with
1GB or more of RAM, a reasonable starting value for shared_buffers is 25% of the memory in your system.

* It determines how much memory PostgreSQL allocates for its buffer pool (a cache in RAM for table data and indexes).
* The buffer pool improves performance by reducing disk access.
* The value is usually set in postgresql.conf

```shell
SHOW shared_buffers;
```

or

```sql
SELECT name, setting, unit
FROM pg_settings
WHERE name = 'shared_buffers';
```
