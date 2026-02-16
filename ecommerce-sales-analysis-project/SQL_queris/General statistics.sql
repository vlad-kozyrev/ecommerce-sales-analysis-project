-- Key business metrics: total sales, unique customers, revenue, average order value

SELECT COUNT(*) as total_sales,
	   COUNT(DISTINCT customer_id) as unique_customers,
	   SUM(quantity * unit_price) as total_revenue,
	   AVG(quantity * unit_price) as avg_check
FROM sales
