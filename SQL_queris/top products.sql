-- top_products.sql
-- Top 10 products by quantity sold with category information

SELECT 
    p.product_name,
    c.category_name,
	SUM(s.quantity) as total_quantity_sold,
	COUNT(*) as transaction_count,
	ROUND(AVG(s.unit_price), 2) as average_price
FROM sales s
	LEFT JOIN products p 
	ON s.product_id = p.product_id
	LEFT JOIN categories c
	ON p.category_id = c.category_id
GROUP BY p.product_name, c.category_name
ORDER BY total_quantity_sold DESC
LIMIT 10 