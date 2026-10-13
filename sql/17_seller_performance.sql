
-- 17_seller_performance.sql
-- Seller performance analysis

SELECT
    oi.seller_id,
    COUNT(DISTINCT oi.order_id) AS orders_handled,
    COUNT(*) AS items_sold,
    ROUND(SUM(oi.price), 2) AS product_revenue,
    ROUND(SUM(oi.freight_value), 2) AS freight_revenue,
    ROUND(SUM(oi.price + oi.freight_value), 2) AS total_revenue
FROM order_items oi
GROUP BY oi.seller_id
ORDER BY total_revenue DESC
LIMIT 10;
