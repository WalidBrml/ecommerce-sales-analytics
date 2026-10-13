
-- 06_delivery_analysis.sql
-- Delivery performance analysis
-- Late delivery rate is calculated only for orders
-- with both actual and estimated delivery dates.

SELECT
    COUNT(*) FILTER (
        WHERE order_delivered_customer_date IS NOT NULL
    ) AS delivered_orders,

    COUNT(*) FILTER (
        WHERE order_delivered_customer_date >
              order_estimated_delivery_date
    ) AS late_deliveries,

    ROUND(
        100.0 * COUNT(*) FILTER (
            WHERE order_delivered_customer_date >
                  order_estimated_delivery_date
        )
        / NULLIF(
            COUNT(*) FILTER (
                WHERE order_delivered_customer_date IS NOT NULL
                  AND order_estimated_delivery_date IS NOT NULL
            ),
            0
        ),
        2
    ) AS late_delivery_percentage,

    ROUND(
        AVG(
            EXTRACT(
                EPOCH FROM (
                    order_delivered_customer_date
                    - order_purchase_timestamp
                )
            ) / 86400.0
        ) FILTER (
            WHERE order_delivered_customer_date IS NOT NULL
        ),
        2
    ) AS average_delivery_days

FROM orders;
