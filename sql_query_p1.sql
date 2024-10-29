--Data Exploration--
---how many we have?---
select count(*) from retail_sales

---how many customer we have?--
select count(*) as total_sales from retail_sales 

---how many unique customer we have?--

select count(distinct customer_id ) from  retail_sales 


---Data analysis & business key problem & answer--

--My analysis & findings 
--Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05'

select * from retail_sales 
where sale_date = '2022-11-05'

--Q.2 Write a SQL query to retrieve all transactions where the category 'clothing' and the quantity sold more then 5 in month of nov-2022

select *
from retail_sales
where to_char(sale_date,'yyyy-mm')= '2022-11'
and quantiy >= 4 and category= 'Clothing'

--Q.3 Write a SQL query to calculate the total sales (total_sale) for the category.

select category, sum(total_sale) as total_sales from retail_sales
group by category
order by total_sales desc

--Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.

select round(avg(age),2) from retail_sales
where category='Beauty'

--Q.5 Write a SQL query to find  all transactions where the total_sale isgreater than 1000.

select * from retail_sales
where total_sale > 1000
order by total_sale desc

--Q.6 Write a SQL query to find the total number of transactions(transactions_id ) made by each gender in each category.

select gender , category , count(*) from retail_sales
group by gender, category

--Q.7 Write a SQL query to calculate the avg sale for each month. find out best selling month in year 
select * from 
(
select extract(year from sale_date) as year,
extract( month from sale_date) as month, avg(total_sale) as avg_sale,
rank() over (partition by extract(year from sale_date)order by avg(total_sale) desc ) as rank 
from retail_sales
group by year, month
) as t1
where rank= 1

--Q.8 Write a SQL query to find the top  customers based on the highest total sale.

select customer_id, sum(total_sale) total_sales
from retail_sales
group by customer_id 
order by total_sales desc
limit 5


--Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.

select category, count ( distinct customer_id ) from retail_sales
group by category 

--Q.8 Write a SQL query to create each shift and number of orders (example morning < 12, afternoon between 12 &17, evening>17)

with hourly_sale
as
(
select *,
case 
when extract(hour from sale_time) <12 then 'Morning'
when extract(hour from sale_time) between 12 and 17 then 'Afternoon'
else 'Evening'
end as shift 
from retail_sales
)
select shift,count(*) as total_orders
from hourly_sale
group by shift 


-----------END OF PROJECT------------------











