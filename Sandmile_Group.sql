USE sandmile_group_db;

								-- USE CASE 1
 --  Add new employee information 
 INSERT INTO employees (Firstname, Lastname, Gender, Salary, Marital_Status, Phone, email, street_address, city, Zipcode)
 VALUES ('Alexia', 'Smith', 'F', '55000', 'married', '945-654-9857', 'alexiasmith2@pbs.com', '4 Ridgeway Valley', 'Brampton', '2484');
 
								-- USE CASE 2
-- Update employee information
UPDATE employees
SET Firstname = 'Brenda', Lastname = 'Olav', Phone = '938-3474-2416'
WHERE Employee_id = 248151; 
 
								-- USE CASE 3
-- Delete employee information 
DELETE FROM employees 
WHERE Firstname = 'Dolly' AND Lastname = 'Day'; 

								-- USE CASE 4
 --  Add new customer information 
 INSERT INTO customers (Firstname, Lastname, Gender, Date_of_birth, Street_address, City, Province, Membership, Phone, email)
 VALUES ('Sunny', 'Blackson', 'M', '2000-01-01', '24 Crayville Road', 'Waterloo', 'Ontario', 'Basic', '805-948-9375', 'sunny44@gmail.com');

						-- USE CASE 5
-- Update customer information
UPDATE customers
SET Firstname = 'Louis', Lastname = 'Magnus', Membership = 'Premuim'
WHERE Customer_id = 12472; 


								-- USE CASE 6
-- Delete Customer information 
DELETE FROM customers 
WHERE Customer_id= 12748; 

								-- USE CASE 7
--  Add new Ddepartment information 
 INSERT INTO department (dept_name)
 VALUES ('Accounts');

								-- USE CASE 8
-- Update department information
UPDATE department
SET dept_name = Customer_Care
WHERE dept_id = 251; 

							-- USE CASE 9
-- Delete department information 
DELETE FROM department 
WHERE dept_id= 251; 

							-- USE CASE 10
 --  Add new order information 
 INSERT INTO orders (customer_id, employee_id, shipper_id, order_date, status)
 VALUES ('12430', '248150', '2353', '2019-01-05', 'Delivered');
 
 								-- USE CASE 11
-- Update order information
UPDATE orders
SET status = Processing
WHERE order_id = 151205; 

						-- USE CASE 12
-- Delete orders information 
DELETE FROM orders
WHERE order_id= 151204; 

							-- USE CASE 13
 --  Add new payment information 
 INSERT INTO payment (customer_id, payment_method, payment_date, quantity)
 VALUES ('12429', 'Debit Card', '2020-05-01', '56');

							-- USE CASE 14
-- Update payment information
UPDATE payment
SET quantity = 35
WHERE payment_id = 5; 

						-- USE CASE 15
-- Delete payment information 
DELETE FROM payment
WHERE payment_id= 4; 

						-- USE CASE 16
 --  Add new shipper information 
 INSERT INTO shippers  (shipper_name)
 VALUES ('Florentine Shipping');

							-- USE CASE 17
-- Update shippers information
UPDATE shippers
SET shipper_name = 'Bella Cruise LTD'
WHERE shipper_id = 2355; 

						-- USE CASE 18
-- Delete shippers information 
DELETE FROM shippers
WHERE shipper_id= 2355; 

				-- USE CASE 19
 --  Add new product information 
 INSERT INTO products (Product, Unit_price, Quantity_in_stock)
 VALUES ('Samsung Dishwasher', '463', '40');

							-- USE CASE 20
-- Update products information
UPDATE products
SET Product = 'Samsung Dryer'
WHERE product_id = 17; 

						-- USE CASE 21
-- Delete products information 
DELETE FROM products
WHERE product_id= 19; 
             
							-- USE CASE 22
-- Generate a report for the HR Manager which shows the top 2 employees with the highest 
-- sales volume for the year 2020 and 2021. Also show the employees with the lowest sales volume for 2020 and 2021.
--  To get the names of the top 2 employees with 
-- the highest sales, use Join to combine the employees table and the orders table (this is to get the name of the
-- employees as well as the orders)
-- Also, use GROUP BY, COUNT, ORDER BY, and LIMIT 
SELECT o.employee_id, e.Firstname, e.Lastname, e.gender, COUNT(*) AS 'Total_Sales'
FROM orders o
JOIN employees e
ON o.employee_id = e.employee_id
WHERE o.order_date BETWEEN '2020-01-01' AND '2021-12-31'
GROUP BY o.employee_id
ORDER BY Total_sales DESC
LIMIT 2;
-- The 2 employees with the highest sales in the YEAR 2020 and 2021 are MYRA WASHINGTON with a total sales of 10
-- and VERNELL CURTIS with a total sales of 8. 

