# marketing-analytics-end-to-end
End-to-end marketing analytics project using SQL (BigQuery), Python, and Looker to analyze user behavior and conversion funnels.

---

## Project Overview

This project demonstrates a complete analytics workflow, from raw data modeling
to business insights. The analysis focuses on understanding how users progress
through the conversion funnel and how different marketing channels perform in
terms of efficiency and revenue contribution.

The project combines:
- SQL-based data modeling in BigQuery
- Python (pandas) for analytical validation and visualization
- Business-oriented interpretation of results

> Final visualization and dashboarding will be completed in Looker.

---

## Data & Tools

- **Dataset:** Google Analytics Public Dataset
- **SQL:** BigQuery
- **Python:** pandas, matplotlib (Google Colab)
- **Visualization:** Looker (in progress)

---

## Key Analyses

### Conversion Funnel Analysis
- Session-level funnel analysis to avoid event duplication
- Identification of major drop-off points across funnel stages
- Visualization of user progression from product view to purchase

### Channel Performance Analysis
- Channel-level aggregation of sessions, transactions, and revenue
- Calculation of conversion rate and revenue per transaction
- Comparison of efficiency versus value across marketing channels

---

## Key Findings

- Referral channels show the highest conversion efficiency.
- Display drives the highest revenue per transaction, indicating higher-value purchases.
- Organic Search and Direct channels provide stable mid-range performance.
- Social generates high traffic volume but underperforms in both conversion and revenue.
- The largest funnel drop-off occurs between product detail views and add-to-cart actions.

---

## Next Steps

- Build a Looker dashboard to consolidate funnel and channel performance metrics
- Add dashboard screenshots and Looker link to this repository
- Provide executive-level summary visualizations
