-------CUMULATIVE DATA ANALYSIS------(�irketin y�llar i�indeki ilerlemesini g�rmek i�in kullan�l�r)
----Calculate the total sales per month 
----and the running total of saves over time
SELECT 
order_date,
total_sales,
SUM(total_sales) OVER (PARTITION BY order_date ORDER BY order_date) AS running_total_sales,
AVG(total_sales) OVER (PARTITION BY order_date ORDER BY order_date) AS moving_avg_price
FROM
---W�NDOW FUNCT�ON---- (FOR MONTH)-----
(
SELECT 
DATETRUNC(MONTH,order_date) AS order_date,
SUM(sales_amount) AS total_sales,
AVG(price) AS avg_price
FROM gold.fact_sales
WHERE order_date IS NOT NULL
GROUP BY DATETRUNC(MONTH,order_date)
) AS monthly_cumulative_sales

----W�NDOW FUNCT�ON (FOR YEAR)----

---(
--SELECT 
--DATETRUNC(YEAR,order_date) AS order_date,----
--SUM(sales_amount) AS total_sales---
--FROM gold.fact_sales----
--WHERE order_date IS NOT NULL---
--GROUP BY DATETRUNC(YEAR,order_date)--
--) AS yearly_cumulative_sales--------