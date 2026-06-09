---
name: explore-org-chart
description: Use when exploring the reporting hierarchy, finding who someone reports to, listing a person's full management chain, mapping the team beneath a manager, or finding top-level employees with no manager.
---
This skill walks the organization's reporting structure — upward to a person's managers, downward through the people who report to them, or across the top of the org chart. It's a read-only navigation tool useful for org audits and "who reports to whom" questions.

Start by figuring out what the user wants:
* **A starting person** — resolve them with `searchUsers` or `getUser` by name or email. (Not needed if they want the top of the org chart.)
* **Direction** — up the chain toward leadership, or down through their reports?
* **Depth** — for downward views, how many layers deep?

Then call the matching tool:
* **Upward / management chain** — `getManagerChain` walks from the person to the top of the org, ordered closest-first.
* **Downward / reporting tree** — `getReportingTree` walks the layers beneath a person. Set `depth` (default 1, max 5) to control how deep. For just the immediate reports, `getDirectReports` is simpler.
* **Top of the org chart** — `listTopLevelUsers` returns employees who have no manager (the entry points of the org chart).

Render the result as an indented outline so the hierarchy is easy to scan, rather than a flat list. Include each person's name and, where helpful, their title or department.

These endpoints paginate and limit depth; if a tree is large or truncated, say so and offer to expand a specific branch. Note that cross-company manager IDs return no results.

**Access note:** these are read-only and require `user:read`. If a call fails, surface the required permission.
