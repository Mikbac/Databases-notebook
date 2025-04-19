CREATE TABLE tableName1
(
    id   SERIAL PRIMARY KEY,          -- without decimal point, auto increment (Best choice to store id)
    idB  BIGSERIAL,                   -- without decimal point, auto increment
    idS  SMALLSERIAL,                 -- without decimal point, auto increment
    -- -----
    u1   UUID,                        -- sequence of lower-case hexadecimal digits, in several groups separated by hyphens
    -- -----
    i1   SMALLINT,                    -- 2 bytes, without decimal point, -32768 to +32767
    i2   INTEGER,                     -- 4 bytes, without decimal point, -2147483648 to +2147483647 (Best choice to store a number without a decimal)
    i3   BIGINT,                      -- 8 bytes, without decimal point, -9223372036854775808 to +9223372036854775807
    -- -----
    n1   DECIMAL,                     -- user-specified precision, with decimal points
    n2   NUMERIC,                     -- user-specified precision, exact (Best choice to store a number with a decimal and this data needs to be very accurate e.g. bank balance)
    n3   REAL,                        -- 4 bytes, exact
    n4   DOUBLE PRECISION,            -- 8 bytes, exact (Best choice to store a number with a decimal and this data doesn't need to be very accurate e.g. liters of water)
    -- -----
    t1   CHAR,                        -- 1 byte
    t2   CHAR(10),                    -- (4+n) bytes, always set length to n (e.g. 10) even if postgres has to insert spaces
    t3   VARCHAR,                     -- 4 byte, store any length os string
    t4   VARCHAR(50),                 -- (4+x) bytes, remove extra characters
    t5   TEXT,                        -- store any length of string (Best choice)
    -- -----
    b1   BOOLEAN,                     -- "true" state: true, yes, on, 1; "false" state: false, no, off, 0; NULL state: null
    -- -----
    d1   DATE,
    -- -----
    ti1  TIME,                        -- without time zone
    ti2  TIME WITHOUT TIME ZONE,      -- without time zone
    ti3  TIME WITH TIME ZONE,         -- with time zone
    -- -----
    tis1 TIMESTAMP,                   -- without time zone
    tis2 TIMESTAMP WITHOUT TIME ZONE, -- without time zone
    tis3 TIMESTAMP WITH TIME ZONE,    -- with time zone
    tis4 TIMESTAMPTZ,                 -- with time zone
    -- -----
    in1  INTERVAL,                    -- interval/duration of time
    -- -----
    j1   JSON,                        -- stored as text
    j2   JSONB                        -- faster to access and operate on; has an existence operator, which is a variation on the theme of containment
    -- -----
);

INSERT INTO tableName1 (id, idB, idS, u1, i1, i2, i3, n1, n2, n3, n4, t1, t2, t3, t4, t5, b1, d1, ti1, ti2, ti3, tis1, tis2,
                        tis3, tis4, in1, j1, j2)
VALUES
    (DEFAULT, DEFAULT, DEFAULT,
     'A0EEBC99-9C0B-4EF8-BB6D-6BB9BD380A11',
     10, 10, 10,
     1.11, 1.11, 1.11, 1.11,
     'a', 'aaaa', 'aaaa', 'aaaa', 'aaaa',
     true,
     '11 Nov 2020',
     '04:05:06', '04:05:06', '04:05:06 PST',
     '2020-01-08 04:05:06', '2020-01-08 04:05:06', '2020-01-08 04:05:06-08', '2020-01-08 04:05:06-08',
     '1 D 22 H 30 M 32 S',
     '{
       "foo": [
         true,
         "bar"
       ],
       "tags": {
         "a": 1,
         "b": null
       }
     }', '{
      "foo": [
        true,
        "bar"
      ],
      "tags": {
        "a": 1,
        "b": null
      }
    }');

SELECT *
FROM tableName1;

SELECT j1 -> 'foo',         -- [       true,       "bar"    ]
       j1 -> 'tags',        -- {       "a": 1,        "b": null    }
       j1 -> 'tags' -> 'a', -- 1
       j1 -> 'tags' -> 'd', -- NULL
       j2 -> 'foo',         -- [true, "bar"]
       j2 -> 'tags',        -- {"a": 1, "b": null}
       j2 -> 'tags' -> 'a', -- 1
       j2 -> 'tags' -> 'd', -- NULL
       j2 -> 'tags' ? 'a',  -- true
       j2 -> 'tags' ? 'd'   -- false
FROM tableName1;

-- -----------------------------------
-- hstore - hstore key/value datatype

-- hstore data type for storing sets of key/value pairs within a single PostgreSQL value

-- run extension
CREATE EXTENSION hstore;

-- create table
CREATE TABLE books
(
    id         serial primary key,
    title      VARCHAR(255),
    attributes hstore
);

-- insert
INSERT INTO books (title, attributes)
VALUES
    ('PostgreSQL Tutorial',
     '"publisher" => "postgresqltutorial.com",
     "language"  => "English"');

-- select
SELECT attributes -> 'publisher'
FROM books
WHERE attributes -> 'language' = 'English';
