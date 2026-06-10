---
name: update-employee
description: Use when changing an existing employee's profile — reassigning their manager, moving them to a different department or location, granting or revoking admin access, fixing their name, email, locale, or time zone, or other reorg and correction edits.
---
This skill edits an **active** employee's admin-managed attributes. It's the middle of the employee lifecycle — onboarding creates accounts (`onboard-new-hire`) and offboarding deactivates them (`offboard-employee`); this is for changing someone who's already here. For granting points to give, use `manage-giving-balances` instead.

Start by resolving the person. Use `searchUsers` or `getUser` to find them by name or email, then `adminGetUser` to load their full admin profile. Present a clear before-state summary — name, email, department, manager, role, and the relevant role fields — so the admin confirms this is the right person and can see what's changing.

**Be precise about the three role-related fields — never conflate them:**
* `role` — coarse "admin" / "employee"
* `company_admin` — the legacy single admin flag
* `permission_names` / `permission_ids` — fine-grained admin capabilities

When the admin says "make them an admin" or "remove their admin access," confirm *which* kind of access they mean before changing anything, since these are distinct.

Make the change with `adminUpdateUser`. It requires `user_id` and accepts any subset of mutable fields:
* **Reassign manager** — resolve the new manager by name or email first, then pass `manager_email`. To remove a manager entirely, pass `clear_manager`.
* **Department / location / other custom attributes** — pass via `custom_properties`.
* **Identity** — `first_name`, `last_name`, `email`, `locale`, `time_zone`.
* **Admin access** — `company_admin` and/or `permission_ids`, per the distinction above.

**Confirm before writing.** Show the admin the exact change ("Move Jane from Engineering to Product, manager → Sam") and wait for explicit approval before calling `adminUpdateUser`. Change only the fields the admin asked about — don't send unrelated fields.

Two things can block an edit: manual edits may be disabled for **HRIS-managed users** (their profile is synced from an external system), and these actions require `user:administer`. If a call fails for either reason, surface the error message plainly rather than retrying.

Finish with a short summary of what changed (and what stayed the same), and offer related follow-ups — e.g. reassigning their direct reports too, or sending recognition to welcome a role change.