-- To get the 2 lowest performing employees, run the same query but this time Order by ascending as shown below: 
SELECT o.employee_id, e.Firstname, e.Lastname, e.gender, COUNT(*) AS 'Total_Sales'
FROM orders o
JOIN employees e
ON o.employee_id = e.employee_id
WHERE o.order_date BETWEEN '2020-01-01' AND '2021-12-31'
GROUP BY o.employee_id
ORDER BY Total_sales
LIMIT 2;
-- The 2 employees with the lest sales are ODIS WU whose total sales are 2 and Caroline Yadav with total sales of 3
             
							-- 	USER 23
-- Generate a monthly sales report for 2020 for the Sales Manager which shows the sales volume
-- (number of sales made) and Gross Sales (total sales in dollars)
-- To get the Gross Sales per month,the following tables have to be combined using INNER JOINS:
					-- the orders table, 
                    -- order_details table,
                    -- products table 
                    -- payment table would be joined
SELECT
	YEAR(o.order_date) 'Sales Year',
    MONTH(o.order_date) 'Sales Month',
    COUNT(o.order_id) 'Sales Volume',
    SUM(pr.unit_price * p.quantity) 'Gross Sales $'
FROM orders o
	JOIN order_details od
	ON o.order_id = od.Order_id
    JOIN products pr
    ON od.product_id = pr.product_id
    JOIN payment p 
    ON od.Payment_id = p.Payment_id
WHERE o.order_date BETWEEN '2020-01-01' AND '2020-12-31'
GROUP BY
    MONTH(o.order_date);   
    
									-- USE CASE 24
-- Create a report for the Sales Manager that shows the top 3 highest selling products in 2020.
-- To create this report, the following tables would be joined using an INNER JOIN:
		-- orders table
        -- order_details table
        -- products table
        
-- This query below gives the top 3 higest selling product by gross sales
SELECT
	YEAR(o.order_date) 'Year',
    pr.product_id,
    pr.product AS 'Top Selling',
    pr.Unit_price,
    SUM(pr.unit_price * p.quantity) 'Sales $'
FROM orders o
	JOIN order_details od
	ON o.order_id = od.Order_id
    JOIN products pr
    ON od.product_id = pr.product_id
    JOIN payment p 
    ON od.Payment_id = p.Payment_id
    JOIN customers c
    ON p.customer_id = c.customer_id
WHERE o.order_date BETWEEN '2020-01-01' AND '2020-12-31'
GROUP BY
    c.customer_id
ORDER BY SUM(pr.unit_price * p.quantity) DESC
LIMIT 3 ;   

-- This query below gives the top 3 highest selling product by sales volume.
SELECT 
	o.order_id, 
    pr.product_id, 
    pr.product AS 'Top Selling',
    pr.unit_price,
    SUM(p.quantity) AS Sales_Volume
FROM orders o
	JOIN order_details od
	ON o.Order_id = od.Order_id
    JOIN products pr
    ON od.Product_id = pr.Product_id
    JOIN payment p
    ON od.payment_id = p.payment_id
WHERE o.order_date BETWEEN '2020-01-01' AND '2020-12-31'
GROUP BY pr.Product
ORDER BY SUM(p.quantity) DESC
LIMIT 3;
-- The above query returns LG Dryer, Iphone and AA Batteries as the Top 3 Selling Products in 2020. 

							-- USE CASE 25
-- This query below gives the most profitable customers in 2020 by gross sales
SELECT
	YEAR(o.order_date) 'Year',
    c.customer_id,
    c.firstname,
    c.lastname,
    SUM(pr.unit_price * p.quantity) 'Purchase $'
FROM orders o
	JOIN order_details od
	ON o.order_id = od.Order_id
    JOIN products pr
    ON od.product_id = pr.product_id
    JOIN payment p 
    ON od.Payment_id = p.Payment_id
    JOIN customers c
    ON p.customer_id = c.customer_id
WHERE o.order_date BETWEEN '2020-01-01' AND '2020-12-31'
GROUP BY
    c.customer_id
ORDER BY SUM(pr.unit_price * p.quantity) DESC ;   

