-- =====================================
-- File: 03_business_questions.sql
-- Purpose: Answer key marketing business questions using SQL
-- Dataset: Google Analytics Public Dataset
-- Tool: Google BigQuery
-- =====================================

-- Q1: Which marketing channels deliver the highest value?

WITH avt_cte AS (
  SELECT
    channel_grouping,
    COUNT(DISTINCT transaction_id) AS total_transactions,
    SAFE_DIVIDE(SUM(total_revenue), 1e6) AS total_revenue_channel,
    ROUND(SAFE_DIVIDE(SAFE_DIVIDE(SUM(total_revenue), 1e6), COUNT(DISTINCT transaction_id)), 2) AS revenue_per_transaction
  FROM `marketing_analytics.vw_transactions`
  GROUP BY channel_grouping
)
SELECT
  *
FROM avt_cte 
ORDER BY revenue_per_transaction DESC
LIMIT 1;

-- Insight: Display generates the highest revenue per transaction, indicating high-value purchases despite lower transaction volume.


-- Q2: Which marketing channels balance conversion efficiency and revenue impact?


WITH avt_cte AS (
  SELECT
    s.channel_grouping,
    COUNT(DISTINCT s.session_id) AS total_sessions,
    COUNT(DISTINCT t.transaction_id) AS total_transactions,
    SAFE_DIVIDE(SUM(t.total_revenue), 1e6) AS total_revenue_channel,
    ROUND(SAFE_DIVIDE(COUNT(DISTINCT t.transaction_id), COUNT(DISTINCT s.session_id)) * 100, 2) AS conversion_rate_pct,
    ROUND(SAFE_DIVIDE(SAFE_DIVIDE(SUM(t.total_revenue), 1e6), COUNT(DISTINCT t.transaction_id)), 2) AS revenue_per_transaction
  FROM `marketing_analytics.vw_sessions_base` s
  LEFT JOIN `marketing_analytics.vw_transactions` t
    ON s.session_id = t.session_id
  GROUP BY s.channel_grouping
)
SELECT
  channel_grouping,
  conversion_rate_pct,
  revenue_per_transaction
FROM avt_cte 
ORDER BY conversion_rate_pct DESC, revenue_per_transaction DESC
;

-- Insight: Display provides the strongest balance between conversion efficiency and revenue impact, combining above-average conversion rates with the highest revenue per transaction.


-- Q3: Where do users drop off the most in the conversion funnel?

SELECT 
  CASE 
    WHEN ecommerce_action_type = '2' THEN 'Product detail view'
    WHEN ecommerce_action_type = '3' THEN 'Add to cart'
    WHEN ecommerce_action_type = '5' THEN 'Checkout'
    WHEN ecommerce_action_type = '6' THEN 'Completed purchase'
    END AS ecommerce_action_type_desc,
  COUNT(DISTINCT session_id) AS total_events
FROM `marketing_analytics.vw_events_funnel`
WHERE ecommerce_action_type IN ('2','3','5','6')
GROUP BY ecommerce_action_type_desc
ORDER BY total_events DESC;

-- Insight: The largest drop-off happens between product views and add-to-cart actions, indicating that users disengage early before showing purchase intent.


-- Q4: Which marketing channels should be deprioritized due to low impact?

SELECT
  s.channel_grouping,
  ROUND(SAFE_DIVIDE(COUNT(DISTINCT t.transaction_id), COUNT(DISTINCT s.session_id)) * 100, 2) AS conversion_rate_pct,
FROM `marketing_analytics.vw_sessions_base` s
LEFT JOIN `marketing_analytics.vw_transactions` t 
ON s.session_id = t.session_id
GROUP BY s.channel_grouping
ORDER BY conversion_rate_pct;

-- Insight: Social drives high traffic volume but exhibits the lowest conversion efficiency and revenue impact, making it a clear candidate for deprioritization.
