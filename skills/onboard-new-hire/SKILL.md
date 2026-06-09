---
name: onboard-new-hire
description: Use when adding a new employee to Bonusly, creating a new user account, inviting a new hire, or setting up someone who just joined the company.
---
Onboarding a new hire into Bonusly means creating their account, making sure their profile is accurate, and optionally welcoming them with a recognition.

Start by collecting the required information before making any API calls:
* **Full name** and **work email** (required)
* **Department** and **location** (required if your company uses them)
* **Manager** — by name or email; use `searchUsers` to resolve their ID if needed
* **Start date / hire date**
* **Role** — regular employee or admin?

Before creating, call `adminListUsers` filtered by the new hire's email to check whether they already exist. If a deactivated account exists for that email, note this — `adminCreateUser` will reactivate them rather than create a duplicate, which is the right behavior.

Call `adminCreateUser` with the collected fields. If the call fails due to missing required fields or validation errors, surface the error message clearly and ask the admin to supply the missing information. Don't guess at values.

After creation, call `adminGetUser` with the new user's ID to verify the profile looks correct. Present a clear summary to the admin: name, email, department, manager, role. If anything looks wrong — department misspelled, manager missing — offer to fix it with `adminUpdateUser`.

Finally, ask: **"Would you like to welcome [name] with a recognition?"** If yes, check `getPointsBalance` to confirm the admin has points available, draft a warm welcome message, and send it via `giveRecognition`.

Finish with a summary of everything that was done: account created, profile fields confirmed, welcome recognition sent (if applicable).

**If the company uses required custom properties**, the creation call may fail with a validation error listing those fields — surface them and ask for the values before retrying.
