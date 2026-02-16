-- 07_regional_sales_analysis.sql
-- Regional sales analysis: Top cities by revenue
-- Business value: Identify key markets for business development

SELECT 
    c.city,
    COUNT(DISTINCT c.customer_id) as customers_count,
    COUNT(s.sale_id) as sales_count,
    SUM(s.quantity * s.unit_price) as total_revenue,
    ROUND(AVG(s.quantity * s.unit_price), 2) as avg_check
FROM customers c
JOIN sales s ON c.customer_id = s.customer_id
GROUP BY c.city
ORDER BY total_revenue DESC
LIMIT 10