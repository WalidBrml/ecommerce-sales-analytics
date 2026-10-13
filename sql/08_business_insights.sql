

-- 08_business_insights.sql
-- Business insights: monthly revenue growth

WITH monthly_sales AS (
    SELECT
        DATE_TRUNC('month', o.order_purchase_timestamp)::DATE AS month,
        ROUND(SUM(oi.price), 2) AS product_revenue
    FROM orders o
    JOIN order_items oi
        ON o.order_id = oi.order_id
    GROUP BY DATE_TRUNC('month', o.order_purchase_timestamp)
),
monthly_growth AS (
    SELECT
        month,
        product_revenue,
        LAG(product_revenue) OVER (ORDER BY month) AS previous_month_revenue
    FROM monthly_sales
)
SELECT
    month,
    product_revenue,
    previous_month_revenue,
    ROUND(
        100.0 * (product_revenue - previous_month_revenue)
        / NULLIF(previous_month_revenue, 0),
        2
    ) AS month_over_month_growth_pct,
    CASE
        WHEN previous_month_revenue IS NULL THEN 'No previous month'
        WHEN product_revenue > previous_month_revenue THEN 'Growth'
        WHEN product_revenue < previous_month_revenue THEN 'Decline'
        ELSE 'No change'
    END AS growth_status
FROM monthly_growth
ORDER BY month;

