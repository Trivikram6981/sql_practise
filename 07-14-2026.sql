
#CTE
WITH average_len AS (
SELECT TRUNCATE(AVG(rental_rate),2) AS avg_rental
FROM sakila.film
)
SELECT film_id,title,rental_rate FROM sakila.film
WHERE rental_rate> (SELECT * FROM average_len);

#RECURSIVE CTE
WITH RECURSIVE june_rentals AS (
SELECT DATE('2005-06-01') AS rental_date
UNION ALL
SELECT DATE_ADD(rental_date,INTERVAL 1 DAY)
FROM june_rentals
WHERE rental_date < '2005-06-30'
)
SELECT jr.rental_date,COUNT(p.payment_id) AS day_rentals,SUM(p.amount) AS day_total
FROM june_rentals jr
LEFT JOIN sakila.payment p
ON jr.rental_date=DATE(payment_date)
GROUP BY jr.rental_date;

#TEMP TABLE
CREATE TEMPORARY TABLE customer_rental_summary AS (
SELECT c.customer_id,c.first_name,c.last_name,COUNT(r.rental_id) AS rental_count
FROM sakila.customer c
LEFT JOIN sakila.rental r
ON c.customer_id=r.customer_id
GROUP BY c.customer_id
);


SELECT * FROM customer_rental_summary WHERE rental_count>25;

#VIEW
CREATE VIEW customer_contact AS (
SELECT customer_id,first_name,last_name,email,active
FROM sakila.customer);

SELECT * FROM customer_contact;

#PROCEDURE
DELIMITER //
CREATE PROCEDURE genre(IN g CHAR(30))
BEGIN
SELECT f.film_id,f.title,c.name AS category FROM sakila.film f
LEFT JOIN sakila.film_category fc
ON f.film_id=fc.film_id
JOIN sakila.category c
ON fc.category_id=c.category_id
WHERE c.name=g;
END //
DELIMITER ;

DROP PROCEDURE genre;
CALL genre('DOCUMENTARY');

DELIMITER //
CREATE PROCEDURE search_film (IN id INT)
BEGIN 
SET @_query=CONCAT('SELECT * FROM sakila.film WHERE film_id=',id);
PREPARE STMT FROM @_QUERY;
EXECUTE STMT;
DEALLOCATE PREPARE STMT;
END //
DELIMITER ;

CALL search_film(5);

DELIMITER //
CREATE PROCEDURE left_join(IN table_a CHAR(50),IN table_b CHAR(50),IN on_condi CHAR(100))
BEGIN
SET @sql_query=CONCAT('SELECT * FROM ',table_a,
' LEFT JOIN ' ,table_b,
' ON ', on_condi);
PREPARE STMT FROM @sql_query;
EXECUTE STMT;
DEALLOCATE PREPARE STMT;
END //
DELIMITER ;

DROP PROCEDURE left_joining;

CALL left_join('customer c','address a','c.address_id=a.address_id');