-- To get the least profitable customers by gross sales, use the query below
SELECT
	YEAR(o.order_date) 'Year',
    c.customer_id,
    c.firstname,
    c.lastname,
    SUM(pr.unit_price * p.quantity) 'Purchase $'
FROM orders o
	JOIN order_details od
	ON o.order_id = od.Order_id
    JOIN products pr
    ON od.product_id = pr.product_id
    JOIN payment p 
    ON od.Payment_id = p.Payment_id
    JOIN customers c
    ON p.customer_id = c.customer_id
WHERE o.order_date BETWEEN '2020-01-01' AND '2020-12-31'
GROUP BY
    c.customer_id
ORDER BY SUM(pr.unit_price * p.quantity);   

						-- USE CASE 26
-- Generate a report for the Sales Manager that shows the most frequent means of payment by customers.
SELECT
    p.payment_method,
    COUNT(p.payment_method) AS 'Frequency'
FROM orders o
	JOIN order_details od
	ON o.order_id = od.Order_id
    JOIN payment p 
    ON od.Payment_id = p.Payment_id
GROUP BY
    p.payment_method
ORDER BY COUNT(p.payment_method)  DESC;   

					-- USE CASE 27
-- Generate a report for the marketing manager that shows the most common age demographic of customers
SELECT 
	YEAR(date_of_birth),
    COUNT(YEAR(date_of_birth)) AS 'Frequency'
FROM customers
GROUP BY YEAR(Date_of_birth)
ORDER BY COUNT(YEAR(date_of_birth)) DESC;


					-- RELATION IN MYSQL
-- CUSTOMERS RELATION
SELECT * FROM customers;

-- DEPARTMENT RELATION
SELECT * FROM department;

-- EMPLOYEES RELATION
SELECT * FROM employees;

-- ORDER_DETAILS RELATION
SELECT * FROM order_details;

-- ORDERS RELATION
SELECT * FROM orders;

-- PAYMENT RELATION
SELECT * FROM payment;

-- PRODUCTS RELATION
SELECT * FROM products;

-- SHIPPERS RELATION
SELECT * FROM shippers;


-- WORK_HISTORY RELATION
SELECT * FROM work_history;
--                              QUERY 1
-- Generate a report for the HR Manager which shows the top 2 employees with the highest sales volume for the year 2020 and 2021.
-- Also show the employees with the lowest sales volume for 2020 and 2021.

-- To get the names of the top 2 employees with the highest sales, use Join to combine the employees table and the orders table (this is to get the name of the
-- employees as well as the orders)
-- Also, use GROUP BY, COUNT, ORDER BY, and LIMIT 
SELECT o.employee_id, e.Firstname, e.Lastname, e.gender, COUNT(*) AS 'Total_Sales'
FROM orders o
JOIN employees e
ON o.employee_id = e.employee_id
WHERE o.order_date BETWEEN '2020-01-01' AND '2021-12-31'
GROUP BY o.employee_id
ORDER BY Total_sales DESC
LIMIT 2;
-- The 2 employees with the highest sales in the YEAR 2020 and 2021 are MYRA WASHINGTON with a total sales of 10
-- and VERNELL CURTIS with a total sales of 8. 

-- To get the 2 lowest performing employees, run the same query but this time Order by ascending as shown below: 
SELECT o.employee_id, e.Firstname, e.Lastname, e.gender, COUNT(*) AS 'Total_Sales'
FROM orders o
JOIN employees e
ON o.employee_id = e.employee_id
WHERE o.order_date BETWEEN '2020-01-01' AND '2021-12-31'
GROUP BY o.employee_id
ORDER BY Total_sales
LIMIT 2;
-- The 2 employees with the lest sales are ODIS WU whose total sales are 2 and Caroline Yadav with total sales of 3. 

--                                 QUERY 2
-- Generate a monthly sales report for 2020 for the Sales Manager which shows the sales volume
-- (number of sales made) and Gross Sales (total sales in dollars)
-- To get the Gross Sales per month,the following tables have to be combined using INNER JOINS:
					-- the orders table, 
                    -- order_details table,
                    -- products table 
                    -- payment table would be joined
SELECT
	YEAR(o.order_date) 'Sales Year',
    MONTH(o.order_date) 'Sales Month',
    COUNT(o.order_id) 'Sales Volume',
    SUM(pr.unit_price * p.quantity) 'Gross Sales $'
