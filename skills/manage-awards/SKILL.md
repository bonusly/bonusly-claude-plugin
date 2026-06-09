---
name: manage-awards
description: Use when creating, updating, reviewing, or retiring custom awards — spot bonuses, peer awards, claimable achievements, or any special recognition type beyond everyday recognition.
---
Awards are the custom recognition types in Bonusly — things like peer-nominated awards, spot bonuses, claimable achievements, or company-specific milestones. This skill covers the full lifecycle: reviewing what exists, creating new ones, updating them, and retiring them.

**Reviewing awards**

Call `adminListAwards` with `state: 'active'` by default to show the current catalog. Present key fields for each: name, type (claimable or manual), budget, period, approval level, and whether it's active.

For details on a specific award, call `adminShowAward` with its ID.

To see how much has been spent on an award, call `adminRewardsTotalsReport` and look for that award in the results.

To see the employee-facing view (what people can actually see and claim), use `listAwards` or `showAward`.

**Creating an award**

Collect all required information in one pass before making any API call:
* Name and description
* Type — claimable (employees claim it themselves) or manual (given by a manager/admin)?
* Budget per period and period type (monthly, quarterly, annual, one-time)
* Criteria — what does someone have to do to earn this?
* Approval level — peer, manager, or admin approval? Explain the difference: peer approval means any colleague can approve, manager approval requires the recipient's manager, admin approval requires a company admin. This choice has real operational implications, so confirm it explicitly.

Present the full configuration to the admin in plain language before calling `adminCreateAward`. Give them a chance to adjust anything. After creation, call `listAwards` to confirm the award appears in the employee-facing catalog.

**Updating an award**

If the admin gives a name rather than an ID, call `adminListAwards` to find the matching entry and get its ID.

Ask what they want to change. Show the current value alongside the proposed new value. Call `adminUpdateAward` with only the changed fields. Then call `adminShowAward` to confirm the update took effect.

**Retiring an award**

Identify the award the same way as for updates. Before proceeding, warn the admin: `adminDeleteAward` is a soft-delete that deactivates the award and disables its giver bot. Pending redemptions are **not** automatically handled — confirm the admin has a plan for those. Ask them to confirm before calling `adminDeleteAward`.

**Access note:** all `admin*` award tools require `awards:administer` scope. `listAwards` and `showAward` work with `awards:read` scope only.
