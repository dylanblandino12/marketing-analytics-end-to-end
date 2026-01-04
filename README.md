# marketing-analytics-end-to-end
End-to-end marketing analytics project using SQL (BigQuery), Python, and Looker to analyze user behavior and conversion funnels.

## Project Overview
This project analyzes user behavior and marketing performance using the Google Analytics public dataset.  
The analysis focuses on identifying high-value channels, conversion efficiency, and key drop-off points in the purchase funnel using SQL-based transformations and exploratory analysis.

## Analysis Workflow
- SQL (BigQuery): Data modeling, KPI calculations, and funnel analysis.
- Python: Exploratory analysis and validation (in progress).
- Looker: Data visualization and dashboarding (planned).

## Business Questions
- Which marketing channels generate the highest value per transaction?
- Which channels best balance conversion efficiency and revenue impact?
- Where do users drop off the most in the conversion funnel?
- Which marketing channels should be deprioritized due to low impact?
## Key Findings

- Display generates the highest revenue per transaction, indicating high-value purchases despite relatively low transaction volume.
- Referral delivers the highest conversion rate, showing strong efficiency but lower average order value compared to Display.
- Organic Search and Direct channels provide stable mid-range performance, balancing traffic volume and revenue contribution.
- Social drives a high volume of sessions but shows the lowest conversion rate and minimal revenue impact, making it a clear candidate for deprioritization.
- Funnel analysis reveals that the largest drop-off occurs between product detail views and add-to-cart actions, highlighting early-stage friction before purchase intent.
- A significant drop-off is also observed during checkout, suggesting potential optimization opportunities in the purchase completion process.
