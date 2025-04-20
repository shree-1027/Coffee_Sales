1. General Stats

-- Total number of orders
SELECT COUNT(*) AS total_orders
FROM coffee_sales;

-- Most ordered coffee
SELECT coffee_name, COUNT(*) AS order_count
FROM coffee_sales
GROUP BY coffee_name
ORDER BY order_count DESC
LIMIT 1;

-- Maximum quantity in a single order
SELECT MAX(quantity) AS most_quantity
FROM coffee_sales;

-- Total revenue generated
SELECT SUM(net_sales) AS total_money
FROM coffee_sales;

-- Total amount before discounts
SELECT SUM(total_amount) AS total_amount
FROM coffee_sales;

-- Highest discount given
SELECT MAX(discount_percent) AS max_discount
FROM coffee_sales;

2. Store & Location Analysis

-- Most ordered store location
SELECT store_location, COUNT(*) AS order_count
FROM coffee_sales
GROUP BY store_location
ORDER BY order_count DESC
LIMIT 1;

-- Store with the highest total net sales
SELECT store_location, SUM(net_sales) AS total_sales
FROM coffee_sales
GROUP BY store_location
ORDER BY total_sales DESC
LIMIT 1;

-- Group by store_location where net_sales > 1000
SELECT store_location, SUM(net_sales) AS total_sales
FROM coffee_sales
GROUP BY store_location
HAVING SUM(net_sales) > 1000;

3. Time & Date Filters

-- Most ordered time
SELECT time, COUNT(*) AS order_count
FROM coffee_sales
GROUP BY time
ORDER BY order_count DESC
LIMIT 1;

-- Retrieve orders between 09:00 and 17:00
SELECT *
FROM coffee_sales
WHERE TIME(time) BETWEEN '09:00:00' AND '17:00:00';

-- Orders earlier than 12 PM
SELECT *
FROM coffee_sales
WHERE TIME(time) < '12:00:00';

-- Orders placed on 2024-03-01
SELECT *
FROM coffee_sales
WHERE date = '2024-03-01';

-- Orders placed on weekends
SELECT *
FROM coffee_sales
WHERE weekday_name IN ('Saturday', 'Sunday');

-- Net sales by date, highest first
SELECT date, SUM(net_sales) AS total_sales
FROM coffee_sales
GROUP BY date
ORDER BY total_sales DESC;

4. Product-Level Insights

-- Orders per coffee type
SELECT coffee_name, COUNT(order_id) AS total_orders
FROM coffee_sales
GROUP BY coffee_name;

-- Coffee types with total revenue > 200
SELECT coffee_name, SUM(net_sales) AS total_revenue
FROM coffee_sales
GROUP BY coffee_name
HAVING SUM(net_sales) > 200;

-- Average quantity ordered per coffee type
SELECT coffee_name, FLOOR(AVG(quantity)) AS avg_qty
FROM coffee_sales
GROUP BY coffee_name;

-- Coffee with the second highest net_sales
SELECT coffee_name, net_sales
FROM coffee_sales
ORDER BY net_sales DESC
LIMIT 1 OFFSET 1;

-- Coffee where name contains "Latte" and quantity > 2
SELECT coffee_name, quantity, order_id 
FROM coffee_sales
WHERE coffee_name LIKE '%Latte%'
AND quantity > 2;

5. Sales, Discounts & Payments

-- Total money spent by card users
SELECT SUM(net_sales) AS total
FROM coffee_sales
WHERE payment_mode = 'Card';

-- Orders using Cash or Card with sales > 20
SELECT *
FROM coffee_sales
WHERE payment_mode IN ('Cash', 'Card')
AND net_sales > 20;

-- Orders where discount < 5% and total_amount > 30
SELECT discount_percent, total_amount 
FROM coffee_sales
WHERE discount_percent < 5
AND total_amount > 30;

6. Customers & Feedback

-- Orders by Old customers
SELECT COUNT(order_id) AS total_Old_customers
FROM coffee_sales
WHERE customer_type = 'Old';

