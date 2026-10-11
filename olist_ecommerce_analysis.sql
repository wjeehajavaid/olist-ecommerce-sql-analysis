SHOW VARIABLES LIKE 'local_infile';
SET GLOBAL local_infile = 1;
USE ecommerce_sql;
SHOW TABLES;
DESC olist_customers_dataset;
SELECT * FROM olist_customers_dataset LIMIT 10;
SELECT COUNT(*) FROM olist_customers_dataset;
SHOW TABLES;
USE ecommerce_sql;

CREATE TABLE olist_orders_dataset (
    order_id VARCHAR(50),
    customer_id VARCHAR(50),
    order_status VARCHAR(20),
    order_purchase_timestamp DATETIME,
    order_approved_at DATETIME,
    order_delivered_carrier_date DATETIME,
    order_delivered_customer_date DATETIME,
    order_estimated_delivery_date DATETIME
);
SELECT COUNT(*) FROM olist_orders_dataset;
CREATE TABLE olist_order_items_dataset (
    order_id VARCHAR(50),
    order_item_id INT,
    product_id VARCHAR(50),
    seller_id VARCHAR(50),
    shipping_limit_date DATETIME,
    price DECIMAL(10,2),
    freight_value DECIMAL(10,2)
);
SELECT COUNT(*) FROM olist_order_items_dataset;
SHOW TABLES;
SELECT COUNT(*)
FROM olist_orders_dataset o
JOIN olist_customers_dataset c
ON o.customer_id = c.customer_id;

SELECT COUNT(*) AS total_orders
FROM olist_orders_dataset;

SELECT order_status, COUNT(*) AS total_orders
FROM olist_orders_dataset
GROUP BY order_status
ORDER BY total_orders DESC;

SELECT 
    DATE_FORMAT(order_purchase_timestamp, '%Y-%m') AS month,
    COUNT(*) AS total_orders
FROM olist_orders_dataset
GROUP BY month
ORDER BY month;

SELECT 
    c.customer_state,
    COUNT(*) AS total_orders
FROM olist_orders_dataset o
JOIN olist_customers_dataset c
    ON o.customer_id = c.customer_id
GROUP BY c.customer_state
ORDER BY total_orders DESC;

SELECT 
    c.customer_city,
    COUNT(*) AS total_orders
FROM olist_orders_dataset o
JOIN olist_customers_dataset c
    ON o.customer_id = c.customer_id
GROUP BY c.customer_city
ORDER BY total_orders DESC
LIMIT 10;

SELECT 
    ROUND(AVG(DATEDIFF(order_delivered_customer_date, order_purchase_timestamp)), 2) AS avg_delivery_days
FROM olist_orders_dataset
WHERE order_delivered_customer_date IS NOT NULL;

SELECT
    order_status,
    ROUND(AVG(DATEDIFF(order_delivered_customer_date, order_purchase_timestamp)), 2) AS avg_delivery_days
FROM olist_orders_dataset
WHERE order_delivered_customer_date IS NOT NULL
GROUP BY order_status;

SELECT
    DAYNAME(order_purchase_timestamp) AS day_name,
    COUNT(*) AS total_orders
FROM olist_orders_dataset
GROUP BY DAYOFWEEK(order_purchase_timestamp), DAYNAME(order_purchase_timestamp)
ORDER BY DAYOFWEEK(order_purchase_timestamp);

SELECT
    DATE_FORMAT(order_purchase_timestamp, '%Y-%m') AS month,
    order_status,
    COUNT(*) AS total_orders
FROM olist_orders_dataset
GROUP BY month, order_status
ORDER BY month, total_orders DESC;

SELECT
    HOUR(order_purchase_timestamp) AS purchase_hour,
    COUNT(*) AS total_orders
FROM olist_orders_dataset
GROUP BY purchase_hour
ORDER BY total_orders DESC;

SELECT
    c.customer_unique_id,
    COUNT(o.order_id) AS total_orders
FROM olist_orders_dataset o
JOIN olist_customers_dataset c
    ON o.customer_id = c.customer_id
GROUP BY c.customer_unique_id
HAVING COUNT(o.order_id) > 1
ORDER BY total_orders DESC
LIMIT 10;

SELECT
    order_count,
    COUNT(*) AS total_customers
FROM (
    SELECT
        c.customer_unique_id,
        COUNT(o.order_id) AS order_count
    FROM olist_orders_dataset o
    JOIN olist_customers_dataset c
        ON o.customer_id = c.customer_id
    GROUP BY c.customer_unique_id
) AS customer_orders
GROUP BY order_count
ORDER BY order_count;

SELECT
    COUNT(*) AS total_customers,
    SUM(order_count > 1) AS repeat_customers,
    ROUND(
        SUM(order_count > 1) * 100.0 / COUNT(*), 2
    ) AS repeat_customer_percentage
FROM (
    SELECT
        c.customer_unique_id,
        COUNT(o.order_id) AS order_count
    FROM olist_orders_dataset o
    JOIN olist_customers_dataset c
        ON o.customer_id = c.customer_id
    GROUP BY c.customer_unique_id
) AS customer_orders;