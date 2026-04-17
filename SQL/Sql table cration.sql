USE retail_analytics;
CREATE TABLE dim_date (
    date_id INT AUTO_INCREMENT PRIMARY KEY,
    date_key INT NOT NULL UNIQUE,
    full_date DATE NOT NULL,
    year SMALLINT,
    quarter TINYINT,
    month TINYINT,
    month_name VARCHAR(15),
    day TINYINT,
    day_name VARCHAR(15),
    week_of_year TINYINT
);
CREATE TABLE dim_product (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    stock_code VARCHAR(20) NOT NULL UNIQUE,
    description VARCHAR(255)
);
CREATE TABLE dim_country (
    country_id INT AUTO_INCREMENT PRIMARY KEY,
    country_name VARCHAR(80) NOT NULL UNIQUE,
    is_uk BOOLEAN
);
CREATE TABLE dim_customer (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_code INT NOT NULL UNIQUE
);
CREATE TABLE fact_sales (
    sales_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    invoice_no VARCHAR(20) NOT NULL,
    invoice_line_no INT NOT NULL,
    date_id INT NOT NULL,
    product_id INT NOT NULL,
    customer_id INT NOT NULL,
    country_id INT NOT NULL,
    quantity INT NOT NULL,
    unit_price DECIMAL(10,2) NOT NULL,
    revenue DECIMAL(12,2) NOT NULL,
    FOREIGN KEY (date_id) REFERENCES dim_date(date_id),
    FOREIGN KEY (product_id) REFERENCES dim_product(product_id),
    FOREIGN KEY (customer_id) REFERENCES dim_customer(customer_id),
    FOREIGN KEY (country_id) REFERENCES dim_country(country_id),
    UNIQUE(invoice_no, invoice_line_no)
);
show tables;

