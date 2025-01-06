-- Joins
-- INNER JOIN: Returns records that have matching values in both tables
-- LEFT JOIN: Returns all records from the left table, and the matched records from the right table
-- RIGHT JOIN: Returns all records from the right table, and the matched records from the left table
-- FULL JOIN: Returns all records when there is a match in either left or right table


-- --------------------
-- Inner Join - Returns records that have matching values in both tables

SELECT url, username
FROM photos
         JOIN users ON users.id = photos.user_id;

-- or

SELECT *
FROM photos
         JOIN users ON users.id = photos.user_id
WHERE users.id = 4;

-- or

SELECT books.title AS book_title, authors.name AS author_name
FROM books
         JOIN authors ON authors.id = books.author_id;
-- or

SELECT b.title AS book_title, a.name AS author_name
FROM books AS b
         JOIN authors AS a ON a.id = b.author_id;-- or

SELECT b.title AS book_title, a.name AS author_name
FROM books b
         JOIN authors a ON a.id = b.author_id;
-- or

SELECT title, name, rating
FROM reviews
         JOIN books ON books.id = reviews.book_id
         JOIN authors ON authors.id = reviews.reviewer_id
WHERE reviews.reviewer_id = books.author_id;
-- same
SELECT title, name, rating
FROM reviews
         JOIN books ON books.id = reviews.book_id
         JOIN authors ON authors.id = books.author_id AND authors.id = reviews.reviewer_id;
-- --------------------
-- Left Outer Join - Returns all records from the left table, and the matched records from the right table

SELECT url, username
FROM photos
         LEFT JOIN users ON users.id = photos.user_id;

SELECT title, name
FROM authors
         LEFT JOIN books ON books.author_id = authors.id;

-- --------------------
-- Right Outer Join - Returns all records from the right table, and the matched records from the left table

SELECT url, username
FROM photos
         RIGHT JOIN users ON users.id = photos.user_id;

-- --------------------
-- Full Join - Returns all records when there is a match in either left or right table

SELECT url, username
FROM photos
         FULL JOIN users ON users.id = photos.user_id;
