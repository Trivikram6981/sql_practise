															#use of SELECT
                                                            
SELECT * FROM sakila.payment;

SELECT customer_id,payment_id FROM sakila.payment;
															#DISTINCT and COUNT

SELECT DISTINCT customer_id FROM sakila.payment;

SELECT COUNT(DISTINCT (customer_id)) FROM sakila.payment;

SELECT DISTINCT staff_id FROM sakila.payment;

SELECT COUNT(*) FROM sakila.payment;

														#filtering on one condition by WHERE

SELECT payment_id,amount FROM sakila.payment WHERE staff_id=2;

SELECT payment_id,amount FROM sakila.payment WHERE staff_id=1;

SELECT COUNT(*) FROM sakila.payment WHERE staff_id=2;

SELECT COUNT(*) FROM sakila.payment WHERE staff_id=1;

SELECT customer_id,payment_id FROM sakila.payment;

														#LIMIT

SELECT payment_id,amount FROM sakila.payment WHERE staff_id=2 LIMIT 50;

SELECT payment_id,amount FROM sakila.payment WHERE staff_id=1 LIMIT 50;
													
                                                    #sorting
                                                    
SELECT * FROM sakila.payment ORDER BY amount desc;

SELECT * FROM sakila.payment ORDER BY payment_id desc;

SELECT staff_id,customer_id,amount FROM sakila.payment ORDER BY staff_id;
													
													#AND,OR,NOT,BETWEEN

SELECT * FROM sakila.payment WHERE staff_id=1 AND amount<2;

SELECT customer_id,staff_id,payment_date,amount FROM sakila.payment
WHERE payment_date BETWEEN '2005-05-25' AND '2005-07-15' OR amount<1;

SELECT COUNT(DISTINCT (amount)) FROM sakila.payment;

SELECT * FROM sakila.payment WHERE NOT amount=5.99;	
												
                                                #wild card like '%' and '_'

SELECT * FROM sakila.film;

SELECT DISTINCT special_features FROM sakila.film;

SELECT COUNT(DISTINCT (special_features)) FROM sakila.film;

SELECT title,release_year,special_features 
FROM sakila.film WHERE special_features LIKE 'T%';

SELECT title,release_year,special_features 
FROM sakila.film WHERE special_features LIKE 'T%a';

SELECT title,release_year,special_features 
FROM sakila.film WHERE special_features LIKE 'T__l_r%';

SELECT title,release_year,special_features 
FROM sakila.film WHERE special_features LIKE 'Trailers';

SELECT customer_id,RENTAL_ID FROM sakila.rental;

													#GROUP BY and HAVING

SELECT customer_id,COUNT(rental_id) AS count_rentals
FROM sakila.rental 
WHERE return_date is not null
GROUP BY customer_id
;

SELECT COUNT(rental_id) FROM sakila.rental WHERE customer_id=130 AND return_date is not null;

SELECT customer_id,COUNT(rental_id) AS rental_return
FROM sakila.rental
WHERE return_date IS NULL
GROUP BY customer_id
HAVING COUNT(rental_id)<10
ORDER BY customer_id ;

SELECT replacement_cost,COUNT(rental_rate) AS rent
FROM sakila.film
GROUP BY replacement_cost
HAVING COUNT(rental_rate)>1
ORDER BY replacement_cost DESC;

SELECT staff_id,SUM(amount) AS total
FROM sakila.payment
GROUP BY staff_id
HAVING SUM(amount)>10000
ORDER BY staff_id ASC;



