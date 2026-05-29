---
name: recognition-program-management
description: "Tools for giving awards and managing the recognition program, give balances, and redemptions."
---

Tools for giving awards and managing the recognition program, give balances, and redemptions.

This plugin provides the following tools:

- **adminGetGiveBalance**: Fetch a user's giving balance line items with pagination.
- **adminCreateGiveBalanceIncrement**: Add a giving balance increment (e.g. admin_initiated_boost) to a user in the caller's company.
- **adminParticipationReport**: Returns participation report data for the caller's company, including giving/receiving rates by group (department, location, etc.) or manager and team metrics.
- **adminUsersLastRecognized**: Returns a paginated list of users along with when they were last recognized by a specified manager.
