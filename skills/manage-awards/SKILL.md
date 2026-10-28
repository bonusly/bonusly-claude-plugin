---
name: manage-awards
description: Use when creating, updating, reviewing, or retiring custom awards — spot bonuses, peer awards, claimable achievements, or any special recognition type beyond everyday recognition.
---
Awards are custom recognition types in Bonusly — things like spot bonuses, claimable achievements, or company-specific milestones. Giving a manual award or claiming an incentive creates an award approval request and, once approved, a recognition bonus. These are different from Rewards catalog redemptions. This skill covers award review, giving, approvals, retirement, and manual award creation; create claimable incentives through the web app rather than `adminCreateAward`.

**Reviewing awards**

Call `adminListAwards` with `state: 'active'` by default to show the current catalog. Present key fields for each: name, type (claimable or manual), budget, period, approval level, and whether it's active.

For details on a specific award, call `adminShowAward` with its ID.

Do not use `adminRewardsTotalsReport` to measure spend on a particular award: it aggregates reward redemptions by user or user property/country, not recognition awards. Review award configuration, approval requests, and recognition activity for the question at hand; don't present redemption spend as award spend.

To see the employee-facing view (what people can actually see and claim), use `listAwards` or `showAward`.

**Giving an award**

Use `giveAward` to hand a manual award to one or more recipients. First find the award with `listAwards` (or `adminListAwards`) to get its `award_id` — or pass `award_name` (exact, case-insensitive). `recipients` is an array of user ids, emails, or display names; no `@mention` formatting needed.

The award itself dictates which extra inputs are honored. Check the award's `amount_editable`, `reason_editable`, and `bonus_privacy_changeable` flags (returned by `listAwards`) before offering to set `amount`, `message`, or `privacy` — they're silently ignored otherwise. `hide_giver` is always available.

Giving creates an approval request. Auto-approved awards return the created `bonus` immediately; awards with an approval process return a pending `approval_request` with `bonus: null` — tell the admin it's awaiting approval, don't report it as given. File attachments aren't supported over MCP.

**Creating an award**

`adminCreateAward` creates a manual award, not a claimable incentive; it has no claimable/manual type selector. Collect the required configuration before the write:
* `name`
* Giving audience: non-empty `conditions` (each with `attr` and `value`) and `conditions_operator`
* `period_type` and recognition `visibility`, using values accepted by the tool
* Any requested description, points amount, budget per period, message, and editability settings
* Approval process, if needed: ordered `approval_process_levels`, each with `position` and explicit `allowed_approver_ids`. Resolve the intended people to IDs. There are no peer/manager/admin routing enums; omitting approval levels means automatic approval.

Present the full configuration to the admin in plain language before calling `adminCreateAward`. Give them a chance to adjust anything. After creation, call `adminShowAward` to verify the configuration and state. For an active award, use `listAwards` with `type: 'manual'` to check the caller's employee-facing view; visibility also depends on eligibility.

**Updating an award**

If the admin gives a name rather than an ID, call `adminListAwards` to find the matching entry and get its ID.

Ask what they want to change. Show the current value alongside the proposed new value. Call `adminUpdateAward` with only the changed fields. Then call `adminShowAward` to confirm the update took effect.

**Approving awards**

If the admin asks about incentive approvals or award requests, use `listAwardApprovalRequests` for requests awaiting the caller's decision (`state: 'pending'`), optionally filtered by `kind: 'award'` or `'incentive'`. It is an approver inbox, not the caller's claim history or every pending request in the company. Follow `next_cursor` for more pages. To retrieve a specific request, including its documentation, call `getAwardApprovalRequest` with `approval_request_id`.

When the user decides to approve or deny an awards approval request, use either the `approveAwardApprovalRequest` or `denyAwardApprovalRequest` tools to perform the action.

**Retiring an award**

Identify the award the same way as for updates. Before proceeding, warn the admin: `adminDeleteAward` soft-deletes the award and deactivates its giver bot; it does not approve or deny outstanding award approval requests. Review those separately and confirm the admin has a plan for them. Ask for confirmation before calling `adminDeleteAward`.

**If a write call (`adminCreateAward`, `adminUpdateAward`, `giveAward`, `adminDeleteAward`) reports an error, don't blindly retry.** A timeout or network error can come back *after* the write succeeded. Verify award changes with `adminListAwards`/`adminShowAward`. For `giveAward`, inspect the corresponding approval request or recognition record; if a request ID is known and access permits, use `getAwardApprovalRequest`. Neither `adminRewardsRedemptionsReport` nor absence from the approver inbox proves a grant failed. If the outcome cannot be established, report it as unresolved and don't retry.

**Access note:** the `admin*` award tools and award approval tools require `awards:administer` and award-admin access. `giveAward` requires `recognition:write`; `listAwards` and `showAward` require `awards:read`.
