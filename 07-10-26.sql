SELECT * FROM sakila.film;

SELECT title FROM sakila.film;

#RAPD,LPAD
SELECT title,RPAD(title,20,'Ł') AS right_pad FROM sakila.film;

SELECT title,LPAD(title,20,'-') AS left_pad FROM sakila.film;

SELECT title,
RPAD(title,20,'_') AS right_pad,
LPAD(title,20,'=') AS left_pad,
LPAD(RPAD(title,20,'_'),30,'*') AS both_
FROM sakila.film;

SELECT title,
RPAD(title,20,'_') AS right_pad,
LPAD(title,20,'=') AS left_pad,
LPAD(RPAD(title,20,'_'),20,'*') AS both_
FROM sakila.film;

#SUBSTRING
SELECT release_year,SUBSTRING(release_year,3,4) AS yy
FROM sakila.film;

SELECT description,
SUBSTRING(description,1,10) AS upto_10_char,
SUBSTRING(description,10) AS from_10 
FROM sakila.film;

#CONCATINATION
SELECT * FROM sakila.customer;

SELECT 
first_name,last_name,
CONCAT(first_name,' ',last_name) AS full_name 
FROM sakila.customer;

SELECT title,rating,
CONCAT(title,'(',rating,')') AS title_rating
FROM sakila.film;

#LOCATE
SELECT title,LOCATE('A',title) AS position FROM sakila.film;

SELECT active,email,LOCATE('@',email) AS long_name 
FROM sakila.customer
WHERE LOCATE('@',email)>15;

SELECT * FROM sakila.customer;

#SUBSTRING_INDEX
SELECT first_name,last_name,
CONCAT(first_name,' ',last_name) AS full_name,
SUBSTRING_INDEX(CONCAT(first_name,' ',last_name),' ',1) AS before_,
SUBSTRING_INDEX(CONCAT(first_name,' ',last_name),' ',-1) AS after_
FROM sakila.customer;

SELECT first_name,SUBSTRING_INDEX(last_name,'H',1) FROM sakila.customer;

SELECT create_date,
SUBSTRING_INDEX(SUBSTRING(create_date,LOCATE('20',create_date)+2),':',2) AS n
FROM sakila.customer;

SELECT create_date,
SUBSTRING_INDEX(SUBSTRING(create_date,LOCATE('20',create_date)+2),':',-4) AS n
FROM sakila.customer;

#LENGTH
SELECT title,LENGTH(description) AS length_
FROM sakila.film;

SELECT title,LENGTH(description) AS too_long
FROM sakila.film
WHERE LENGTH(description)>96;

#REVERSE
SELECT * FROM sakila.film;

SELECT special_features,REVERSE(special_features) AS reverse_ FROM sakila.film;

SELECT replacement_cost,REVERSE(replacement_cost) AS reverse_ FROM sakila.film;

#CASE
SELECT film_id,title,
CASE
WHEN rental_rate>3.99 THEN 'expensive'
WHEN rental_rate<3.99 THEN 'less than 3.99'
END AS cost
FROM sakila.film;

SELECT * FROM sakila.customer;

SELECT customer_id,first_name,last_name,
CASE
WHEN RIGHT(first_name,1) BETWEEN 'B' and 'M' THEN 'GROUP B-M'
WHEN LEFT(last_name,1) BETWEEN 'N' AND 'Z' THEN 'GROUP N-Z'
ELSE 'OTHER'
END AS 'group' 
FROM sakila.customer;

SELECT title,UPPER(title) AS caps,LOWER(title) AS small FROM sakila.film;

SELECT REPLACE(active,1,'present') FROM sakila.customer;

SELECT last_name,
CASE
WHEN RIGHT(CONCAT(first_name,' ',last_name),1) REGEXP '[AEIOU]$' THEN 'vowel'
ELSE 'consonant'
END AS 'last_letter'
FROM sakila.customer;

SELECT NOW();
SELECT CURDATE()AS today_date;
SELECT YEAR(CURDATE());
SELECT MONTH(CURDATE());
SELECT DAY(NOW());
SELECT DATEDIFF('2002-04-18','2005-12-21');
SELECT DATE(DATE_ADD(DATE_ADD('2005-04-18',INTERVAL 10 DAY),INTERVAL 3 MONTH));
SELECT DATE(DATE_SUB(DATE_ADD('2005-04-18',INTERVAL 10 DAY),INTERVAL 3 MONTH));
SELECT DATE_FORMAT(DATE_ADD(DATE_ADD('2005-04-18',INTERVAL 10 DAY),INTERVAL 3 MONTH),'%D-%M-%Y');
SELECT DATE_FORMAT(DATE_ADD(DATE_ADD('2005-04-18',INTERVAL 10 DAY),INTERVAL 3 MONTH),'%a-%d-%m-%y');
SELECT STR_TO_DATE('2005-18-4','%Y-%d-%m');
SELECT LAST_DAY(CURDATE());

SELECT ABS(-23.16);
SELECT ROUND(PI(),2);
SELECT CEIL(PI());
SELECT FLOOR(PI());
SELECT TRUNCATE(PI(),4);
SELECT MOD(20,2);
SELECT POWER(2,8);
SELECT SQRT(523);
SELECT SQRT(625);
SELECT POWER(625,(1/2));
SELECT TRUNCATE(RAND(),2);
SELECT GREATEST(10,20,40);
SELECT LEAST(10,20,40);

