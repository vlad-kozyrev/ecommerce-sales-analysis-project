-- top_customers.sql
-- Top 5 customers by total spending with order statistics

SELECT c.customer_name, c.customer_type,
	   COUNT(*) as number_of_purchases,
	   SUM(s.quantity * s.unit_price) as total_spent,
	   ROUND(AVG(s.quantity * s.unit_price), 2) as avg_order_value	
FROM customers c
	INNER JOIN sales s
	ON c.customer_id = s.customer_id
GROUP BY c.customer_name, c.customer_type
ORDER BY total_spent DESC
LIMIT 5