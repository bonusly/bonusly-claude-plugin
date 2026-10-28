---
name: process-redemptions
description: Use when reviewing or processing pending reward redemptions — approving, declining, fulfilling, or refunding custom reward requests from employees.
---
This skill walks a rewards admin through the redemption queue — reviewing what employees have requested and taking action on each one.

Start by calling `adminRewardsRedemptionsReport` with `aasm_state: 'new'` and `range: 'all'` to review the entire pending queue, unless the admin requested a date range. For approved-but-unfulfilled requests, use `aasm_state: 'approved'` and `unfulfilled: true`; without that flag, the approved report includes both approved and fulfilled rewards. Use `aasm_state: 'fulfilled'`, `'declined'`, or `'refunded'` for those specific states. This report uses `page` and `per_page` (default 40, maximum 100); follow `pagination.total_pages` before declaring the queue empty or cleared. If there are no pending redemptions, say so clearly and ask if they want to see a different state.

If the admin wants budget context before diving in, call `adminRewardsTotalsReport` for approved/fulfilled reward spend in the period. It uses approval dates, not request dates; use `entire_company_totals`, not the current-page `totals`, for the full report population. Set `include_archived: true` if the scope includes deactivated users.

For each redemption in the queue, present the key facts: **who** requested it, **what reward**, **when**, and **how many points**. Then ask what action to take. Pass the redemption's ID as `reward_id` to the action tool:

* **Approve** — call `adminRewardsApproveRedemption` for an approvable pending request. Approval and fulfillment are separate: custom rewards still need manual delivery after approval.
* **Decline** — confirm the action, then call `adminRewardsDeclineRedemption` for a pending request. The tool does not accept a decline reason; don't promise that a reason collected in conversation will be saved or sent to the employee.
* **Fulfill** — only for an approved custom reward. Confirm that delivery has already happened before calling `adminRewardsFulfillRedemption`; this marks delivery rather than arranging it. Provider-managed rewards cannot be manually fulfilled through this tool.
* **Refund** — confirm the action, then call `adminRewardsRefundRedemption` only for an eligible custom reward or Points Boost. This tool is unavailable to superadmins, who must use `/super_admin/rewards`. A refund can apply to a new, approved, or fulfilled reward, subject to eligibility; don't promise it will revoke an external reward.
* **Skip** — move on without taking action on this one.

Use `adminRewardsUnfulfillRedemption` only to correct a fulfilled custom reward's delivery marking; it returns the reward to approved. It is not a general prerequisite for refunds, and it does not make an approved reward eligible for decline.

**If a redemption action (`adminRewardsApproveRedemption`, `adminRewardsDeclineRedemption`, `adminRewardsFulfillRedemption`, `adminRewardsRefundRedemption`, `adminRewardsUnfulfillRedemption`) reports an error, don't blindly retry.** A timeout or network error can come back *after* the state change took effect. Check the exact redemption with `getRedemption` if available, or locate its ID in the report across the relevant states and pages. Reports read from a secondary: absence or an unchanged row alone is not proof that the action failed. If the outcome remains ambiguous, report that and don't retry.

After processing the queue, provide a summary: N approved, N declined, N fulfilled, N refunded. Offer to re-run the report to confirm the queue is now clear.

**Access note:** the admin reports and redemption action tools require `rewards:administer` scope and a rewards-admin role. `getRedemption` accepts either `rewards:read` or `rewards:administer`; reading another user's redemption also requires a rewards-admin role. If a call fails with an auth error, surface the required permission clearly.
