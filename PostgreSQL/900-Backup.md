### Databases list

```sql
\l
+
```

### Load init script from file

```sql
\i .
/init.sql
```

------------------------

## pg_dump

https://www.postgresql.org/docs/current/app-pgdump.html

### Create dump

```shell
pg_dump \
  --inserts \
  --no-owner \
  --username abd13 \
  --table users init_data_db
# or
pg_dump my_important_db --encoding="UTF8" \
  --compress=6 \
  --username=AdminUser \
  --no-owner > backup_1.gz
```

* `--encoding="UTF8"` - check db encoding via `\l`
* `--compress=6` or `--compress=gzip:9`- If only a level is specified without mentioning an algorithm, gzip (The default
  is still gzip with a level of 6).
* `--no-owner` - Do not output commands to set ownership of objects to match the original database.
* `--inserts` - Dump data as INSERT commands (rather than COPY). This will make restoration very slow; it is mainly
  useful for making dumps that can be loaded into non-PostgreSQL databases

### Load dump

```shell
psql -d databaseName -f fileName.sql
```

```shell
gzip backup_1.gz | psql --username=AdminUser2 new_important_db -v VERBOSE=1
```
