
#1. List all customers along with the films they have rented.
SELECT c.customer_id,c.first_name,c.last_name,f.title 
FROM sakila.customer c
JOIN sakila.rental r
ON c.customer_id=r.customer_id
JOIN sakila.inventory i
ON r.inventory_id=i.inventory_id
JOIN sakila.film f
ON i.film_id=f.film_id
ORDER BY c.customer_id;

#2. List all customers and show their rental count, including those who haven't rented any films.
CREATE TEMPORARY TABLE customer_not_rented AS 
(SELECT c.customer_id,c.first_name,c.last_name,COUNT(r.rental_id) AS rental_count 
FROM sakila.customer c
LEFT JOIN sakila.rental r
ON c.customer_id=r.customer_id
GROUP BY c.customer_id
);
SELECT * FROM customer_not_rented;
SELECT * FROM customer_not_rented WHERE rental_id IS NULL;


#3. Show all films along with their category. Include films that don't have a category assigned.
CREATE VIEW title_category AS (
SELECT fc.film_id,f.title,c.name AS category 
FROM sakila.category c
RIGHT JOIN sakila.film_category fc
ON c.category_id=fc.category_id
RIGHT JOIN sakila.film f
ON fc.film_id=f.film_id
ORDER BY fc.film_id);

SELECT * FROM title_category WHERE category IS NULL;

#4. Show all customers and staff emails from both customer and staff tables using a full outer join (simulate using LEFT + RIGHT + UNION).
SELECT c.customer_id,c.first_name,c.last_name,s.staff_id,s.first_name,s.last_name,s.email 
FROM customer c
LEFT JOIN staff s
ON c.email=s.email 
UNION 
SELECT c.customer_id,c.first_name,c.last_name,s.staff_id,s.first_name,s.last_name,s.email 
FROM customer c
RIGHT JOIN staff s
ON c.email=s.email;

#5. Find all actors who acted in the film "ACADEMY DINOSAUR".
DELIMITER //
CREATE PROCEDURE get_actors(IN title CHAR(30))
BEGIN
SELECT a.actor_id,a.first_name,a.last_name  FROM sakila.film_actor fa
JOIN sakila.actor a
ON fa.actor_id=a.actor_id
LEFT JOIN sakila.film f
ON fa.film_id=f.film_id
WHERE f.title=title;
END //
DELIMITER ;

CALL get_actors('ACADEMY DINOSAUR');


#6. List all stores and the total number of staff members working in each store, even if a store has no staff.
SELECT o.store_id,COUNT(a.staff_id) AS staff_working
FROM sakila.store o
JOIN sakila.staff a
ON o.store_id=a.store_id
GROUP BY o.store_id;

#7. List the customers who have rented films more than 5 times. Include their name and total rental count.
DELIMITER //
CREATE PROCEDURE rentedfilms_morethan(IN num INT) 
BEGIN
SELECT c.customer_id,c.first_name,c.last_name,COUNT(r.rental_id) AS rental_count 
FROM sakila.customer c
JOIN sakila.rental r
ON c.customer_id=r.customer_id
GROUP BY c.customer_id,c.first_name,c.last_name
HAVING rental_count>num;
END//
DELIMITER ;

CALL rentedfilms_morethan(5);





