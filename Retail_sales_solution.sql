-- CREATE TABLE
CREATE TABLE retail_table (
  transactions_id INT,
  sale_date DATE,
  sale_time TIME,
  customer_id INT,
  gender VARCHAR(20),
  age INT,
  category VARCHAR(20),
  quantiy INT,
  price_per_unit FLOAT,
  cogs FLOAT,
  total_sale FLOAT
);

-- DATA CLEANING--

SELECT * from retail_table
	WHERE transactions_id IS NULL
	OR sale_date IS NULL
    OR sale_time IS NULL
    OR customer_id IS NULL
    OR gender IS NULL
    OR age IS NULL 
	OR category IS NULL
	OR quantiy IS NULL
	OR price_per_unit IS NULL
	OR cogs IS NULL 
	OR total_sale IS NULL;
    
-- DATA EXPLORATION--

# How many sales we did?
SELECT COUNT(*) FROM retail_table;

#How many unique customers do we have?
SELECT COUNT(distinct(customer_id)) AS unique_customers from retail_table;

# How many categories do we have and what?
SELECT DISTINCT(category) from retail_table;

-- DATA ANALYSIS/ BUSINESS KEY PROBLEMS--

# 1.Write a SQL query to retrieve all columns for sales made on '2022-11-05:
SELECT * FROM retail_table 
WHERE sale_date = '2022-11-05';

# 2.Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022:
SELECT * FROM retail_table 
WHERE category= 'Clothing'
 AND quantiy >= 4
 AND sale_date >= '2022-11-1'
 AND sale_date < '2022-12-1';
 
 
 #3. Write a SQL query to calculate the total sales (total_sale) for each category
 SELECT category,
 SUM(total_sale) AS total_sales 
 From retail_table
 GROUP BY category;
 
 #4. Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.:
 SELECT ROUND(avg(age) , 2) AS avg_age
 From retail_table
 WHERE category= 'Beauty';
 
 #5. Write a SQL query to find all transactions where the total_sale is greater than 1000.
 SELECT * From retail_table 
 WHERE total_sale > '1000';
 
 #6. Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
 SELECT category, gender,  COUNT(transactions_id) as total_trans 
 FROM retail_table
 GROUP BY category, gender
 ORDER BY category, gender;


 
 #7. Write a SQL query to calculate the average sale for each month. Find out best selling month in each year:
	 SELECT 
	 year,
	 month,
	 avg_sales
	 FROM
	 (
	 SELECT YEAR(sale_date) as year,
		 MONTH(sale_date) as month,
		 ROUND(avg(total_sale), 2) as avg_sales,
		 RANK() OVER(
		 PARTITION BY YEAR(sale_date) ORDER BY  avg(total_sale)
		 DESC ) as ranks
	 FROM retail_table
	 GROUP BY year, month
	 )AS T1
	 WHERE ranks=1; 

#8. **Write a SQL query to find the top 5 customers based on the highest total sales **:
SELECT 
customer_id,
SUM(total_sale) as total_sales
from retail_table
group by customer_id
ORDER BY total_sales DESC-- 
LIMIT 5;


#9. Write a SQL query to find the number of unique customers who purchased items from each category.:
SELECT 
category, COUNT(distinct(customer_id)) as dictinct_customers
FROM retail_table
GROUP BY category;

#10. Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17):

SELECT 
shift,
COUNT(transactions_id) as transaction_id
FROM
(
	SELECT *,
	CASE
	WHEN HOUR(sale_time) < 12 THEN 'Morning'
	WHEN HOUR(sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
	ELSE 'Evening'
	END AS shift 
	from retail_table
) AS t
Group BY shift;
 
