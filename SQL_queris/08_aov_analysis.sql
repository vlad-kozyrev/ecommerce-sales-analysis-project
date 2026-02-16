-- 08_aov_analysis.sql
-- Average Order Value (AOV) analysis by customer segment
-- Business value: Understanding spending patterns across different customer types

WITH customer_aov AS (
    -- Calculate AOV for each individual customer
    SELECT 
        c.customer_id,
        c.customer_name,
        c.customer_type,
        COUNT(s.sale_id) as order_count,
        SUM(s.quantity * s.unit_price) as total_spent,
        -- Customer's average order value
        ROUND(SUM(s.quantity * s.unit_price) / COUNT(s.sale_id), 2) as aov
    FROM customers c
    JOIN sales s ON c.customer_id = s.customer_id
    GROUP BY c.customer_id, c.customer_name, c.customer_type
)

-- Segment-level AOV analysis
SELECT 
    customer_type,
    COUNT(*) as customers_count,
    
    -- AOV metrics for the segment
    ROUND(AVG(aov), 2) as avg_aov,
    ROUND(MIN(aov), 2) as min_aov,
    ROUND(MAX(aov), 2) as max_aov,
    
    -- Window function: compare segment AOV vs overall average
    ROUND(
        AVG(aov) - AVG(AVG(aov)) OVER(), 
        2
    ) as diff_from_overall_avg,
    
    -- Percentage difference
    ROUND(
        (AVG(aov) - AVG(AVG(aov)) OVER()) / AVG(AVG(aov)) OVER() * 100, 
        2
    ) as diff_percentage
    
FROM customer_aov
GROUP BY customer_type
ORDER BY avg_aov DESC