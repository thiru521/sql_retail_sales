DROP DATABASE sql_project;

CREATE DATABASE SQL_project;

CREATE TABLE retail_sales
(
     transactions_id INT PRIMARY KEY,
     sale_date DATE,
     sale_time TIME,
     customer_id INT,
     gender VARCHAR(15),
     age INT,
     category VARCHAR(15),
     quantity INT,
     price_per_unit FLOAT,
     cogs FLOAT,
     total_sale FLOAT
);     

SELECT * FROM retail_sales;

-- Data cleaning
SELECT * FROM retail_sales
WHERE 
     transactions_id IS NULL
     OR
     sale_date IS NULL
     OR
     sale_time IS NULL
     OR
     customer_id IS NULL
     OR
     gender IS NULL
     OR
     age IS NULL
     OR
     category IS NULL
     OR
     quantity IS NULL
     OR
     price_per_unit IS NULL
     OR
     cogs IS NULL
     OR
     total_sale IS NULL;
     
DELETE FROM retail_sales 
WHERE 
     transactions_id IS NULL
     OR
     sale_date IS NULL
     OR
     sale_time IS NULL
     OR
     customer_id IS NULL
     OR
     gender IS NULL
     OR
     age IS NULL
     OR
     category IS NULL
     OR
     quantity IS NULL
     OR
     price_per_unit IS NULL
     OR
     cogs IS NULL
     OR
     total_sale IS NULL;  
     
SELECT COUNT(*) FROM retail_sales;  

-- Data exploration   

-- How many sales we have
SELECT COUNT(*) AS Total_sales FROM retail_sales;

-- How many customer we have
SELECT COUNT(customer_id) AS Total_sales FROM retail_sales;

SELECT DISTINCT category FROM retail_sales; 


SELECT DISTINCT customer_id FROM retail_sales
WHERE quantity > 3;

-- data Analysis and business problem

-- q.1 write a SQL query to retrieve all columns for sales made on '2022-11-05'
SELECT * FROM retail_sales
WHERE sale_date='2022-11-05';

-- q.2 write a SQL query to retrieve all transactions where the category is 'clothing' and the quantity sold is more than 10 in the month of Nov-2022
SELECT * FROM retail_sales
WHERE category = 'clothing'
      AND 
      quantity >= 4;
      
-- q.3 write a SQL query to calculate the total sales (total_sale) for each category

SELECT 
    category, 
	SUM(total_sale) AS net_sale,
    COUNT(*) AS Total_order
FROM retail_sales
GROUP BY category;

-- q.4 write a SQL query to find the average age of customers who purchased items from the 'Beauty' category
SELECT 
    ROUND(AVG(age), 2) AS avg_age
FROM retail_sales
WHERE category = 'Beauty';    

-- q.5 write a SQL query to find all Transactions where the total_sale is greater than 1000
SELECT * FROM retail_sales
WHERE total_sale > 1000;

-- q.6 write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category
SELECT 
    category,
    gender,
    COUNT(*) AS total_transaction
FROM retail_sales
GROUP BY category, gender
ORDER BY category;

-- q.7 write a SQL query to calculate the avg sale for each month. Find out best selling month in each year
SELECT 
      year,
      month,
      avg_sale
FROM (
   SELECT  
      YEAR(sale_date) AS year,
      MONTH(sale_date) AS month,
      AVG(total_sale) AS avg_sale,
      RANK() OVER (PARTITION BY YEAR(sale_date) ORDER BY avg(total_sale) DESC) AS rnk
FROM retail_sales
GROUP BY year, month
) AS t1
WHERE rnk = 1;
      
     

-- q.8 write a SQL query to find the top 5 customers based on the Highest total sales

SELECT 
      customer_id,
      SUM(total_sale) AS highest_sale
FROM retail_sales
GROUP BY customer_id 
ORDER BY highest_sale DESC
LIMIT 5;
      
      
-- q.9 write a sql query to find the number of unique customers who purchased items from each category

SELECT 
      COUNT(DISTINCT customer_id) AS customer_id,
      category
FROM retail_sales
GROUP BY category;      
      

-- q.10 write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17)

WITH hourly_sale
AS
(
SELECT 
   CASE 
       WHEN HOUR(sale_time) < 12 THEN 'Morning'
       WHEN HOUR(sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
	   ELSE 'Evening'  
   END AS shift
FROM retail_sales 
)  
SELECT 
      shift,
      COUNT(*) AS Total_orders
FROM hourly_sale
GROUP BY shift;  


      
      


   

   
     

     