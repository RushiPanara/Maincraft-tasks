CREATE TABLE customers_new(
    customer_id VARCHAR(50),
    customer_name VARCHAR(255),
    country VARCHAR(50),
	region varchar(50)
);

CREATE TABLE orders_new(
    order_id VARCHAR(50),
    customer_id VARCHAR(50),
    order_date DATE,
    item_name VARCHAR(255),
    sales NUMERIC(10,2),
    quantity INTEGER,
    discount VARCHAR(10),
    profit NUMERIC(10,2)
);

-- monthly perfomance analysis
SELECT
    EXTRACT(YEAR FROM order_date) AS year,
    EXTRACT(MONTH FROM order_date) AS month,
    SUM(sales) AS monthly_sales,
    SUM(profit) AS monthly_profit
FROM orders_new
GROUP BY
    EXTRACT(YEAR FROM order_date),
    EXTRACT(MONTH FROM order_date)
ORDER BY
    year,
    month;

--growth rate calculation
SELECT
    t1.month,
    t1.monthly_sales,
    ROUND(
        ((t1.monthly_sales - t2.monthly_sales) / t2.monthly_sales) * 100,
        2
    ) AS growth_percentage
FROM
(
    SELECT
        EXTRACT(MONTH FROM order_date) AS month,
        SUM(sales) AS monthly_sales
    FROM orders_new
    GROUP BY EXTRACT(MONTH FROM order_date)
) t1
JOIN
(
    SELECT
        EXTRACT(MONTH FROM order_date) AS month,
        SUM(sales) AS monthly_sales
    FROM orders_new
    GROUP BY EXTRACT(MONTH FROM order_date)
) t2
ON t1.month = t2.month + 1
ORDER BY t1.month;

--Using CASE for Business Classification
SELECT
    order_id,
    sales,
    CASE
        WHEN sales > 1000 THEN 'High Value'
        WHEN sales BETWEEN 500 AND 1000 THEN 'Medium Value'
        ELSE 'Low Value'
    END AS order_type
FROM orders_new;

--Identify Underperforming Regions
SELECT
    c.region,
    SUM(o.profit) AS total_profit
FROM orders_new o
JOIN customers_new c
ON o.customer_id = c.customer_id
GROUP BY c.region
HAVING SUM(o.profit) > 1000;






