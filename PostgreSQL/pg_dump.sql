-- Create dump
pg_dump --inserts --no-owner --username abd13 --table users init_data

-- Load dump
psql -d databaseName -f fileName.sql

