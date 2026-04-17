SELECT 
    d.year,
    d.month,
    d.month_name,
    ROUND(SUM(f.revenue), 2) AS monthly_revenue
FROM fact_sales f
JOIN dim_date d
    ON f.date_id = d.date_id
GROUP BY d.year, d.month, d.month_name
ORDER BY d.year, d.month;
SELECT 
    p.stock_code,
    p.description,
    ROUND(SUM(f.revenue), 2) AS product_revenue
FROM fact_sales f
JOIN dim_product p
    ON f.product_id = p.product_id
GROUP BY p.stock_code, p.description
ORDER BY product_revenue DESC
LIMIT 10;
SELECT 
    c.customer_code,
    ROUND(SUM(f.revenue), 2) AS customer_revenue
FROM fact_sales f
JOIN dim_customer c
    ON f.customer_id = c.customer_id
GROUP BY c.customer_code
ORDER BY customer_revenue DESC
LIMIT 10;
SELECT 
    co.country_name,
    ROUND(SUM(f.revenue), 2) AS country_revenue
FROM fact_sales f
JOIN dim_country co
    ON f.country_id = co.country_id
GROUP BY co.country_name
ORDER BY country_revenue DESC;