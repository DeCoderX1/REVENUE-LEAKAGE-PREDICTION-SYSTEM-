-- Load data Manualy:

create database revenue_prediction;
use revenue_prediction;

-- sales data Import:
DROP TABLE IF EXISTS sales_orders;
CREATE TABLE sales_orders (
    order_id VARCHAR(20),
    order_date DATE,
    product VARCHAR(50),
    region VARCHAR(20),
    salesperson_id VARCHAR(10),
    list_price INT,
    approved_discount_pct INT);

SET GLOBAL local_infile = 1;
SHOW VARIABLES LIKE 'local_infile';

LOAD DATA LOCAL INFILE 'C:/mysql_csv/sales_orders.csv'
INTO TABLE sales_orders
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;
SELECT COUNT(*) FROM sales_orders;

-- Invoices:
DROP TABLE IF EXISTS invoices;
CREATE TABLE invoices (
    invoice_id VARCHAR(20),
    order_id VARCHAR(20),
    invoice_date DATE,
    invoice_price INT);
LOAD DATA LOCAL INFILE 'C:/mysql_csv/invoices.csv'
INTO TABLE invoices
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;
SELECT COUNT(*) FROM invoices;


-- SalesPersons:
DROP TABLE IF EXISTS salespersons;
CREATE TABLE salespersons (
    salesperson_id VARCHAR(10),
    salesperson_name VARCHAR(50),
    region VARCHAR(20),
    monthly_target INT);
LOAD DATA LOCAL INFILE 'C:/mysql_csv/salespersons.csv'
INTO TABLE salespersons
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;
SELECT COUNT(*) FROM salespersons;


-- Discount_policy:
DROP TABLE IF EXISTS discount_policy;
CREATE TABLE discount_policy (
    product VARCHAR(50),
    max_discount_pct INT);
LOAD DATA LOCAL INFILE 'C:/mysql_csv/discount_policy.csv'
INTO TABLE discount_policy
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;
SELECT COUNT(*) FROM discount_policy;

SHOW TABLES;


















