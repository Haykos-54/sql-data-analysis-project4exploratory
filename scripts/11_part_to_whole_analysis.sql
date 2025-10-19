--------PART TO WHOLE (PROPORTÝONAL ANALYSIS)----- 
----Which catogies contribute the most to overall sales?----
WITH category_sales AS (
SELECT 
p.category,
SUM(f.sales_amount) as total_sales

FROM gold.fact_sales f
LEFT JOIN gold.dim_products p
ON f.product_key=p.product_key
GROUP BY p.category
)
SELECT
   category,
   total_sales,
   SUM(total_sales) OVER () as overall_sales,
CONCAT(ROUND((CAST(total_sales AS float)/SUM(total_sales) OVER())*100,2),'%')  as percentage_of_total
FROM category_sales
ORDER BY percentage_of_total DESC
