
-- 18_payment_insights.sql
-- Payment method analysis

SELECT
    payment_type,
    COUNT(*) AS payment_records,
    COUNT(DISTINCT order_id) AS orders_paid,
    ROUND(SUM(payment_value), 2) AS total_payment_value,
    ROUND(AVG(payment_value), 2) AS average_payment_value,
    ROUND(
        100.0 * SUM(payment_value)
        / SUM(SUM(payment_value)) OVER (),
        2
    ) AS percentage_of_payment_value
FROM order_payments
GROUP BY payment_type
ORDER BY total_payment_value DESC;
