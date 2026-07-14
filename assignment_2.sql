USE sakila;
#1. Identify if there are duplicates in Customer table. Don't use customer id to check the duplicates
SELECT email,COUNT(*) AS dup FROM customer
GROUP BY email
HAVING COUNT(*)<1;

#2. Number of times letter 'a' is repeated in film descriptions
SELECT description,
LENGTH(description)-LENGTH(REPLACE(LOWER(description),'a','')) AS a_count
FROM film ;

#3. Number of times each vowel is repeated in film descriptions 
SELECT description,
LENGTH(description)-LENGTH(REPLACE(LOWER(description),'a','')) AS a,
LENGTH(description)-LENGTH(REPLACE(LOWER(description),'e','')) AS e,
LENGTH(description)-LENGTH(REPLACE(LOWER(description),'i','')) AS i,
LENGTH(description)-LENGTH(REPLACE(LOWER(description),'o','')) AS o,
LENGTH(description)-LENGTH(REPLACE(LOWER(description),'u','')) AS u
FROM film;

#4. Display the payments made by each customer  1. Month wise  2. Year wise 3. Week wise
SELECT customer_id,
MONTH(payment_date) AS month,
SUM(amount) AS month_total
FROM payment
GROUP BY customer_id,MONTH(payment_date);

SELECT customer_id,
YEAR(payment_date) AS year,
SUM(amount) AS year_total
FROM payment
GROUP BY customer_id,YEAR(payment_date);

SELECT customer_id,
WEEK(payment_date) AS week,
SUM(amount) AS week_total
FROM payment
GROUP BY customer_id,WEEK(payment_date);

#5. Check if any given year is a leap year or not. You need not consider any table from sakila database. Write within the select query with hardcoded date
SELECT day(last_day('1900-02-21')),
CASE 
WHEN day(last_day('1900-02-21'))=29 THEN 'leap_year'
ELSE 'not'
END AS year_;

#6.Display number of days remaining in the current year from today.
SELECT DATEDIFF('2026-12-31', NOW()) AS days_remaining;

#7. Display quarter number(Q1,Q2,Q3,Q4) for the payment dates from payment table.
SELECT payment_id,CONCAT('Q',QUARTER(payment_date)) AS QUATER FROM payment;

