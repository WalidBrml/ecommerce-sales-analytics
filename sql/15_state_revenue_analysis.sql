
-- 15_state_revenue_analysis.sql
-- Compare order volume and revenue by state

SELECT
    c.customer_state,
    COUNT(DISTINCT o.order_id) AS total_orders,
    ROUND(SUM(oi.price + oi.freight_value), 2) AS total_revenue,
    ROUND(
        SUM(oi.price + oi.freight_value)
        / COUNT(DISTINCT o.order_id),
        2
    ) AS revenue_per_order
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
JOIN order_items oi
    ON o.order_id = oi.order_id
GROUP BY c.customer_state
ORDER BY total_revenue DESC;
