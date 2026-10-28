---
name: rewards-spend-report
description: Use when reporting on reward spend, pulling redemption totals or detail, checking how many points have been redeemed by department or country, or reviewing the rewards budget without taking action on individual redemptions.
---
This is a read-only reporting skill for rewards spend. It answers questions like "how much have we spent on rewards this quarter?", "which department redeems the most?", or "show me all fulfilled redemptions last month." It does **not** approve, decline, fulfill, or refund anything — for actioning individual redemptions, use the `process-redemptions` skill.

Start by clarifying scope:
* **Totals vs. detail** — a summary of spend (totals report) or a list of individual redemption records (redemptions report)?
* **Grouping** — overall, or broken down by a custom property (such as department) or by country?
* **Date range** — if not specified, default to the current calendar month and tell the user what range you used.
* **State / fulfillment** — detail reports use `aasm_state`; pending is `'new'`. To restrict the approved report to unfulfilled rewards, use `aasm_state: 'approved'` with `unfulfilled: true`. Without that flag, `'approved'` includes fulfilled rewards too; use `'fulfilled'` for fulfilled-only detail.

For spend summaries, call `adminRewardsTotalsReport`. Without `group_by`, it returns paginated per-user totals; with `group_by`, it returns groups for a company custom property or country. Use the returned `group_by_options` to discover valid grouping dimensions. This report measures reward redemptions, not spend attributable to a particular recognition award.

Totals include rewards currently approved or fulfilled, filtered by **approval date** in the company's time zone. Deactivated users are excluded by default; set `include_archived: true` when they belong in the requested scope. In the per-user response, `totals` covers the current page and `entire_company_totals` covers the full report population, including any supplied user-property filters. Use the latter for an overall spend answer.

For redemption-level detail, call `adminRewardsRedemptionsReport` with `aasm_state`, `user_email`, `start_date`, `end_date`, and, where applicable, `unfulfilled: true`. Detail dates refer to **redemption creation**, not approval, so the same dates need not reconcile with the totals report. Use `range: 'all'` when the requested scope is all time; do not also supply date bounds.

Both admin reports use `page` and `per_page`, not cursors. Follow `pagination.current_page` and `pagination.total_pages` when returning all per-user totals or redemption records, and disclose truncation. Detail defaults to 40 records per page; per-user totals default to 100; both allow at most 100.

If currency or company context would help frame the numbers, call `getCompany`. `listDepartments` or `listLocations` can help identify values to filter by; the totals report's `filters` combines properties with AND and values within a property with OR.

Present results clearly. Distinguish reward face value, monetary spend/debits, credit-card contributions, and points; preserve the currency and units returned with each value. Rank or highlight outliers — "the Sales department accounts for 41% of reward spend this month" is more useful than a raw table. Use report-provided full-population totals rather than re-summing page subtotals.

If the user then wants to act on specific pending redemptions they see in the report, offer to hand off to the `process-redemptions` workflow.

**Access note:** `adminRewardsTotalsReport` and `adminRewardsRedemptionsReport` require `rewards:administer`. If a call fails, surface the required permission.
