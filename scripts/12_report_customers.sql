/*-----------------CUSTOMER  REPORT ----------------------------------
Purpose:
-this report consolidates key customer metrics and behaviours

Highlights:
1. Gathers essential fields such as names, ages and transaction details.
2. Segments customers into categories (VIP,regular,New)and age groups.
3. Aggregates customer-level metrics:
   -total orders
   -total sales
   -total quantity purchased
   -total products
   -lifespan (in months)
4.Calculates valuable KPIs:
   -recency (months since last order)
   -average order value 
   -average monthly spend
----------------------------------------------------------------------
*/

WITH base_query as (
/*---------------------------------
1)Base Query: Retrieves core columns from tables
-----------------------------------*/
SELECT
f.order_number,
f.product_key,
f.order_date,
f.due_date,
f.sales_amount,
f.quantity,
c.customer_key,
c.customer_number,
CONCAT(c.first_name,' ',c.last_name) as customer_name,
DATEDIFF(YEAR,c.birthdate, GETDATE()) as age
FROM gold.fact_sales f
LEFT JOIN gold.dim_customers c
ON c.customer_key=f.customer_key
WHERE order_date IS NOT NULL
)
, customer_aggregation as (
/*------------------------------
2)Customer Aggregations: Summarizes key metrics at the customer level
--------------------------------*/
SELECT 
customer_key,
customer_number,
customer_name,
age,
COUNT(DISTINCT order_number) as total_orders,
SUM(sales_amount) as total_sales,
SUM(quantity) as total_quantity,
COUNT(DISTINCT product_key) as total_products,
MAX(order_date) as last_order,
DATEDIFF(month,MIN(order_date),MAX(order_date)) AS lifespan
FROM base_query
GROUP BY
     customer_key,
     customer_number,
     customer_name,
     age
)

SELECT 
customer_key,
customer_number,
customer_name,
age,
CASE 
     WHEN age <20 THEN 'YOUNG'
     WHEN age BETWEEN 20 and 29 THEN '20-29'
	 WHEN age BETWEEN 30 and 39 THEN '30-39'
	 WHEN age BETWEEN 40 and 49 THEN '40-49'
	 ELSE 'OLD'
END age_group,

CASE WHEN lifespan >12 AND total_sales >5000 THEN 'VIP'
     WHEN lifespan >12 AND total_sales <=5000 THEN 'NORMAL'
	 ELSE 'NEW'
  END customer_segment,
last_order,
DATEDIFF(MONTH,last_order, GETDATE()) as recency,
total_orders,
total_sales,
total_products,
lifespan,
---Compuate average  order value (AVO)----
total_sales/total_orders as avg_order_value,
---Compuate average monthly spend(AVS)----
CASE WHEN lifespan=0 THEN total_sales
     ELSE total_sales/lifespan
END as avg_monthly_spend
FROM customer_aggregation
