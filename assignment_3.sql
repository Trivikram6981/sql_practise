
#1. display all customer details who have made more than 5 payments.
SELECT customer_id,c.first_name,c.last_name
FROM sakila.customer c
WHERE (SELECT COUNT(*) 
FROM sakila.payment p 
WHERE c.customer_id=p.customer_id)>5;

#2. Find the names of actors who have acted in more than 10 films.
SELECT actor_id,first_name,last_name 
FROM sakila.actor 
WHERE actor_id IN 
(SELECT actor_id
FROM sakila.film_actor
GROUP BY actor_id
HAVING COUNT(film_id)>10
);

#3. Find the names of customers who never made a payment.
CREATE VIEW no_payment AS
(SELECT customer_id,first_name,last_name 
FROM sakila.customer 
WHERE customer_id NOT IN 
(SELECT DISTINCT(customer_id) FROM sakila.payment)
);

SELECT * FROM no_payment;

#4. List all films whose rental rate is higher than the average rental rate of all films.
SELECT film_id,title,rental_rate 
FROM sakila.film 
WHERE rental_rate>(SELECT AVG(rental_rate) FROM sakila.film);

#5. List the titles of films that were never rented.
CREATE TEMPORARY TABLE never_rentedfilms AS 
(SELECT title 
FROM sakila.film 
WHERE film_id NOT IN 
(SELECT film_id 
FROM sakila.inventory 
WHERE inventory_id IN 
(SELECT inventory_id FROM sakila.rental)
));
SELECT * FROM never_rentedfilms;

#6. Display the customers who rented films in the same month as customer with ID 5.
SELECT customer_id,first_name,last_name  
FROM sakila.customer WHERE customer_id IN (
SELECT customer_id
FROM sakila.rental  
WHERE MONTH(rental_date) IN
(SELECT MONTH(rental_date) 
FROM sakila.rental 
WHERE customer_id=5)
ORDER BY MONTH(rental_date)
);

#7. Find all staff members who handled a payment greater than the average payment amount.
CREATE VIEW greaterthan_avg_payment AS (
SELECT staff_id,first_name,last_name
FROM sakila.staff 
WHERE staff_id in (SELECT staff_id 
FROM sakila.payment p
WHERE amount>(SELECT AVG(amount) FROM sakila.payment)
));
SELECT * FROM greaterthan_avg_payment;

#8. Show the title and rental duration of films whose rental duration is greater than the average.
WITH avg_rental_duration AS 
(
SELECT AVG(rental_duration) 
FROM sakila.film
)
SELECT title,rental_duration 
FROM sakila.film 
WHERE rental_duration>(
SELECT * FROM avg_rental_duration);

#9. Find all customers who have the same address as customer with ID 1.
SELECT customer_id,first_name,last_name,address_id 
FROM sakila.customer 
WHERE address_id=(SELECT address_id FROM sakila.customer WHERE customer_id=1) AND customer_id>1;

#10. List all payments that are greater than the average of all payments.
WITH avg_payment AS 
(
SELECT AVG(amount) 
FROM sakila.payment
)
SELECT payment_id,customer_id,rental_id,amount 
FROM sakila.payment 
WHERE amount>(SELECT * FROM avg_payment);



