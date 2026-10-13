-- 01_sales_overview.sql
-- Sales overview for orders containing at least one item

SELECT
    COUNT(DISTINCT o.order_id) AS total_orders,
    COUNT(DISTINCT c.customer_unique_id) AS unique_customers,
    COUNT(*) AS total_items_sold,
    ROUND(SUM(oi.price), 2) AS total_product_revenue,
    ROUND(SUM(oi.freight_value), 2) AS total_freight_revenue,
    ROUND(SUM(oi.price + oi.freight_value), 2) AS total_revenue,
    ROUND(
        SUM(oi.price + oi.freight_value)
        / COUNT(DISTINCT o.order_id),
        2
    ) AS average_order_value
FROM orders o
JOIN customers c
    ON o.customer_id = c.customer_id
JOIN order_items oi
    ON o.order_id = oi.order_id;
    

