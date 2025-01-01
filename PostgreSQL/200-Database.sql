-- DATABASE

CREATE
DATABASE test1;

CREATE
DATABASE test2 OWNER ownerName;

-- Grant access
GRANT ALL PRIVILEGES ON DATBASE
test1 TO pUser1

\c test1
GRANT ALL
PRIVILAGES ON ALL TABLES IN SCHEMA public TO pUser1

-- Changing database
\c test1
\connect test1

DROP
DATABASE test1;
