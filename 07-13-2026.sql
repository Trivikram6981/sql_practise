
SELECT * FROM sakila.inventory;
#join,List all films with their language names
SELECT f.title,l.name 
FROM sakila.film f
JOIN sakila.language l
ON f.language_id=l.language_id;

#join,payment with the customer's full name
SELECT p.payment_id,p.rental_id,p.amount,c.first_name,c.last_name 
FROM sakila.payment p
JOIN sakila.customer c
ON p.customer_id=c.customer_id;


#left join,films with their categories
SELECT f.film_id,f.title,fc.category_id,c.name
FROM sakila.film f
LEFT JOIN sakila.film_category fc
ON f.film_id=fc.film_id
LEFT JOIN sakila.category c
ON fc.category_id=c.category_id;

#left join,never rented films
SELECT f.film_id,f.title,i.inventory_id 
FROM sakila.film f
LEFT JOIN sakila.inventory i
ON f.film_id=i.film_id 
WHERE i.inventory_id IS NULL;


SELECT a.actor_id,a.first_name,a.last_name,fa.film_id,f.title,f.rating
FROM sakila.actor a
LEFT JOIN sakila.film_actor fa
ON a.actor_id=fa.actor_id
LEFT JOIN sakila.film f
ON fa.film_id=f.film_id
ORDER BY a.actor_id ASC;

#right join,payment with staff information
SELECT p.payment_id,p.customer_id,p.amount,s.staff_id,s.first_name,s.last_name 
FROM sakila.payment p
RIGHT JOIN sakila.staff s
ON p.staff_id=s.staff_id
ORDER BY p.payment_id;

#right join,address with no body
SELECT c.customer_id,c.first_name,c.last_name,a.address_id,a.address 
FROM sakila.customer c
RIGHT JOIN sakila.address a
ON c.address_id=a.address_id
WHERE c.first_name IS NULL;


SELECT f.film_id, f.title, i.inventory_id, i.store_id
FROM sakila.film AS f
LEFT JOIN sakila.inventory AS i
ON f.film_id = i.film_id
UNION
SELECT f.film_id, f.title, i.inventory_id, i.store_id
FROM sakila.film AS f
RIGHT JOIN sakila.inventory AS i
ON f.film_id = i.film_id;

#self join,actor with same last name
SELECT a.first_name,a.last_name,b.first_name,b.last_name 
FROM sakila.actor a
JOIN sakila.actor b
ON a.last_name=b.last_name AND a.actor_id<b.actor_id;


#subquery
SELECT*FROM sakila.film 
WHERE rental_rate=(SELECT MAX(rental_rate) FROM sakila.film);

SELECT customer_id,first_name,last_name,
(
SELECT SUM(amount) 
FROM sakila.payment p 
WHERE c.customer_id=p.customer_id
) AS total 
FROM sakila.customer c;

SELECT c.customer_id,c.first_name,c.last_name,SUM(p.amount) AS total
FROM sakila.customer c
JOIN sakila.payment p
ON c.customer_id=p.customer_id
GROUP BY c.customer_id;

#derieved table,sub query
SELECT film_id,rental_count
FROM (
	  SELECT film_id,COUNT(inventory_id) AS rental_count 
	  FROM sakila.inventory 
	  GROUP BY film_id
      ) AS times_film_rented 
WHERE rental_count>5
;

#corelated subquery 
SELECT f.film_id,f.title,f.rating,f.length
FROM sakila.film f 
WHERE length>(
SELECT AVG(length) FROM sakila.film WHERE rating=f.rating
);


SELECT film_id,title,rating,replacement_cost
FROM sakila.film f 
WHERE replacement_cost=(
SELECT MAX(replacement_cost)
FROM sakila.film
WHERE rating=f.rating
);





