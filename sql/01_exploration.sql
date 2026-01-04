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
-- Null User Validation
-- =====================================

-- Validate the presence of null user identifiers to ensure data integrity

SELECT
  COUNT(*) AS null_user_rows
FROM `marketing_analytics.vw_sessions_base`
WHERE fullVisitorId IS NULL;

-- Insight:
-- No sessions contain null user identifiers, confirming data completeness at the user level.


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


-- =====================================
-- Device Category Distribution Analysis
-- =====================================

-- Analyze how sessions and transactions are distributed across device categories

-- total sessiones per device

SELECT 
  device_category,
  COUNT(*) AS total_sessions_per_device
FROM `marketing_analytics.vw_sessions_base`
GROUP BY device_category
ORDER BY total_sessions_per_device DESC;

-- Insight:
-- Desktop accounts for the majority of sessions, followed by mobile, indicating desktop as the primary access device.

-- total transactions per device

SELECT
  s.device_category,
  COUNT(DISTINCT t.transaction_id) AS total_transactions_per_device
FROM `marketing_analytics.vw_sessions_base` s
JOIN `marketing_analytics.vw_transactions` t
ON s.session_id = t.session_id
GROUP BY s.device_category
ORDER BY total_transactions_per_device DESC;

-- Insight:
-- Desktop drives most transactions, while mobile shows significantly lower conversion volume despite substantial traffic.

