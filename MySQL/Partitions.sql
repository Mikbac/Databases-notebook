# New table with partitions

CREATE TABLE cars
(
    id    INT         NOT NULL,
    name  VARCHAR(30) NOT NULL,
    prod  DATE        NOT NULL,
    speed INT         NOT NULL

)
    PARTITION BY RANGE (speed)
        (
        PARTITION p0_slow VALUES LESS THAN (150),
        PARTITION p1_medium VALUES LESS THAN (250),
        PARTITION p2_fast VALUES LESS THAN (MAXVALUE)
        );

# Removing data from partition

ALTER TABLE cars
    TRUNCATE PARTITION p1_medium;

# Removing partition

ALTER TABLE cars
    DROP PARTITION p0_slow;

