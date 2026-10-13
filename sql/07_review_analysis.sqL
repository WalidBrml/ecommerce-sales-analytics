
-- 07_review_analysis.sql
-- Customer review analysis

SELECT
    review_score,
    COUNT(*) AS review_count,
    ROUND(
        100.0 * COUNT(*) / SUM(COUNT(*)) OVER (),
        2
    ) AS percentage_of_reviews
FROM order_reviews
GROUP BY review_score
ORDER BY review_score DESC;

-- Average customer review score

SELECT
    ROUND(AVG(review_score), 2) AS average_review_score,
    COUNT(*) AS total_reviews,
    COUNT(*) FILTER (
        WHERE review_score <= 2
    ) AS low_score_reviews
FROM order_reviews;
