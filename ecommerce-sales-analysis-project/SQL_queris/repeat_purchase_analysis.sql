-- repeat_purchase_analysis.sql
-- Customer Purchase Frequency Analysis
-- Analyzing time intervals between purchases to understand customer loyalty patterns

WITH order_diffs AS (
    -- Step 1: Calculate days between consecutive orders for each customer
    -- Using LAG() window function to compare each order with previous one
    SELECT 
        customer_id,
        order_date - LAG(order_date) OVER (PARTITION BY customer_id ORDER BY order_date) as days_between
    FROM sales
),

customer_avg AS (
    -- Step 2: Calculate average days between orders for each customer
    -- NULL values excluded (first orders without previous order)
    SELECT 
        customer_id,
        AVG(days_between) as avg_days_between_orders
    FROM order_diffs
    WHERE days_between IS NOT NULL  -- Exclude first purchase of each customer
    GROUP BY customer_id
)

-- Step 3: Segment customers by purchase frequency and analyze distribution
SELECT 
    CASE 
        WHEN ca.avg_days_between_orders IS NULL THEN 'Only 1 order'
        WHEN ca.avg_days_between_orders <= 7 THEN 'Weekly buyers'
        WHEN ca.avg_days_between_orders <= 30 THEN 'Monthly buyers'
        ELSE 'Rare buyers'
    END as frequency_segment,
    
    COUNT(*) as customers_count,
    ROUND(AVG(ca.avg_days_between_orders), 1) as avg_days_between_orders,
    ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER(), 2) as percentage_of_total
    
FROM customers c
LEFT JOIN customer_avg ca ON c.customer_id = ca.customer_id
GROUP BY frequency_segment
ORDER BY customers_count DESC;