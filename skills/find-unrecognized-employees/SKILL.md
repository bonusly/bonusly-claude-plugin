---
name: find-unrecognized-employees
description: Use when a manager or admin wants to find employees who haven't received recognition recently, identify participation gaps, or see who's been left out across a team, department, or the whole company.
---
This skill helps surface recognition blind spots — the people who keep doing good work but aren't hearing about it.

Start by asking what scope the user wants:
* **My direct reports** — just the people they manage
* **A specific department** — everyone in one org unit
* **A manager's team** — their direct reports and/or the whole reporting tree
* **Company-wide** — a high-level participation view

**For direct reports:** call `me` then `getDirectReports` to get the team's IDs. Then call `adminUsersLastRecognized` with those IDs to get the last recognition date for each person.

**For a department:** call `listUsersInDepartment` to get all user IDs in that department. Then call `adminUsersLastRecognized` — if the department is large, paginate in batches of up to 20 IDs and aggregate the results.

**For company-wide or department-level summary rates:** call `adminParticipationReport` with `view: 'giving_and_receiving'` and the relevant date range. This gives participation percentages by group without enumerating every individual.

**For a per-manager breakdown** (who's leaving their reports unrecognized): call `adminParticipationReport` with `view: 'managers_and_teams'`.

Present results ranked by most overdue first — users with a `null` last-recognized date at the top, then sorted by oldest date. Be concrete: "Jordan hasn't received recognition in 47 days."

After surfacing the list, offer to take action: "Would you like to recognize any of these people now?" and transition into the `give-recognition` or `recognize-my-team` workflow.

**Access note:** `adminUsersLastRecognized` requires admin or manager-level access. If the call fails with a permissions error, explain what access is needed. `adminParticipationReport` requires admin or reports admin access.

**Date range:** if the user doesn't specify a time window, default to the last 30 days and tell them what range you used.
