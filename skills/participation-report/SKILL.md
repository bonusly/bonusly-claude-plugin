---
name: participation-report
description: Use when pulling a recognition participation report, checking giving or receiving rates by department, location, or manager team, or identifying which groups are least engaged in recognition.
---
Participation reports answer questions like "how engaged is our team in recognition this quarter?", "which departments are giving the least?", or "which managers have the most unrecognized direct reports?"

Start by clarifying two things:
* **Scope** — overall company, broken down by department, by location, or by manager team?
* **Date range** — if not specified, default to the current calendar month and tell the user what range you used.

If the user wants to filter to a specific department or location but isn't sure of the exact name, call `listDepartments` or `listLocations` to show them valid options.

Then call `adminParticipationReport` with the appropriate `view` parameter:
* `'giving_and_receiving'` — for breakdowns by department or location: participation rates, number of givers and receivers per group.
* `'managers_and_teams'` — for a per-manager view: how many of each manager's direct reports have given and received recognition in the period.

If total headcount context would help frame the participation percentages, call `getCompany` to get company size.

Present the results clearly. Flag any groups with notably low participation — "the Design department had only 23% participation this month" is more useful than a raw table. 

If the user wants to drill into a low-participation group and find specific people who are being left out, offer to run the `find-unrecognized-employees` workflow with that department or manager team as scope.

**Access note:** `adminParticipationReport` requires admin or reports admin access. If the call fails, surface the required permission.
