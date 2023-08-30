USE dannydiner; 
-- Create tables
CREATE TABLE sales (
  customer_id VARCHAR(1),
  order_date DATE,
  product_id INTEGER
);

INSERT INTO sales
  (customer_id, order_date, product_id)
VALUES
  ('A', '2021-01-01', '1'),
  ('A', '2021-01-01', '2'),
  ('A', '2021-01-07', '2'),
  ('A', '2021-01-10', '3'),
  ('A', '2021-01-11', '3'),
  ('A', '2021-01-11', '3'),
  ('B', '2021-01-01', '2'),
  ('B', '2021-01-02', '2'),
  ('B', '2021-01-04', '1'),
  ('B', '2021-01-11', '1'),
  ('B', '2021-01-16', '3'),
  ('B', '2021-02-01', '3'),
  ('C', '2021-01-01', '3'),
  ('C', '2021-01-01', '3'),
  ('C', '2021-01-07', '3');
 

CREATE TABLE menu (
  product_id INTEGER,
  product_name VARCHAR(5),
  price INTEGER
);

INSERT INTO menu
  (product_id, product_name, price)
VALUES
  ('1', 'sushi', '10'),
  ('2', 'curry', '15'),
  ('3', 'ramen', '12');
  

CREATE TABLE members (
  customer_id VARCHAR(1),
  join_date DATE
);

INSERT INTO members
  (customer_id, join_date)
VALUES
  ('A', '2021-01-07'),
  ('B', '2021-01-09');
  
-- Case Study Questions 
-- 1. What is the total amount each customer spent at the restaurant? 
SELECT s.customer_id, CONCAT('$', SUM(m.price)) total_spend
FROM sales as s JOIN menu as m
ON s.product_id = m.product_id
GROUP BY s.customer_id
ORDER BY total_spend DESC;

-- 2. How many days has each customer visited the restaurant?
SELECT customer_id, CONCAT(COUNT(DISTINCT order_date),' ', 'days') as visit_count
FROM sales
GROUP BY customer_id
ORDER BY visit_count DESC; 

-- 3. What is the first item from the menu purchased by each customer?
SELECT customer, product
FROM 
(SELECT s.customer_id customer , s.order_date order_date, m.product_name product, 
ROW_NUMBER() OVER(PARTITION BY s.customer_id ORDER BY s.order_date) AS row_num
FROM sales s JOIN menu m 
ON s.product_id = m.product_id) temp_table
WHERE row_num = 1;

-- 4. What is the most purchased item on the menu and how many times was it purchased by all customers?
SELECT m.product_name as product, COUNT(s.product_id) as most_purchased, CONCAT( '$', SUM(m.price)) as total_price
FROM sales s JOIN menu m ON s.product_id = m.product_id
GROUP BY product
ORDER BY most_purchased DESC, total_price
LIMIT 1;

-- 5. Which item was the most popular for each customer? 
SELECT customer, product_name, no_of_purchases FROM
(SELECT s.customer_id customer, m.product_name, COUNT(s.product_id) no_of_purchases,
DENSE_RANK() OVER(PARTITION BY s.customer_id ORDER BY COUNT(s.product_id) DESC) AS pop_purchase
FROM sales AS s
JOIN menu AS m
ON s.product_id = m.product_id
GROUP BY customer, s.product_id) temp_table1
WHERE pop_purchase = 1;

-- 6. Which item was purchased first by the customer after they became a member?
SELECT customer, product_name
FROM 
(SELECT s.customer_id customer, m.product_name, s.order_date, 
ROW_NUMBER() OVER(PARTITION BY s.customer_id ORDER BY order_date) as row_num
FROM menu m JOIN sales s 
ON s.product_id = m.product_id 
JOIN members mem 
ON mem.customer_id = s.customer_id
WHERE mem.join_date <= s.order_date
ORDER BY s.customer_id, m.product_name) temp_table2
WHERE row_num = 1; 

-- 7. Which item was purchased just before the customer became a member? 
SELECT customer, product_name 
FROM 
(SELECT s.customer_id customer, m.product_name, s.order_date,
ROW_NUMBER() OVER (PARTITION BY s.customer_id ORDER BY order_date DESC) AS row_num
FROM menu as m JOIN sales as s ON s.product_id = m.product_id
JOIN members as mem ON mem.customer_id = s.customer_id
WHERE mem.join_date > s.order_date
ORDER BY customer, s.order_date) temp_table3
WHERE row_num = 1; 

-- 8. What is the total items and and amount spent for each member before they became a member?
SELECT s.customer_id customer, COUNT(s.product_id) purchases, CONCAT('$', SUM(m.price)) as amt_spent
FROM menu m JOIN sales s ON s.product_id = m.product_id
JOIN members as mem ON s.customer_id = mem.customer_id
WHERE mem.join_date > s.order_date
GROUP BY s.customer_id
ORDER BY purchases, amt_spent DESC;

-- 9. If each $1 spent equates to 10 points and sushi has a 2x points multiplier — how many points would each customer have?
SELECT customer, CONCAT(SUM(points), ' ', 'points') total_tally
FROM 
(SELECT s.customer_id customer, s.product_id, m.product_name, m.price, 
CASE WHEN m.product_name = 'sushi' THEN price * 20 
ELSE price * 10 END AS points
FROM sales as s JOIN menu as M
ON s.product_id = m.product_id) temp_table4
GROUP BY customer;
  