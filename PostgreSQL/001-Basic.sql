-- All databases
\l
\list

-- Current database
SELECT current_database();

-- All tables
\dt

-- Table properties
\d tableName1

-- Copy to a CSV

\copy (select * from users) to 'users.csv' CSV HEADER
