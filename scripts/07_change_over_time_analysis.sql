----CHANGE OVER-TÝME(TRENDS) ANALYSIS------


SELECT YEAR(order_date) as order_year,
 MONTH(order_date) as order_month,
SUM (sales_amount) as total_sales,
COUNT(DISTINCT customer_key) as total_customers,
SUM(quantity) as total_quantity,
SUM(price) as total_price
FROM gold.fact_sales
WHERE order_date IS NOT NULL
GROUP BY YEAR(order_date),MONTH(order_date)
ORDER BY YEAR(order_date),MONTH(order_date)



SELECT DATETRUNC(month, order_date) as order_date,
SUM (sales_amount) as total_sales,
COUNT(DISTINCT customer_key) as total_customers,
SUM(quantity) as total_quantity,
SUM(price) as total_price
FROM gold.fact_sales
WHERE order_date IS NOT NULL
GROUP BY DATETRUNC(month, order_date)
ORDER BY DATETRUNC(month, order_date) 



SELECT FORMAT(order_date, 'yyyy-MM') as order_date,
SUM (sales_amount) as total_sales,
COUNT(DISTINCT customer_key) as total_customers,
SUM(quantity) as total_quantity,
SUM(price) as total_price
FROM gold.fact_sales
WHERE order_date IS NOT NULL
GROUP BY FORMAT(order_date, 'yyyy-MM')
ORDER BY FORMAT(order_date, 'yyyy-MM') 
