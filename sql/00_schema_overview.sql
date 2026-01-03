-- =====================================
-- File: 00_schema_overview.sql
-- Purpose: Describe dataset structure, grain, and logical schema
-- Dataset: Google Analytics Public Dataset
-- Tool: Google BigQuery
-- =====================================

-- Dataset source:
-- bigquery-public-data.google_analytics_sample.ga_sessions_*

-- This project uses a SINGLE physical table with nested fields.
-- Logical tables are derived using UNNEST and views.

-- =====================================================
-- LOGICAL SCHEMA OVERVIEW
-- =====================================================

-- 1. Sessions (logical table)
-- Grain: one row per user session
-- Key fields:
-- - fullVisitorId
-- - visitId
-- - date
-- - trafficSource.source
-- - trafficSource.medium
-- - device.deviceCategory
-- - totals.visits
-- - totals.transactions
-- - totals.totalTransactionRevenue

-- =====================================================

-- 2. Events / Hits (logical table)
-- Grain: one row per event within a session
-- Derived from: UNNEST(hits)
-- Key fields:
-- - hits.type
-- - hits.eCommerceAction.action_type
-- - hits.transaction.transactionId

-- =====================================================

-- 3. Products (logical table)
-- Grain: one row per product within an event
-- Derived from: UNNEST(hits.product)
-- Key fields:
-- - product.productRevenue
-- - product.productQuantity

-- =====================================================
-- JOIN LOGIC (CONCEPTUAL)
-- =====================================================

-- Sessions → Hits:
-- fullVisitorId + visitId

-- Hits → Products:
-- implicit via UNNEST(hits.product)

-- =====================================================
-- DESIGN DECISIONS
-- =====================================================

-- - No physical tables will be created.
-- - A small number of VIEWS will be used to simplify analysis.
-- - SQL will be the source of truth for metrics.
-- - Python will be used for deeper analysis and validation.

-- =====================================================
-- ANALYTICAL VIEWS
-- =====================================================

-- View: vw_sessions_base
-- Type: Fact view (session-level)
-- Grain: one row per session (fullVisitorId + visitId)
-- Purpose:
-- - Base table for KPI calculations and exploration
-- - Contains session-level marketing and revenue metrics


-- View: vw_events_funnel
-- Type: Event-level funnel view
-- Grain: One row per event (hit)
-- Purpose:
-- - Analyze user behavior across funnel steps


-- View: vw_transactions
-- Type: Transaction-level view
-- Grain: One row per transaction
-- Purpose:
-- - Analyze completed purchases and revenue
