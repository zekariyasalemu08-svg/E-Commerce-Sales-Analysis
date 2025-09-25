SELECT * FROM electronics_sales.sales_data;

update sales_data
set date = str_to_date(date, '%m/%d/%Y');

alter table sales_data
modify date date;

alter table sales_data
modify discount decimal(5,2);

alter table sales_data
modify sales decimal(10,2);

alter table sales_data
modify profit decimal(10,2);

-- baseline KPI
select 
	count(*) as total_transactions,
	sum(sales) as total_sales,
	sum(profit) as total_profit
from sales_data;

select 
	round(sum(sales) / count(distinct transaction_id), 2) as avg_order_value
from sales_data;
-- Average order value (AOV)

-- Chaking if there is a pattern in customer
select Customer_Name,count(*) as Amount_of_transaction
from sales_data
group by Customer_Name
order by 2 desc
limit 10;

select quantity, count(quantity)
from sales_data
group by 1;
-- Single quantity is sold most of the time

select Customer_Name,sum(sales) as total_sales
from sales_data
group by Customer_Name
order by 2 desc;

-- Which customers make up 80% of the profit
WITH customer_profit AS (
    SELECT customer_name, SUM(profit) AS total_profit
    FROM sales_data
    GROUP BY customer_name
),
ranked_customers AS (
    SELECT 
        customer_name,
        total_profit,
        SUM(total_profit) OVER (ORDER BY total_profit DESC) AS running_profit,
        SUM(total_profit) OVER () AS grand_total
    FROM customer_profit
)
SELECT 
    customer_name,
    total_profit,
    ROUND(running_profit / grand_total * 100, 2) AS cumulative_pct
FROM ranked_customers
WHERE running_profit / grand_total <= 0.80;


WITH customer_profit AS (
    SELECT customer_name, SUM(profit) AS total_profit
    FROM sales_data
    GROUP BY customer_name
),
ranked_customers AS (
    SELECT 
        customer_name,
        total_profit,
        ROW_NUMBER() OVER (ORDER BY total_profit DESC) AS customer_rank,
        SUM(total_profit) OVER (ORDER BY total_profit DESC) AS running_profit,
        SUM(total_profit) OVER () AS grand_total
    FROM customer_profit
)
SELECT 
    COUNT(*) AS customers_to_80_percent,
    ROUND( (COUNT(*) * 1.0 / (SELECT COUNT(*) FROM customer_profit)) * 100, 2) AS percent_of_customers
FROM ranked_customers
WHERE running_profit / grand_total <= 0.80;
-- We get 80% of profit from Only 20% of Customers


-- chaking if I find insights in the city
select City,sum(quantity) as amount_sold,sum(sales),sum(profit)
from sales_data
group by City
order by 2 desc;
-- johannesburg has the best sales record and then cape town follows
-- The two have distinictively higher sales 

select City,avg(profit/sales*100) as profit_margin
from sales_data
group by city
order by 2 desc;
-- also johannesburg has the highest profit margin

select brand,sum(quantity) as Amount_sold,sum(sales),sum(profit),avg(profit/sales*100) as profit_margin
from sales_data
group by brand
order by 2 desc;
-- samsung has the highest ammount sold
-- Apple has the highest profit margin

select Product,sum(quantity) as Amount_sold,sum(sales),sum(profit),avg(profit/sales*100) as profit_margin
from sales_data
group by product
order by 2 desc;
-- mobile phone has highest amount sold 
-- mobile phone also has the highest sales and profit share
-- Tablet is overall unprofitable product

select discount,sum(quantity) as Amount_sold,sum(sales),avg(profit),avg(profit/sales*100) as profit_margin
from sales_data
group by discount
order by 1;
-- The average profit significantly drops for discounts above or equal to 0.30 


-- Premium vs non-premium Analysis
select Is_Premium,sum(quantity) as Amount_sold,sum(sales) as total_sales,
	sum(profit) as total_profit,avg(profit/sales*100) as profit_margin
from sales_data
group by Is_Premium
order by 2 desc;

select is_premium, sum(quantity) as Amount_sold,
	round(sum(quantity)*100.0 / 
    (select sum(quantity)
    from sales_data),0) as percent_of_units,
    sum(profit) as total_profit,
    round(sum(profit) *100.0 / 
    (select sum(profit)
    from sales_data),0) as percent_of_profit
from sales_data
group by is_premium;
-- Premium products account for only 28% of the sales but make up 73% of the profit share 


-- This is the same analysis as the above, i did it just to show off
SELECT 
    is_premium,
    SUM(quantity) AS total_units,
    ROUND(SUM(quantity) * 100.0 / SUM(SUM(quantity)) OVER ()  ,0) AS percent_of_units,
    SUM(profit) AS total_profit,
    ROUND(SUM(profit) * 100.0 / SUM(SUM(profit)) OVER (), 0) AS percent_of_profit
FROM sales_data
GROUP BY is_premium;


-- Trend through the year
select month(date),sum(quantity) as Amount_sold,sum(sales),sum(profit)
from sales_data
group by month(date)
order by 1;
-- profit has signifacntly decreased in the last four months
-- But Amount sold and sales have more of the same trend through out the year

select month(date),Is_Premium,count(quantity) as Amount_sold,sum(sales),sum(profit)
from sales_data
group by month(date), is_premium
having Is_Premium = 'true'
order by 1;
-- Amount of premium products sold have dropped in the last four months
-- and these products are the ones that drive most of the profit
-- did you see where i am going with this...

select month(date),avg(profit/sales*100) as profit_margin,sum(quantity) as Amount_sold
from sales_data
group by month(date)
order by 1;

select month(date),avg(discount), avg(profit)
from sales_data
group by month(date)
order by 1;
-- The average discount rate has no significant change on all months


SELECT 
    MONTH(date) AS month,
    SUM(CASE WHEN city = 'Johannesburg' THEN 1 ELSE 0 END) AS Johannesburg,
    SUM(CASE WHEN city = 'Cape Town' THEN 1 ELSE 0 END) AS Cape_Town,
    SUM(CASE WHEN city = 'Durban' THEN 1 ELSE 0 END) AS Durban,
    SUM(CASE WHEN city = 'Pretoria' THEN 1 ELSE 0 END) AS Pretoria,
    SUM(CASE WHEN city = 'Port Elizabeth' THEN 1 ELSE 0 END) AS Port_Elizabeth,
    SUM(CASE WHEN city = 'Bloemfontein' THEN 1 ELSE 0 END) AS Bloemfontein
FROM sales_data
GROUP BY MONTH(date)
ORDER BY month;
-- There is no significant variation in Amount sold in all cities throughout the year

alter table sales_data
add column profit_margin decimal(5,2);
update sales_data
set profit_margin = 
	case 
		when sales > 0 then (profit / sales) 
        else 0
	end;