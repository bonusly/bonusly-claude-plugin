---
name: reporting
description: Tools for retrieving reports, including rewards totals, detailed redemptions, company-wide participation, and last recognition date.
---

Tools for retrieving reports, including rewards totals, detailed redemptions, company-wide participation, and last recognition date.

This plugin provides the following tools:

- **adminRewardsTotalsReport**: Returns per-user or grouped reward spend totals for the caller's company. Use group_by to aggregate by a custom property or country.
- **adminRewardsRedemptionsReport**: Returns paginated reward redemption records for the caller's company. Supports filtering by state, user email, date range, and fulfillment status.
- **adminParticipationReport**: Returns participation report data for the caller's company, including giving/receiving rates by group (department, location, etc.) or manager and team metrics.
- **adminUsersLastRecognized**: Returns a paginated list of users along with when they were last recognized by a specified manager.
