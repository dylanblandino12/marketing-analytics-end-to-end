-- =====================================
-- File: 01_exploration.sql
-- Purpose: Perform initial data exploration and validation
-- Dataset: Google Analytics Public Dataset
-- Tool: Google BigQuery
-- =====================================

-- =====================================
-- Date Range Overview
-- =====================================

SELECT 
  MIN(date) AS oldest_date,
  MAX(date) AS latest_date
FROM `marketing_analytics.vw_sessions_base`;

-- Insight:
-- The dataset spans from August 2016 to August 2017, providing one full year of data for analysis.


-- =====================================
-- Dataset Volume Validation
-- =====================================
--Validate total sessions
SELECT
  COUNT(DISTINCT session_id) AS total_sessions
FROM `marketing_analytics.vw_sessions_base`;

-- Insight: The dataset contains over 900K sessions, providing a solid base for behavioral analysis.

--validar total users

SELECT
  COUNT(DISTINCT fullVisitorId) AS total_users
FROM `marketing_analytics.vw_sessions_base`;

-- Insight: User count is slightly lower than sessions, indicating repeat visits across users.

--validar total transactions

SELECT
  COUNT(DISTINCT transaction_id) AS total_transactions
FROM `marketing_analytics.vw_transactions`;

-- Insight: The dataset includes 11,552 completed transactions, representing actual purchase events.


-- =====================================
-- Channel-Level Distribution Analysis
-- =====================================

-- Analyze how sessions and transactions are distributed across marketing channels.

SELECT
  channel_grouping,
  COUNT(*) AS total_sesions_per_channel
FROM `marketing_analytics.vw_sessions_base`
GROUP BY channel_grouping
ORDER BY total_sesions_per_channel DESC;

-- Insight:
-- Organic Search and Social account for the majority of sessions, indicating they are the primary traffic drivers.

-- total transactions per channel
SELECT
  channel_grouping,
  COUNT(DISTINCT transaction_id) AS total_transactions_per_channel
FROM `marketing_analytics.vw_transactions`
GROUP BY channel_grouping
ORDER BY total_transactions_per_channel DESC;

-- Insight:
-- Referral and Organic Search generate the highest number of transactions, while Social drives high traffic but relatively few conversions.



