-- DATABASE

CREATE DATABASE animals;

CREATE DATABASE cars
    CHARACTER SET utf8
    COLLATE utf8_polish_ci;

ALTER DATABASE cars CHARACTER SET latin2;

USE animals;

-- TABLE

CREATE TABLE dogs
(
    id      INT PRIMARY KEY NOT NULL,
    name    VARCHAR(20),
    owner   VARCHAR(20),
    species VARCHAR(20),
    sex     CHAR(1)
);

CREATE TABLE cats
(
    id      INT PRIMARY KEY NOT NULL,
    name    VARCHAR(20),
    sex     CHAR(1)
) ENGINE = MyISAM;
-- Engines:
-- 'InnoDB', 'MyISAM', 'Memory', 'CSV', 'Merge', 'Archive', 'Federated', 'Blackhole', 'Example'

-- DATA

INSERT INTO dogs (id, name, owner, species, sex)
VALUES (1, 'Fluffy', 'Harold', 'cat', 'f'),
       (2, 'Claws', 'Gwen', 'cat', 'm'),
       (3, 'Buffy', 'Harold', 'dog', NULL);

INSERT INTO dogs
VALUES (4, 'Fluffy', 'Harold', 'cat', 'f'),
       (5, 'Claws', 'Gwen', 'cat', 'm'),
       (6, 'Buffy', 'Harold', 'dog', NULL);