-- customer_segmentation.sql
-- Segments customers into High-Value, Regular, Developing based on spending

SELECT 
    c.customer_name,
    c.customer_type,
    SUM(s.quantity * s.unit_price) as total_spent,
    COUNT(*) as order_count,
    ROUND(AVG(s.quantity * s.unit_price), 2) as avg_order_value,
    CASE 
        WHEN SUM(s.quantity * s.unit_price) > 10000 THEN 'High-Value Clients'
        WHEN SUM(s.quantity * s.unit_price) >= 7000 THEN 'Regular Clients'
        ELSE 'Developing Clients'
    END as customer_segment
FROM customers c 
INNER JOIN sales s ON c.customer_id = s.customer_id
GROUP BY c.customer_name, c.customer_type
ORDER BY total_spent DESC
		