FROM orders o
	JOIN order_details od
	ON o.order_id = od.Order_id
    JOIN products pr
    ON od.product_id = pr.product_id
    JOIN payment p 
    ON od.Payment_id = p.Payment_id
WHERE o.order_date BETWEEN '2020-01-01' AND '2020-12-31'
GROUP BY
    MONTH(o.order_date);   

-- QUERY 3
-- Create a report for the Sales Manager that shows the top 3 highest selling products in 2020.
-- To create this report, the following tables would be joined using an INNER JOIN:
		-- orders table
        -- order_details table
        -- products table
        
-- This query below gives the top 3 higest selling product by gross sales
SELECT
	YEAR(o.order_date) 'Year',
    pr.product_id,
    pr.product AS 'Top Selling',
    pr.Unit_price,
    SUM(pr.unit_price * p.quantity) 'Sales $'
FROM orders o
	JOIN order_details od
	ON o.order_id = od.Order_id
    JOIN products pr
    ON od.product_id = pr.product_id
    JOIN payment p 
    ON od.Payment_id = p.Payment_id
    JOIN customers c
    ON p.customer_id = c.customer_id
WHERE o.order_date BETWEEN '2020-01-01' AND '2020-12-31'
GROUP BY
    c.customer_id
ORDER BY SUM(pr.unit_price * p.quantity) DESC
LIMIT 3 ;   

-- This query below gives the top 3 highest selling product by sales volume.
SELECT 
	o.order_id, 
    pr.product_id, 
    pr.product AS 'Top Selling',
    pr.unit_price,
    SUM(p.quantity) AS Sales_Volume
FROM orders o
	JOIN order_details od
	ON o.Order_id = od.Order_id
    JOIN products pr
    ON od.Product_id = pr.Product_id
    JOIN payment p
    ON od.payment_id = p.payment_id
-- WHERE o.order_date BETWEEN '2020-01-01' AND '2020-12-31'
GROUP BY pr.Product
ORDER BY SUM(p.quantity) DESC
LIMIT 3;
-- The above query returns LG Dryer, Iphone and AA Batteries as the Top 3 Selling Products in 2020. 

							-- QUERY 4

-- Create a report for the Marketing Manager that shows the most profitable customers in 2020. 
-- This query below gives the most profitable customers in 2020 by gross sales
SELECT
	YEAR(o.order_date) 'Year',
    c.customer_id,
    c.firstname,
    c.lastname,
    SUM(pr.unit_price * p.quantity) 'Purchase $'
FROM orders o
	JOIN order_details od
	ON o.order_id = od.Order_id
    JOIN products pr
    ON od.product_id = pr.product_id
    JOIN payment p 
    ON od.Payment_id = p.Payment_id
    JOIN customers c
    ON p.customer_id = c.customer_id
WHERE o.order_date BETWEEN '2020-01-01' AND '2020-12-31'
GROUP BY
    c.customer_id
ORDER BY SUM(pr.unit_price * p.quantity) DESC ;   

-- To get the least profitable customers by gross sales, use the query below
SELECT
	YEAR(o.order_date) 'Year',
    c.customer_id,
    c.firstname,
    c.lastname,
    SUM(pr.unit_price * p.quantity) 'Purchase $'
FROM orders o
	JOIN order_details od
	ON o.order_id = od.Order_id
    JOIN products pr
    ON od.product_id = pr.product_id
    JOIN payment p 
    ON od.Payment_id = p.Payment_id
    JOIN customers c
    ON p.customer_id = c.customer_id
WHERE o.order_date BETWEEN '2020-01-01' AND '2020-12-31'
GROUP BY
    c.customer_id
ORDER BY SUM(pr.unit_price * p.quantity);   


-- Generate a report for the Sales Manager that shows the most frequent means of payment by customers.
SELECT
    p.payment_method,
    COUNT(p.payment_method) AS 'Frequency'
FROM orders o
	JOIN order_details od
	ON o.order_id = od.Order_id
    JOIN payment p 
    ON od.Payment_id = p.Payment_id
-- WHERE o.order_date BETWEEN '2020-01-01' AND '2020-12-31'
GROUP BY
    p.payment_method
ORDER BY COUNT(p.payment_method)  DESC;   

-- Generate a report for the marketing manager that shows the most common age demographic of customers
SELECT 
	YEAR(date_of_birth),
    COUNT(YEAR(date_of_birth)) AS 'Frequency'
FROM customers
GROUP BY YEAR(Date_of_birth)
ORDER BY COUNT(YEAR(date_of_birth)) DESC;

