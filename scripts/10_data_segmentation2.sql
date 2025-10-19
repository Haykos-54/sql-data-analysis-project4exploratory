/*Group customers into three segments based on their spending behavior :
    -VIP: Customers with at least 12 months of history and spending more than €5000
	-Regular: Customers with at least 12 months of history but spending more than €5000 or less
	-New:Customers with a lifespan less than 12 months
	and find the total number of customers by each group */
WITH customer_spending AS (
SELECT 
customer_key,
SUM(sales_amount) as total_spending,
MIN(order_date) as first_order,
MAX(order_date) as last_order,
DATEDIFF(month,MIN(order_date),MAX(order_date)) AS lifespan
FROM gold.fact_sales
WHERE order_date IS NOT NULL
GROUP BY customer_key
)

SELECT
customer_segment,
COUNT(customer_key) as total_customers
FROM (
SELECT
customer_key,
total_spending,
lifespan,
CASE WHEN lifespan >12 AND total_spending >5000 THEN 'VIP'
     WHEN lifespan >12 AND total_spending <=5000 THEN 'NORMAL'
	 ELSE 'NEW'
  END customer_segment
  FROM customer_spending ) t
GROUP BY customer_segment
ORDER BY total_customers DESC
