CREATE TABLE customers(
    customer_id VARCHAR(50),
    customer_name VARCHAR(255),
    country VARCHAR(50)
);

CREATE TABLE orders(
    order_id VARCHAR(50),
    customer_id VARCHAR(50),
    order_date DATE,
    item_name VARCHAR(255),
    sales NUMERIC(10,2),
    quantity INTEGER,
    discount VARCHAR(10),
    profit NUMERIC(10,2)
);

--perform inner join

select o.order_id,o.order_date,o.customer_id,
o.item_name,o.sales ,o.profit from orders o inner join 
customers c on o.customer_id=c.customer_id;


--Total sales by country

select c.country,sum(o.sales) as total_sales 
from orders o join customers c on o.customer_id=c.customer_id
group by c.country;


--monthly sales trend

select EXTRACT(MONTH FROM order_date) as month,
sum(sales) as monthly_sales from orders
group by month order by month;


--top 5 customers by revenue

select c.customer_name, sum(o.sales) as total_revenue
from orders o join customers c on o.customer_id=c.customer_id
group by c.customer_name order by total_revenue desc limit 5;

