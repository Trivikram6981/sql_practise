
#1. Get all customers whose first name starts with 'J' and who are active.
SELECT * FROM sakila.customer WHERE first_name REGEXP'^J'AND active>0;

#2. Find all films where the title contains the word 'ACTION' or the description contains 'WAR'.
SELECT * FROM sakila.film WHERE title LIKE '%ACTION%' OR description LIKE '%WAR%';

#3. List all customers whose last name is not 'SMITH' and whose first name ends with 'a'.
SELECT * FROM sakila.customer WHERE last_name!='SMITH' AND RIGHT(first_name,1)='A';

#4. Get all films where the rental rate is greater than 3.0 and the replacement cost is not null.
SELECT * FROM sakila.film WHERE rental_rate>3.0 AND replacement_cost IS NOT NULL ;

#5. Count how many customers exist in each store who have active status = 1.
SELECT store_id,COUNT(*) AS customers
FROM sakila.customer
WHERE active=1
GROUP BY store_id;

#6. Show distinct film ratings available in the film table.
SELECT DISTINCT rating FROM sakila.film;

#7. Find the number of films for each rental duration where the average length is more than 100 minutes.
SELECT rental_duration,
COUNT(*) AS number_of_films,
AVG(length) AS average
FROM sakila.film
GROUP BY rental_duration
HAVING AVG(length)>100;

#8. List payment dates and total amount paid per date, but only include days where more than 100 payments were made.
SELECT SUBSTRING_INDEX(payment_date,' ',1) AS date_,
COUNT(*) AS num_of_transac,
SUM(amount) AS day_total
FROM sakila.payment
GROUP BY SUBSTRING_INDEX(payment_date,' ',1)
HAVING COUNT(*)>100
ORDER BY SUBSTRING_INDEX(payment_date,' ',1);

#9. Find customers whose email address is null or ends with '.org'.
SELECT * FROM sakila.customer WHERE email IS NULL OR email REGEXP'.org$';

#10. List all films with rating 'PG' or 'G', and order them by rental rate in descending order.
SELECT * FROM sakila.film WHERE rating='PG' OR rating='G' ORDER BY rental_rate DESC;

#11. Count how many films exist for each length where the film title starts with 'T' and the count is more than 5.
SELECT length,COUNT(*) AS count_ FROM sakila.film
WHERE title REGEXP'^T'
GROUP BY length
HAVING COUNT(*)>5;

#12. List all actors who have appeared in more than 10 films.
SELECT actor_id,COUNT(*) AS film_count FROM sakila.film_actor
GROUP BY actor_id
HAVING COUNT(*)>10;

#13. Find the top 5 films with the highest rental rates and longest lengths combined, ordering by rental rate first and length second.
SELECT * FROM sakila.film ORDER BY rental_rate DESC,length DESC LIMIT 5;

#14. Show all customers along with the total number of rentals they have made, ordered from most to least rentals.
SELECT customer_id,COUNT(rental_id) AS num_rentals FROM sakila.rental
GROUP BY customer_id
ORDER BY COUNT(rental_id) DESC;

#15. List the film titles that have never been rented.
SELECT title FROM sakila.film 
WHERE film_id NOT IN (
SELECT film_id FROM sakila.inventory
WHERE inventory_id IN 
(SELECT inventory_id FROM sakila.rental)
);
