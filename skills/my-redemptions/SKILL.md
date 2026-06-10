---
name: my-redemptions
description: Use when someone wants to see their own reward redemptions — what they've redeemed, the status of a reward, where a gift card or claim link is, or whether a redemption went through.
---
This skill is the employee-facing view of your own reward redemptions — "what have I redeemed?", "where's my gift card?", or "did my redemption go through?". It's read-only and scoped to the calling user. For admins processing other people's redemptions, use `process-redemptions`; for company-wide spend reporting, use `rewards-spend-report`.

For a list of the caller's redemptions, call `getMyRedemptions`. It returns redemptions newest-first with each one's state, catalog/reward details, and claim and certificate URLs. `total_count` is the caller's full count; `redemptions` is one page. It's cursor-paginated:
* Pass `limit` (1–100, default 20) on the first call.
* When `next_cursor` is non-null there are more pages — pass it back as `cursor` and keep `limit` identical across pages.

For a single redemption the user is asking about specifically, call `getRedemption` with its `id`. The caller can always read their own redemptions; reading someone else's requires a rewards-admin role, so for the personal use case this is fine.

When summarizing, lead with what the user actually wants: the current **state** of each redemption and, when it's fulfilled, the **claim or certificate URL** so they can get to their reward. If a redemption is still pending or unfulfilled, say so plainly and set expectations rather than implying it's ready.

If the user has no redemptions, say so simply. If they're looking for a specific reward and it's not on the first page, offer to paginate before giving up.

**Access note:** listing your own redemptions requires `rewards:read`. If a call fails on permissions, surface the required scope.
