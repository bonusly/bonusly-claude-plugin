---
name: offboard-employee
description: Use when an employee is leaving the company, deactivating or archiving a user, removing someone from Bonusly, or reactivating a previously deactivated account.
---
Offboarding an employee means deactivating their Bonusly account safely — and, if they manage people, deciding what happens to their direct reports first. This skill also handles reactivating someone who was deactivated by mistake or who has returned.

Start by resolving the person. Use `searchUsers` or `getUser` to find them by name or email, then `adminGetUser` to load their full admin profile. Present a clear summary — name, email, department, manager, role — so the admin can confirm this is the right person before anything happens.

**Check for direct reports before deactivating.** Call `getDirectReports` for the user. If they manage people:
* List the reports and tell the admin these people will be left without a manager.
* Ask whether to reassign the reports to a new manager (resolve the new manager by name or email, then call `adminUpdateUser` for each report with the new `manager_email`) or to clear their manager (`adminUpdateUser` with `clear_manager`).
* Do this **before** deactivating the departing user.

**Never deactivate without explicit confirmation.** After showing the profile and resolving any direct reports, ask the admin to explicitly confirm — e.g. "Yes, deactivate [name]." Do not call `adminDeactivateUser` until they say so in plain terms. Only then call `adminDeactivateUser` with the user's ID. Deactivation is scheduled in the background, so tell the admin it may take a moment to take effect.

Some users cannot be deactivated: the last remaining company admin, and integration-protected users when manual management is disabled. If `adminDeactivateUser` fails for one of these reasons, surface the error message plainly rather than retrying.

**Reactivation branch.** If the admin instead wants to bring someone back, resolve the deactivated profile, confirm it's the right person, and — only after they explicitly say to proceed — call `adminActivateUser` with the user's ID. Activation is also scheduled in the background. Afterward, offer to fix the manager, department, or role with `adminUpdateUser`, and to send a welcome-back recognition (see the `onboard-new-hire` skill for the recognition flow).

Finish with a summary of what was done: reports reassigned (if any), account deactivated or reactivated, and any follow-ups still needed.

**If a write call (`adminDeactivateUser`, `adminActivateUser`, `adminUpdateUser`) reports an error, don't blindly retry.** Because deactivation and activation run in the background, an error can come back even though the change was already scheduled or applied. First re-fetch the profile with `adminGetUser` to check the current state, and only retry if the change genuinely didn't take.

**Access note:** these actions require `user:administer`. If a call fails on permissions, surface the required scope.
