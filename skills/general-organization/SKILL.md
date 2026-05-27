---
name: general-organization
description: "Tools for navigating the organization like getting departments, locations, users, managers, etc."
---

Tools for navigating the organization like getting departments, locations, users, managers, etc.

This plugin provides the following tools:

- **me**: Returns the authenticated user's profile (identity, locale, account state). Does not include company information, balances, or permissions.
- **getUser**: Fetch a single user by ID within the authenticated caller's company. Returns the user's profile fields.
- **getUsers**: Bulk-fetch users by a list of user IDs within the authenticated caller's company.
- **searchUsers**: Search users in the authenticated caller's company by name or email, with optional filters on location, department, manager, and reports.
- **getCompany**: Returns metadata for the authenticated caller's company — name, locale, plan, feature flags, subscription state, and other profile fields.
- **listDepartments**: List the distinct departments configured for users in the authenticated caller's company, with a user count for each. Supports prefix-match search on the department name and cursor pagination.
- **listLocations**: List the distinct locations configured for users in the authenticated caller's company, with a user count for each. Supports prefix-match search on the location name and cursor pagination.
- **listUsersInDepartment**: List the users in the authenticated caller's company who belong to a specific department (exact match). Supports a name/email search and cursor pagination.
- **listUsersInLocation**: List the users in the authenticated caller's company who belong to a specific location (exact match). Supports a name/email search and cursor pagination.
- **listTopLevelUsers**: List the users in the authenticated caller's company who have no manager. These are the entry points into the org chart — pair with `getReportingTree` or `getDirectReports` to walk down. Supports a name/email search and cursor pagination.
- **getDirectReports**: Get the users in the authenticated caller's company who report directly to a given manager. Cross-company manager IDs return no results. Supports a name/email search and cursor pagination.
- **getManagerChain**: Walk the manager chain upward from a given user in the authenticated caller's company, returning the user's manager, that manager's manager, and so on up to a top-level user. The chain is ordered closest-first.
- **getReportingTree**: Walk the reporting tree below a given user in the authenticated caller's company. Returns layers: layer 0 is direct reports, layer 1 is direct reports' reports, etc. `depth` controls how many layers to include (default 1, max 5).
