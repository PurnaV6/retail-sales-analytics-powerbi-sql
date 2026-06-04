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
CREATE TABLE sales_forecast (
    forecast_date DATE PRIMARY KEY,
    actual_revenue DECIMAL(12,2),
    predicted_revenue DECIMAL(12,2),
    lower_bound DECIMAL(12,2),
    upper_bound DECIMAL(12,2)
);

CREATE TABLE customer_segments (
    customer_code INT PRIMARY KEY,
    recency INT,
    frequency INT,
    monetary DECIMAL(12,2),
    segment INT,
    segment_label VARCHAR(50)
);

CREATE TABLE sales_anomalies (
    period_date DATE PRIMARY KEY,
    revenue DECIMAL(12,2),
    anomaly_flag INT,
    anomaly_status VARCHAR(50)
);

CREATE TABLE segment_summary (
    segment_label VARCHAR(50) PRIMARY KEY,
    customers INT,
    total_revenue DECIMAL(12,2),
    avg_recency DECIMAL(12,2),
    avg_frequency DECIMAL(12,2)
);

CREATE TABLE product_forecast (
    stock_code VARCHAR(20),
    forecast_date DATE,
    predicted_revenue DECIMAL(12,2),
    stock_action VARCHAR(50)
);

CREATE TABLE market_basket_rules (
    rule_id INT AUTO_INCREMENT PRIMARY KEY,
    antecedents TEXT,
    consequents TEXT,
    support DECIMAL(12,6),
    confidence DECIMAL(12,6),
    lift DECIMAL(12,6),
    recommendation TEXT
);
show tables;


