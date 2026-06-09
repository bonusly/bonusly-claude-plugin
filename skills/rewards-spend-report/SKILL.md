---
name: rewards-spend-report
description: Use when reporting on reward spend, pulling redemption totals or detail, checking how many points have been redeemed by department or country, or reviewing the rewards budget without taking action on individual redemptions.
---
This is a read-only reporting skill for rewards spend. It answers questions like "how much have we spent on rewards this quarter?", "which department redeems the most?", or "show me all fulfilled redemptions last month." It does **not** approve, decline, fulfill, or refund anything — for actioning individual redemptions, use the `process-redemptions` skill.

Start by clarifying scope:
* **Totals vs. detail** — a summary of spend (totals report) or a list of individual redemption records (redemptions report)?
* **Grouping** — overall, or broken down by a custom property (such as department) or by country?
* **Date range** — if not specified, default to the current calendar month and tell the user what range you used.
* **State / fulfillment** — for detail reports, filter by redemption state, user email, or fulfillment status if the user wants.

For spend summaries, call `adminRewardsTotalsReport`. Use its `group_by` parameter to aggregate by a custom property or country when the user wants a breakdown.

For redemption-level detail, call `adminRewardsRedemptionsReport` with the relevant filters (state, user email, date range, fulfillment status). This endpoint paginates — page through it and tell the user if results were truncated.

If currency or company context would help frame the numbers, call `getCompany`. If the user wants to group by a dimension but isn't sure of valid values, `listDepartments` or `listLocations` can show the options.

Present results clearly. Rank or highlight outliers — "the Sales department accounts for 41% of reward spend this month" is more useful than a raw table. Don't manually sum figures the report already totals.

If the user then wants to act on specific pending redemptions they see in the report, offer to hand off to the `process-redemptions` workflow.

**Access note:** `adminRewardsTotalsReport` and `adminRewardsRedemptionsReport` require `rewards:administer`. If a call fails, surface the required permission.
