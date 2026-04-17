use retail_analytics;
LOAD DATA LOCAL INFILE "C:/temp/dim_customer.csv"
INTO TABLE dim_customer
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(customer_code);
select count(*) from dim_customer;
LOAD DATA LOCAL INFILE 'C:/temp/dim_country.csv'
INTO TABLE dim_country
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(country_name, is_uk);
select count(*) from dim_country;
LOAD DATA LOCAL INFILE 'C:/temp/dim_product.csv'
INTO TABLE dim_product
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(stock_code, description);
SELECT COUNT(*) FROM dim_product;
LOAD DATA LOCAL INFILE 'C:/temp/dim_product.csv'
INTO TABLE dim_product
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(stock_code, description);
SELECT COUNT(*) FROM dim_product;
CREATE TABLE stg_fact_sales (
    invoice_no VARCHAR(20),
    invoice_line_no INT,
    date_key INT,
    invoice_datetime DATETIME,
    customer_code INT,
    country_name VARCHAR(80),
    stock_code VARCHAR(20),
    quantity INT,
    unit_price DECIMAL(10,2),
    revenue DECIMAL(12,2)
);
LOAD DATA LOCAL INFILE 'C:/temp/fact_sales.csv'
INTO TABLE stg_fact_sales
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(invoice_no, invoice_line_no, date_key, invoice_datetime, customer_code, country_name, stock_code, quantity, unit_price, revenue);
SELECT COUNT(*) AS staging_count FROM stg_fact_sales;
INSERT INTO fact_sales (
    invoice_no,
    invoice_line_no,
    date_id,
    product_id,
    customer_id,
    country_id,
    quantity,
    unit_price,
    revenue
)
SELECT
    s.invoice_no,
    s.invoice_line_no,
    d.date_id,
    p.product_id,
    c.customer_id,
    co.country_id,
    s.quantity,
    s.unit_price,
    s.revenue
FROM stg_fact_sales s
JOIN dim_date d
    ON s.date_key = d.date_key
JOIN dim_product p
    ON s.stock_code = p.stock_code
JOIN dim_customer c
    ON s.customer_code = c.customer_code
JOIN dim_country co
    ON s.country_name = co.country_name;
SELECT COUNT(*) AS fact_count FROM fact_sales;
SELECT ROUND(SUM(revenue), 2) AS total_revenue FROM fact_sales;
SELECT * FROM fact_sales LIMIT 10;