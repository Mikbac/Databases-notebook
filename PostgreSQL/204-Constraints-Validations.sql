-- https://www.postgresql.org/docs/current/ddl-constraints.html
-- NOT NULL - value must be provided
-- DEFAULT 'Important description!' - default value if an INSERT doesn't provide value
-- UNIQUE
-- CHECK ( price > 0 )

CREATE TABLE sampleTable
(
    id          SERIAL PRIMARY KEY,
    name        TEXT,
    code        TEXT UNIQUE,
    price       INTEGER NOT NULL CHECK ( price > 0 ),
    description TEXT DEFAULT 'Important description!',
    created_at  TIMESTAMP,
    updated_at  TIMESTAMP,
    CHECK ( created_at < updated_at )
    -- UNIQUE(name, code) -- multi-column uniqueness
);

-- or update table (if already exists)

UPDATE sampleTable
SET price = 0
WHERE price IS NULL;

ALTER TABLE sampleTable
    ALTER COLUMN price
        SET NOT NULL;

ALTER TABLE sampleTable
    ALTER COLUMN description
        SET DEFAULT 'Important description!';

ALTER TABLE sampleTable
    ADD UNIQUE (code);

ALTER TABLE sampleTable
    ADD UNIQUE (name, code);

ALTER TABLE sampleTable
    ADD CHECK ( price > 0 )
