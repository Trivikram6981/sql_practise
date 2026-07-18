#  Clustered index
#  A clustered index determines the physical order of data rows in a table. Primary is always the clustered index of the table.
-- There is only one clustered index per table.
-- All rows are physically ordered by the clustered index key.

#  Non-Clustered Index
-- A non-clustered index is a separate structure from the actual table data. It stores pointers to the actual rows.
#  have multiple non-clustered indexes per table.
#  Ideal for filtering on columns where there is no primary key.

USE Demo_db;

CREATE TABLE students (
    student_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    age INT,
    email VARCHAR(100),
    city VARCHAR(50),
    admission_date DATE
);

INSERT INTO students
(first_name, last_name, age, email, city, admission_date)
VALUES
('John', 'Smith', 20, 'john.smith@email.com', 'New York', '2024-01-15'),
('Emma', 'Johnson', 22, 'emma.johnson@email.com', 'Chicago', '2024-02-10'),
('Michael', 'Brown', 19, 'michael.brown@email.com', 'Dallas', '2024-03-12'),
('Sophia', 'Davis', 21, 'sophia.davis@email.com', 'Houston', '2024-01-20'),
('William', 'Miller', 23, 'william.miller@email.com', 'Seattle', '2024-04-05'),
('Olivia', 'Wilson', 20, 'olivia.wilson@email.com', 'Boston', '2024-05-01'),
('James', 'Moore', 22, 'james.moore@email.com', 'Phoenix', '2024-03-18'),
('Ava', 'Taylor', 19, 'ava.taylor@email.com', 'Miami', '2024-06-10'),
('Benjamin', 'Anderson', 21, 'ben.anderson@email.com', 'Denver', '2024-02-28'),
('Charlotte', 'Thomas', 20, 'charlotte.thomas@email.com', 'Atlanta', '2024-04-22');


SELECT * FROM students;

SELECT * FROM students WHERE age='20';

EXPLAIN FORMAT=TRADITIONAL SELECT * FROM students WHERE age='20';

CREATE INDEX idx_age ON Demo_db.students(age);

DROP INDEX idx_age ON Demo_db.students;

CREATE INDEX idx_first_name ON students(first_name);

DROP INDEX idx_first_name ON students;

EXPLAIN FORMAT=TRADITIONAL SELECT * FROM students WHERE age='20'AND first_name='john';

#  Natural Key is the primary key of the existing data.

#  Surrogate Key is a system-generated primary key.

INSERT INTO Demo_db.students
(first_name,last_name,age,email,city,admission_date)
VALUES
('Carl','Johnson',21,'john.smith@email.com','Clarksville','2024-01-09');

SELECT * FROM students;

SET SQL_SAFE_UPDATES=0;

DELETE FROM students WHERE first_name='John';

SELECT * FROM students;


# SQL Query Fine-Tuning Techniques

#1. Use only required number of data avoid using *
SELECT first_name,last_name FROM students;

#2. Use WHERE before GROUP BY and HAVING
SELECT age,COUNT(*) AS total
FROM students 
WHERE student_id>5
GROUP BY age
HAVING COUNT(*)>1;

#3.Use JOIN instead of subquery
SELECT c.customer_id,c.first_name,c.last_name,SUM(p.amount) AS total
FROM sakila.customer c
JOIN sakila.payment p
ON c.customer_id=p.customer_id
GROUP BY c.customer_id;

#Instead of 

SELECT customer_id,first_name,last_name,
(
SELECT SUM(amount) 
FROM sakila.payment p 
WHERE c.customer_id=p.customer_id
) AS total 
FROM sakila.customer c;

# 4. Avoid functions on indexed columns
SELECT * FROM students WHERE MONTH(admission_date)=6;
SELECT * FROM students WHERE admission_date BETWEEN '2024-06-01' AND '2024-06-30';

#5 Use limit effectively
SELECT * FROM students LIMIT 5;

#6 Use CTE instead of subquery 
WITH average_len AS (
SELECT AVG(rental_rate) AS avg_rental
FROM sakila.film
)
SELECT film_id,title,rental_rate FROM sakila.film
WHERE rental_rate> (SELECT * FROM average_len);

#7Use explain to understand query execution
EXPLAIN FORMAT=TRADITIONAL SELECT * FROM students WHERE age='20';

#8.maintainance commands
ANALYZE TABLE students;
OPTIMIZE TABLE students;
#ANALYZE updates table and index statistics.
#OPTIMIZE reorganizes table storage and can reclaim unused space after many deletes or updates. Its exact behavior depends on the database.

#9.Use limit after the filtering condition in pagination
SELECT * FROM students LIMIT 3,5;
SELECT * FROM students WHERE student_id>4 LIMIT 5;
