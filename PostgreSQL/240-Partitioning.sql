-- Table Partitioning
-- Partitioning refers to splitting what is logically one large table into smaller physical pieces.
-- Benefits:
-- * Query performance can be improved dramatically in certain situations
-- * When queries or updates access a large percentage of a single partition, performance can be improved by using a sequential scan
-- * Bulk loads and deletes can be accomplished by adding or removing partitions
-- https://www.postgresql.org/docs/current/ddl-partitioning.html

-- ---------------------
-- Hash partitioning
-- ---------------------

-- Add partition hash
CREATE TABLE tableName
(
    id INTEGER
) PARTITION BY HASH (id);

-- Create partitions for hash
CREATE TABLE test_remainder0_Name
    PARTITION OF tableName
        FOR VALUES WITH (MODULUS 2, REMAINDER 0);

CREATE TABLE test_remainder1_Name
    PARTITION OF tableName
        FOR VALUES WITH (MODULUS 2, REMAINDER 1);

-- ---------------------
-- Range partitioning
-- ---------------------

-- Add partition range
CREATE TABLE orders
(
    id         int,
    product_id int,
    client_id  INT,
    time       DATE,
    status     TEXT

) PARTITION BY RANGE (time);

-- Add partitions for range
CREATE TABLE orders_archive
    PARTITION OF tableName
        FOR VALUES FROM ('2006.09.14') TO ('2020.03.15')
    TABLESPACE big;

CREATE TABLE orders_new
    PARTITION OF tableName
        FOR VALUES FROM ('2020-06-01') TO (MAXVALUE)
    TABLESPACE fast;

CREATE TABLE orders_invalid
    PARTITION OF orders
        DEFAULT;

-- ---------------------
-- List partitioning
-- ---------------------

-- Add partition list
CREATE TABLE clients
(
    id        int,
    name      TEXT,
    region_id INT
) PARTITION BY LIST (region_id);

-- Add partition for list
CREATE TABLE clients_1
    PARTITION OF tableName
        FOR VALUES IN (1, 2, 3);

CREATE TABLE clients_2
    PARTITION OF tableName
        FOR VALUES IN (4, 5, 6);

-- Disconnect partition
ALTER TABLE clients
    DETACH PARTITION clients_south;

-- Subpartitions
CREATE TABLE clients_south_hash
    PARTITION OF clients
        FOR VALUES IN (2,7,9,10,14)
    PARTITION BY LIST (id);

-- Remove partition
DROP TABLE partitionName;
