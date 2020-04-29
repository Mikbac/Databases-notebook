SELECT *
FROM imiona
ORDER by imie
             COLLATE "pl-PL-x-icu";

-- Change collocation
ALTER TABLE imiona
    ALTER COLUMN imie
        SET DATA TYPE text
        COLLATE "pl-PL-x-icu";