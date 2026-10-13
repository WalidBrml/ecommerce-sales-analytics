
-- 09_order_item_quality.sql
-- Data quality: orders without matching order items

SELECT
    o.order_status,
    COUNT(*) AS total_orders,
    COUNT(*) FILTER (
        WHERE oi.order_id IS NULL
    ) AS orders_without_items,
    ROUND(
        100.0 * COUNT(*) FILTER (
            WHERE oi.order_id IS NULL
        ) / COUNT(*),
        2
    ) AS percentage_without_items
FROM orders o
LEFT JOIN (
    SELECT DISTINCT order_id
    FROM order_items
) oi
    ON o.order_id = oi.order_id
GROUP BY o.order_status
ORDER BY orders_without_items DESC;
