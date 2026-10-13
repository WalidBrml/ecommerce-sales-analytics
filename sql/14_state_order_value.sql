
-- 14_state_order_value.sql
-- Average order value by customer state

WITH order_totals AS (
    SELECT
        c.customer_state,
        o.order_id,
        SUM(oi.price + oi.freight_value) AS order_value
    FROM customers c
    JOIN orders o
        ON c.customer_id = o.customer_id
    JOIN order_items oi
        ON o.order_id = oi.order_id
    GROUP BY
        c.customer_state,
        o.order_id
)
SELECT
    customer_state,
    COUNT(*) AS total_orders,
    ROUND(SUM(order_value), 2) AS total_revenue,
    ROUND(AVG(order_value), 2) AS average_order_value
FROM order_totals
GROUP BY customer_state
ORDER BY average_order_value DESC;
