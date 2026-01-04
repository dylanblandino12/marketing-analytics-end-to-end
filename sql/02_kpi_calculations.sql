-- =====================================
-- File: 02_kpi_calculations.sql
-- Purpose: Calculate core marketing KPIs for analysis and visualization
-- Dataset: Google Analytics Public Dataset
-- Tool: Google BigQuery
-- =====================================

-- =====================================
-- Overall Conversion Rate
-- =====================================

-- Purpose:
-- Calculate the overall conversion rate by comparing total transactions against total sessions to establish a baseline performance metric.


SELECT
  ROUND((COUNT(DISTINCT t.transaction_id) / COUNT(DISTINCT s.session_id))*100, 2)  AS conversion_rate_percentage
FROM `marketing_analytics.vw_sessions_base` s
LEFT JOIN `marketing_analytics.vw_transactions` t
ON s.session_id = t.session_id;

-- Insight: The overall conversion rate is 1.28%, which is within the expected range for e-commerce traffic.

-- =====================================
-- Conversion Rate by Marketing Channel
-- =====================================

-- Purpose: Compare conversion efficiency across marketing channels by measuring transactions relative to sessions.

WITH channel_conversion AS (
  SELECT
    s.channel_grouping,
    COUNT(DISTINCT s.session_id) AS total_sessions,
    COUNT(DISTINCT t.transaction_id) AS total_transactions,
    ROUND(
      (COUNT(DISTINCT t.transaction_id) / COUNT(DISTINCT s.session_id)) * 100,
      2
    ) AS conversion_rate_pct
  FROM `marketing_analytics.vw_sessions_base` s
  LEFT JOIN `marketing_analytics.vw_transactions` t
    ON s.session_id = t.session_id
  GROUP BY s.channel_grouping
)
SELECT
  *
FROM channel_conversion
ORDER BY conversion_rate_pct DESC;

-- Insight:
-- Referral shows the highest conversion rate despite lower traffic, while Social drives high session volume but converts poorly, highlighting a clear quality vs quantity tradeoff across channels.

-- =====================================
-- Revenue by Marketing Channel
-- =====================================

-- Purpose: Evaluate which marketing channels generate the highest total revenue, beyond conversion efficiency.

WITH revenue_channel_cte AS (
  SELECT
    channel_grouping,
    COUNT(DISTINCT transaction_id) AS total_transactions,
    SUM(total_revenue) / 1e6 AS total_revenue_channel

  FROM `marketing_analytics.vw_transactions`
  GROUP BY channel_grouping
),
ATV_cte AS(
  SELECT
    *,
    ROUND((total_revenue_channel / total_transactions),2) AS revenue_per_transaction
  FROM revenue_channel_cte
  ORDER BY revenue_per_transaction DESC
)
SELECT
  *
FROM ATV_cte;

-- Insight:
-- Display and Direct channels show the highest revenue per transaction, indicating higher average order value despite lower conversion volumes.
