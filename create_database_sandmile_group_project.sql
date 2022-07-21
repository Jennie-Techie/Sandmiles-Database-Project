-- Create database for the Sandmile Project

DROP DATABASE IF EXISTS `sandmile_group`;
CREATE DATABASE `sandmile_group`;
USE `sandmile_group`;

SET NAMES utf8 ;
SET character_set_client = utf8mb4 ;
-- Not sure what that code above means, I just copied it because I saw it in the Programming_with_mosh_sql course

-- Creating the employees table
CREATE TABLE `employees` (
`Employee_id` INT NOT NULL AUTO_INCREMENT,
`Firstname` VARCHAR(30) NOT NULL,
`Lastname` VARCHAR(30) NOT NULL,
`Gender` VARCHAR(10) NOT NULL,
`Salary` DECIMAL(10, 2) NOT NULL,
`Marital_Status` VARCHAR(25) NOT NULL,
`Phone` VARCHAR(15) NOT NULL,
`email` VARCHAR(30) NOT NULL,
`Street_address` VARCHAR(50) NOT NULL,
`City` VARCHAR(30) NOT NULL,
`Zipcode` VARCHAR(10) NOT NULL,
PRIMARY KEY (`Employee_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET= utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


-- Creating the customers table
DROP TABLE IF EXISTS `customers`;
CREATE TABLE `customers` (
`Customer_id` INT NOT NULL AUTO_INCREMENT,
`Firstname` VARCHAR(30) NOT NULL,
`Lastname` VARCHAR(30) NOT NULL,
`Gender` VARCHAR(10) NOT NULL,
`Date_of_birth` DATE NOT NULL,
`Street_address` VARCHAR(50) NOT NULL,
`City` VARCHAR(25) NOT NULL,
`Province` VARCHAR(25) NOT NULL,
`Zipcode` VARCHAR(10) NOT NULL,
`Membership` VARCHAR(25) NOT NULL,
`Phone` VARCHAR(15) NOT NULL,
`email` VARCHAR(30) NOT NULL,
PRIMARY KEY (`Customer_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET= utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Creating the department table
DROP TABLE IF EXISTS department;
CREATE TABLE department (
`Dept_id` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
`Dept_name` VARCHAR (30) NOT NULL
) ENGINE=InnoDB;

-- Creating the Work_history table
DROP TABLE IF EXISTS `work_history`;
CREATE TABLE `work_history` (
`Employee_id` INT NOT NULL,
`Dept_id` INT NOT NULL,
`Start_date` DATE NOT NULL,
`End_date` DATE NOT NULL,
`Emp_status` VARCHAR(25) NOT NULL,
`Emp_type` VARCHAR(25),
PRIMARY KEY (`employee_id`, `dept_id`),
INDEX `idx_employees`(employee_id),
INDEX `idx_department`(dept_id),
CONSTRAINT `fk_work_history_employees` FOREIGN KEY (employee_id) REFERENCES employees(employee_id) ON UPDATE CASCADE,
CONSTRAINT `fk_work_history_dept` FOREIGN KEY (dept_id) REFERENCES department(dept_id) ON UPDATE CASCADE 
) ENGINE=InnoDB DEFAULT CHARSET= utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Creating the shippers table
DROP TABLE IF EXISTS shippers;
CREATE TABLE shippers (
	shipper_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    shipper_name VARCHAR (50) NOT NULL
    ) ENGINE=InnoDB;

-- Creating the orders table
DROP TABLE IF EXISTS `orders`;
CREATE TABLE orders (
	order_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    customer_id INT NOT NULL,
    employee_id INT NOT NULL,
    shipper_id INT NOT NULL,
    shipped_date INT NOT NULL,
    status VARCHAR (10) NOT NULL,
INDEX `idx_customer`(customer_id),
INDEX `idx_employee`(employee_id),
INDEX `idx_shipper`(shipper_id),
CONSTRAINT `fk_orders_customers` FOREIGN KEY (customer_id) REFERENCES customers(customer_id) ON UPDATE CASCADE,
CONSTRAINT `fk_orders_employees` FOREIGN KEY (employee_id) REFERENCES employees(employee_id) ON UPDATE CASCADE,
CONSTRAINT `fk_orders_shippers` FOREIGN KEY (shipper_id) REFERENCES shippers(shipper_id) ON UPDATE CASCADE 
) ENGINE=InnoDB DEFAULT CHARSET= utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Creating the product table
DROP TABLE IF EXISTS products;
CREATE TABLE products (
	product_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    product VARCHAR (50) NOT NULL,
    unit_price DECIMAL (10, 2),
    quantity_in_stock INT
    ) ENGINE=InnoDB;     

-- Creating the payment table
DROP TABLE IF EXISTS payment;
CREATE TABLE payment (
	payment_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    customer_id INT NOT NULL,
    payment_method INT NOT NULL,
    payment_date DATE NOT NULL,
    quantity INT NOT NULL,
INDEX  `idx_customer`(customer_id),
CONSTRAINT `fk_payment_customers`FOREIGN KEY (customer_id) REFERENCES customers(customer_id) ON UPDATE CASCADE
)ENGINE=InnoDB;


-- Creating the order details table
DROP TABLE IF EXISTS order_details;
CREATE TABLE order_details (
	order_id INT NOT NULL,
    product_id INT NOT NULL,
    payment_id INT NOT NULL,
PRIMARY KEY (`order_id`,`product_id`),
INDEX `idx_orders`(order_id),
INDEX `idx_product`(product_id),
INDEX `idx_payment`(payment_id),
CONSTRAINT `fk_orders_details_orders` FOREIGN KEY (order_id) REFERENCES orders(order_id) ON UPDATE CASCADE,
CONSTRAINT `fk_orders_details_products` FOREIGN KEY (product_id) REFERENCES products(product_id) ON UPDATE CASCADE,
CONSTRAINT `fk_orders_details_payment` FOREIGN KEY (payment_id) REFERENCES payment(payment_id) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET= utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


