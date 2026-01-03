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


