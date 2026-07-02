---
name: claim-incentive
description: Use when you want to claim a claimable award ("incentive") for yourself — a self-service achievement, milestone, or perk you've earned in Bonusly.
---
Incentives are claimable awards — recognition you grant yourself when you've met the criteria (completed a certification, hit a milestone, finished onboarding, etc.). This skill covers finding and claiming them.

**Finding what you can claim**

Call `listAwards` with `type: 'claimable'` to list the incentives available in your company. Show each one's name, description/criteria, and points so you can pick the right one. Use `showAward` for full detail on a single incentive.

**Claiming**

Call `claimIncentive` with the incentive's `award_id` (preferred — get it from `listAwards`) or its exact `award_name` (case-insensitive). Optional inputs:
* `claim_reason` — a note shown to approvers explaining why you qualify. Offer to include one, especially for incentives that go through approval.
* `privacy` — `publicly_visible`, `privately_visible`, or `immediate_team`. Only honored when the incentive allows changing privacy.

Claiming creates an approval request. Auto-approved incentives return the created `bonus` immediately. Incentives with an approval process return a pending `approval_request` with `bonus: null` — tell the user it's awaiting approval, not yet granted.

**If `claimIncentive` reports an error, don't blindly retry.** A timeout or network error can come back *after* the claim already registered, and a retry risks a duplicate claim. First check with `getMyRedemptions` (or re-list to see whether a pending claim exists) and only re-claim if it genuinely didn't go through.

**Proof attachments:** not supported over MCP. If an incentive requires proof, tell the user to claim it through the Bonusly web app so they can attach the artifact.

**Access note:** `claimIncentive` and `listAwards`/`showAward` work with `awards:read` scope.