-- Most frequent customer type
SELECT customer_type, COUNT(*) AS order_count
FROM coffee_sales
GROUP BY customer_type
ORDER BY order_count DESC
LIMIT 1;

-- Top 3 Old customer feedbacks
SELECT customer_type, FLOOR(feedback_score) AS rounded_score
FROM coffee_sales
WHERE customer_type = 'Old'
ORDER BY feedback_score DESC
LIMIT 3;

-- Orders where customer_type is NULL
SELECT *
FROM coffee_sales
WHERE customer_type IS NULL;

-- Orders with NULL feedback_score
SELECT *
FROM coffee_sales
WHERE feedback_score IS NULL;

-- Count where discount_percent is NOT NULL
SELECT COUNT(*) AS non_null_discounts
FROM coffee_sales
WHERE discount_percent IS NOT NULL;

7. Conditional Filters

-- Orders from Downtown
SELECT order_id, coffee_name, net_sales, COUNT(store_location) AS store_count
FROM coffee_sales
WHERE store_location = 'Downtown'
GROUP BY order_id, coffee_name, net_sales;

-- New customers with feedback > 4
SELECT order_id, quantity, feedback_score
FROM coffee_sales
WHERE customer_type = 'New'
AND feedback_score > 4;

-- Orders with net_sales between 50 and 100
SELECT *
FROM coffee_sales
WHERE net_sales BETWEEN 50 AND 100;

8. Subqueries

-- Orders with above-average net_sales
SELECT order_id, net_sales
FROM coffee_sales
WHERE net_sales > (SELECT AVG(net_sales) FROM coffee_sales);

-- Orders with net_sales > that of order_id = 100
SELECT order_id, coffee_name, net_sales
FROM coffee_sales
WHERE net_sales > (
    SELECT net_sales
    FROM coffee_sales
    WHERE order_id = 100
);

-- Coffee with highest average feedback
SELECT coffee_name, AVG(feedback_score) AS avg_feedback
FROM coffee_sales
GROUP BY coffee_name
ORDER BY avg_feedback DESC
LIMIT 1;

9. Joins (Assuming External Tables Exist)

-- Join with customers table
SELECT c.customer_name, cs.coffee_name
FROM coffee_sales cs
JOIN customers c ON cs.order_id = c.order_id;

-- Join with store table
SELECT s.store_name, SUM(cs.net_sales) AS total_sales
FROM coffee_sales cs
JOIN store s ON cs.store_location = s.store_location
GROUP BY s.store_name;

-- Join to show all orders with customer details
SELECT cs.*, c.*
FROM coffee_sales cs
INNER JOIN customers c ON cs.order_id = c.order_id;

10. Advanced Aggregations

-- Total orders & average net_sales by store
SELECT store_location,
       COUNT(*) AS total_orders,
       AVG(net_sales) AS avg_sales
FROM coffee_sales
GROUP BY store_location;

-- Store with most orders and total net_sales
SELECT store_location,
       COUNT(*) AS order_count,
       SUM(net_sales) AS total_sales
FROM coffee_sales
GROUP BY store_location
ORDER BY order_count DESC
LIMIT 1;

-- Total quantity and average discount per coffee
SELECT coffee_name,
       SUM(quantity) AS total_quantity,
       AVG(discount_percent) AS avg_discount
FROM coffee_sales
GROUP BY coffee_name;

11. Ranking & Sorting

-- Top 10 highest quantity orders
SELECT quantity, order_id, coffee_name
FROM coffee_sales
ORDER BY quantity DESC
LIMIT 10;

-- Top 5 orders with highest total sales
SELECT SUM(net_sales) AS total_sales, order_id, coffee_name
FROM coffee_sales
GROUP BY order_id, coffee_name
ORDER BY total_sales DESC
LIMIT 5;

-- Orders per weekday
SELECT weekday_name, COUNT(*) AS total_orders
FROM coffee_sales
GROUP BY weekday_name;
