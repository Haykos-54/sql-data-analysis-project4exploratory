------PERFORMANCE  ANALYSIS----(Yýllýk deðer ile ortalama deðer çýkartýlarak bulunur)
/* Analyze the yearly performance of products by comparing their sales
to both the average sales of the  product and the previous year's sales */
WITH yearly_product_sales AS (
SELECT
YEAR(f.order_date) AS order_year,
SUM(f.sales_amount) AS current_sales,
p.product_name
FROM gold.fact_sales f
LEFT JOIN gold.dim_products p
ON f.product_key=p.product_key
WHERE order_date IS NOT NULL
GROUP BY YEAR(f.order_date),p.product_name
), ----YEAR--OVER--YEAR CALC ANALYSIS----
calc AS (
    SELECT
        order_year,
        product_name,
        current_sales,
        AVG(current_sales) OVER (PARTITION BY product_name) AS avg_current_sales,
        current_sales - AVG(current_sales) OVER (PARTITION BY product_name) AS diff_avg,
		LAG(current_sales) OVER(PARTITION BY product_name ORDER BY order_year) AS py_sales,
		current_sales-LAG(current_sales) OVER(PARTITION BY product_name ORDER BY order_year) AS diff_py
		
    FROM yearly_product_sales
	
)
SELECT *,
    CASE 
        WHEN diff_avg > 0 THEN 'Above Avg'
        WHEN diff_avg = 0 THEN 'Average'
        ELSE 'Under Avg'
    END AS avg_change,
	CASE
	    WHEN diff_py > 0 THEN 'Increase'
		WHEN diff_py < 0 THEN 'Decrease'
		ELSE 'No Change'
    END AS py_change
FROM calc
WHERE py_sales IS NOT NULL AND diff_py IS NOT NULL
ORDER BY product_name, order_year;
