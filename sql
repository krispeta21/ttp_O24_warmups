-- HINT: For all of these exercises, you'll need to google
-- *postgres's* standard deviation function.
-- There's 3, 1 of them doesn't work, and one of them is more
-- appropriate. Try to pick the best one.


-- 1) Get the average and standard deviation of purchase amounts 
-- in our database.
-- Write down these numbers.

SELECT AVG(amount) FROM payment

AVG:  4.20

SELECT stddev_pop(amount) FROM payment

STDEV = 2.37

-- 2) Get the average purchase per employee, as well as the standard
-- deviation.

SELECT 
staff_id, AVG(amount), STDDEV(amount)
FROM 
payment
GROUP BY 
staff_id
ORDER BY staff_id;


 staff_id |        avg         |       stddev       
----------+--------------------+--------------------
        1 | 4.1486725178277564 | 2.3657470940165390
        2 | 4.2524534501642935 | 2.3711618563719162
(2 rows)


-- Based on these numbers, do you think there's any meaningful
-- difference between the natural of transactions they handle?

No, it seems like they are both close to the mean- almost equidistant from the mean with staff 2 avg. purchases slightly above average and staff 1 avg purchases slightly below average.




-- 3) Get the average purchase for each customer, as well as the standard
-- deviation.

SELECT 
customer_id, ROUND(AVG(amount),2) as AVG, ROUND(stddev(amount), 2) AS STDDEV
FROM 
payment
GROUP BY 
customer_id
ORDER BY AVG
LIMIT 10;

-- Which customer is the most / least predictable in their behavior?
-- hint: think about standard deviation.

Customer 330 has the lowest standard deviation so this customer is most predictable. Customer 542 has the widest spread (high standard deviation) so this customer is the least predictable. 

SELECT 
customer_id, ROUND(AVG(amount),2) as AVG, ROUND(stddev(amount), 2) AS STDDEV
FROM 
payment
GROUP BY 
customer_id
ORDER BY STDDEV DESC
LIMIT 1;


 customer_id | avg  | stddev 
-------------+------+--------
         542 | 5.30 |   3.42


SELECT 
customer_id, ROUND(AVG(amount),2) as AVG, ROUND(stddev(amount), 2) AS STDDEV
FROM 
payment
GROUP BY 
customer_id
ORDER BY STDDEV ASC
LIMIT 1;


 customer_id | avg  | stddev 
-------------+------+--------
         330 | 3.38 |   1.38


-- 4) what is the average and standard deviation for the number of 
-- purchases per customer?

-- Based on this, can you say anything about 'typical' customer
-- behavior? (For the sake of this, let's assume all purchases
-- were made in the past year.)
-- Don't need to be super specific about this.


WITH purchases AS (
	SELECT 
	customer_id, COUNT(payment_id) as purchase_number
	FROM 
	payment
	GROUP BY 
	customer_id)

SELECT 
AVG(purchase_number), stddev_pop(purchase_number)
FROM 
purchases;


         avg         |     stddev_pop     
---------------------+--------------------
 24.3672787979966611 | 5.0877440652536527
(1 row)




The typical customers makes around 24 purchases/rentals per year.
