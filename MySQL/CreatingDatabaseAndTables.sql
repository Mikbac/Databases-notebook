CREATE DATABASE animals;

USE bronx;

CREATE TABLE dogs
(
    id      INT PRIMARY KEY NOT NULL,
    name    VARCHAR(20),
    owner   VARCHAR(20),
    species VARCHAR(20),
    sex     CHAR(1)
);

INSERT INTO dogs (id, name, owner, species, sex)
VALUES (1, 'Fluffy', 'Harold', 'cat', 'f'),
       (2, 'Claws', 'Gwen', 'cat', 'm'),
       (3, 'Buffy', 'Harold', 'dog', NULL);

INSERT INTO dogs
VALUES (4, 'Fluffy', 'Harold', 'cat', 'f'),
       (5, 'Claws', 'Gwen', 'cat', 'm'),
       (6, 'Buffy', 'Harold', 'dog', NULL);