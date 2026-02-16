-- revenue_per_product.sql
-- Revenue analysis per product within each category
-- Shows which categories generate the highest revenue per product

WITH
categories  as (SELECT ca.category_name,
		SUM(quantity * unit_price) as total_revenue,
		SUM(s.quantity) as total_quantity_sold,
		ROUND(AVG(s.unit_price), 2) as average_product_price,
		COUNT(DISTINCT p.product_id) as unique_products_count
FROM sales s
	LEFT JOIN products p
	ON s.product_id = p.product_id
	LEFT JOIN categories ca
	ON p.category_id = ca.category_id
GROUP BY ca.category_name
ORDER BY total_revenue DESC)

SELECT 
    category_name,
    total_revenue,
    unique_products_count,
    ROUND(total_revenue / unique_products_count, 2) as revenue_per_product
FROM categories
ORDER BY revenue_per_product DESC;

