CREATE TABLE sales (
order_id VARCHAR(50),
order_date DATE,
customer_name VARCHAR(100),
region VARCHAR(50),
category VARCHAR(50),
sales DECIMAL(10,2),
quantity INT,
profit DECIMAL(10,2),
discount VARCHAR(10)
);

SELECT * FROM sales;

SELECT region, SUM(sales) AS total_sales FROM sales GROUP BY region;

SELECT category, SUM(profit) as total_profit from sales group by category order by total_profit desc limit 5;

select EXTRACT(MONTH FROM order_date) as month, sum(sales) as total_sales from sales group by month order by month;

select discount, avg(profit) from sales group by discount;