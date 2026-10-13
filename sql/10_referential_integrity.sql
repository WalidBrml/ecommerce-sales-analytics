-- 11_top_products_sellers.sql
-- Top 10 products by product revenue

SELECT
    oi.product_id,
    COALESCE(
        t.product_category_name_english,
        p.product_category_name,
        'Unknown'
    ) AS product_category,
    COUNT(*) AS items_sold,
    ROUND(SUM(oi.price), 2) AS product_revenue
FROM order_items oi
LEFT JOIN products p
    ON oi.product_id = p.product_id
LEFT JOIN product_category_name_translation t
    ON p.product_category_name = t.product_category_name
GROUP BY
    oi.product_id,
    COALESCE(
        t.product_category_name_english,
        p.product_category_name,
        'Unknown'
    )
ORDER BY product_revenue DESC
LIMIT 10;