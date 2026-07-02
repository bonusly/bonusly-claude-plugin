---
name: process-redemptions
description: Use when reviewing or processing pending reward redemptions — approving, declining, fulfilling, or refunding custom reward requests from employees.
---
This skill walks a rewards admin through the redemption queue — reviewing what employees have requested and taking action on each one.

Start by calling `adminRewardsRedemptionsReport` filtered by `state: 'pending'` (or whatever state the admin specifies — pending, approved but unfulfilled, etc.). If there are no pending redemptions, say so clearly and ask if they want to see a different state.

If the admin wants budget context before diving in, call `adminRewardsTotalsReport` to show total redemption spend for the period.

For each redemption in the queue, present the key facts: **who** requested it, **what award**, **when**, and **how many points**. Then ask what action to take:

* **Approve** — call `adminRewardsApproveRedemption`. This is appropriate when the request is valid and the reward doesn't require manual delivery.
* **Decline** — ask for a reason first, then call `adminRewardsDeclineRedemption`. The reason helps the employee understand what happened.
* **Fulfill** — used for custom rewards that require manual delivery (gift cards, experiences, physical items). Confirm that delivery has already happened before calling `adminRewardsFulfillRedemption`.
* **Refund** — returns points to the employee. Confirm the admin wants to do this, then call `adminRewardsRefundRedemption`.
* **Skip** — move on without taking action on this one.

If a fulfillment needs to be undone, use `adminRewardsUnfulfillRedemption` before taking a different action.

**If a redemption action (`adminRewardsApproveRedemption`, `adminRewardsDeclineRedemption`, `adminRewardsFulfillRedemption`, `adminRewardsRefundRedemption`, `adminRewardsUnfulfillRedemption`) reports an error, don't blindly retry.** A timeout or network error can come back *after* the state change took effect, and a retry risks a double refund or an out-of-order action. First re-run `adminRewardsRedemptionsReport` for that redemption to check its current state, and only retry if it hasn't changed.

After processing the queue, provide a summary: N approved, N declined, N fulfilled, N refunded. Offer to re-run the report to confirm the queue is now clear.

**Access note:** all redemption action tools require `rewards:administer` scope. If any call fails with an auth error, surface the required permission clearly.
