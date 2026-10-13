-- 02_monthly_sales.sql
-- Monthly sales and revenue trends

SELECT
    DATE_TRUNC('month', o.order_purchase_timestamp)::DATE AS month,
    COUNT(DISTINCT o.order_id) AS total_orders,
    COUNT(*) AS total_items_sold,
    ROUND(SUM(oi.price), 2) AS product_revenue,
    ROUND(SUM(oi.freight_value), 2) AS freight_revenue,
    ROUND(SUM(oi.price + oi.freight_value), 2) AS total_revenue
FROM orders o
JOIN order_items oi
    ON o.order_id = oi.order_id
GROUP BY DATE_TRUNC('month', o.order_purchase_timestamp)
ORDER BY month;