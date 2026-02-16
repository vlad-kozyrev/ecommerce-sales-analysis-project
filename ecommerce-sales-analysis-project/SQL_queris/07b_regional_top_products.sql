-- 07b_regional_top_products.sql
-- Most popular products in top 3 cities by revenue
-- Business value: Regional product preferences for targeted marketing

WITH top_cities AS (
    SELECT 
        c.city,
        SUM(s.quantity * s.unit_price) as total_revenue
    FROM customers c
    JOIN sales s ON c.customer_id = s.customer_id
    GROUP BY c.city
    ORDER BY total_revenue DESC
    LIMIT 3
)

SELECT 
    c.city,
    p.product_name,
    COUNT(*) as times_purchased,
    SUM(s.quantity) as total_units,
    SUM(s.quantity * s.unit_price) as product_revenue
FROM customers c
JOIN sales s ON c.customer_id = s.customer_id
JOIN products p ON s.product_id = p.product_id
WHERE c.city IN (SELECT city FROM top_cities)
GROUP BY c.city, p.product_name
ORDER BY c.city, times_purchased DESC