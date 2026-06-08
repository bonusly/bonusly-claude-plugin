---
name: general-organization
description: "Tools for navigating the organization like getting departments, locations, users, managers, etc."
---

# Introduction

Tools for navigating the organization like getting departments, locations, users, managers, etc.

# Available tools

This skill recommends using the following tools from the bonusly MCP server:

## me - Me

Returns the authenticated user's profile (identity, locale, account state). Does not include company information, balances, or permissions.

Required OAuth scope: `user:read`

## getUser - Get user

Resolve a single user within the caller's company by id, email or name.
Returns the user's profile fields.

Pass the user's BSON ObjectId, email, or full display name as
`identifier`. When the name matches multiple people, a disambiguation
payload is returned listing candidates — re-call with one of the
candidate ids to get a definitive result.


Required OAuth scope: `user:read`

## getUsers - Get users

Bulk-fetch users by a list of user IDs within the authenticated caller's company.

Required OAuth scope: `user:read`

## searchUsers - Search users

Search users in the authenticated caller's company by name or email, with optional
filters on location, department, manager, and reports. Supports cursor pagination —
pass the returned `next_cursor` as `cursor` to fetch the next page.


Required OAuth scope: `user:read`

## getCompany - Get company

Returns metadata for the authenticated caller's company — name, locale, plan, feature flags, subscription state, and other profile fields.

Required OAuth scope: `company:read`

## listDepartments - List departments

List the distinct departments configured for users in the authenticated caller's company, with a user count for each. Supports prefix-match search on the department name and cursor pagination.

Required OAuth scope: `user:read`

## listLocations - List locations

List the distinct locations configured for users in the authenticated caller's company, with a user count for each. Supports prefix-match search on the location name and cursor pagination.

Required OAuth scope: `user:read`

## listUsersInDepartment - List users in a department

List the users in the authenticated caller's company who belong to a specific department (exact match). Supports a name/email search and cursor pagination.

Required OAuth scope: `user:read`

## listUsersInLocation - List users in a location

List the users in the authenticated caller's company who belong to a specific location (exact match). Supports a name/email search and cursor pagination.

Required OAuth scope: `user:read`

## listTopLevelUsers - List top-level users

List the users in the authenticated caller's company who have no manager. These are the entry points into the org chart — pair with `getReportingTree` or `getDirectReports` to walk down. Supports a name/email search and cursor pagination.

Required OAuth scope: `user:read`

## getDirectReports - Get direct reports

Get the users in the authenticated caller's company who report directly to a given manager. Cross-company manager IDs return no results. Supports a name/email search and cursor pagination.

Required OAuth scope: `user:read`

## getManagerChain - Get manager chain

Walk the manager chain upward from a given user in the authenticated caller's company, returning the user's manager, that manager's manager, and so on up to a top-level user. The chain is ordered closest-first.

Required OAuth scope: `user:read`

## getReportingTree - Get reporting tree

Walk the reporting tree below a given user in the authenticated caller's company. Returns layers: layer 0 is direct reports, layer 1 is direct reports' reports, etc. `depth` controls how many layers to include (default 1, max 5).

Required OAuth scope: `user:read`

