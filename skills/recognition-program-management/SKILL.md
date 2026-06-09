---
name: recognition-program-management
description: "Tools for giving awards and managing the recognition program, give balances, and redemptions."
---

# Introduction

Tools for giving awards and managing the recognition program, give balances, and redemptions.

# Available tools

This skill recommends using the following tools from the bonusly MCP server:

## adminGetGiveBalance - Get give balance

Fetch a user's giving balance line items with pagination.

Required OAuth scope: `user:administer` or `rewards:administer`

## adminCreateGiveBalanceIncrement - Create give balance increment

Add a giving balance increment (e.g. admin_initiated_boost) to a user in the caller's company.

Required OAuth scope: `user:administer` or `rewards:administer`

## adminParticipationReport - Admin Participation Report

Returns participation report data for the caller's company, including giving/receiving rates by group (department, location, etc.) or manager and team metrics.
Supports two views: 'giving_and_receiving' (participation by group) and 'managers_and_teams' (per-manager metrics including direct reports recognized and unrecognized counts).
Requires a date range (start_date and end_date as YYYY-MM-DD) and an optional grouping dimension (e.g. 'department', 'location').
Requires global admin or reports admin access.


Required OAuth scope: `recognition:administer` or `reports:administer`

## adminUsersLastRecognized - Admin Users Last Recognized

Returns a paginated list of users along with when they were last recognized by a specified manager.
Pass a full array of user IDs (up to 20 per page) and optionally a manager_id.
Pagination is cursor-based and slices the provided user_ids array — pass page_size on the first
call and the returned next_cursor on subsequent calls (along with the same user_ids array).
The manager_id is encoded in the cursor and carried forward automatically; it does not need to
be re-supplied on subsequent pages.
When manager_id is provided, last_recognized_by_manager_at reflects the most recent recognition
given by that manager while they were actually the user's manager at that time.
Returns null for users with no recognition from the specified manager.
Requires global admin, finance admin, reports admin, or manager access.


Required OAuth scope: `user:administer` or `reports:administer`

