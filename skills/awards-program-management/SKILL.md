---
name: awards-program-management
description: "Tools for managing the awards program, including listing, creating, updating, and deleting awards."
---

# Introduction

Tools for managing the awards program, including listing, creating, updating, and deleting awards.

# Available tools

This skill recommends using the following tools from the bonusly MCP server:

## adminListAwards - List Awards

List custom awards in the caller's company. Supports filtering by state ('active' or 'inactive') and cursor pagination. Pass page_size and (optionally) state on the first call; on subsequent calls pass only the returned next_cursor — the state filter is encoded in the cursor and carried forward automatically.

Required OAuth scope: `awards:administer`

## adminShowAward - Show Award

Fetch a single award in the caller's company by id.

Required OAuth scope: `awards:administer`

## adminCreateAward - Create Award

Create a new custom award in the caller's company. Defines conditions, budget, period, approval levels, and giver-bot metadata.

Required OAuth scope: `awards:administer`

## adminUpdateAward - Update Award

Update an existing award in the caller's company. Any subset of mutable fields may be passed.

Required OAuth scope: `awards:administer`

## adminDeleteAward - Delete Award

Soft-delete an award in the caller's company and deactivate its giver bot.

Required OAuth scope: `awards:administer`

## listAwards - List Awards

List custom awards in the caller's company. Supports cursor pagination. Pass type ('claimable' or 'manual') and page_size on the first call; on subsequent calls pass only the returned next_cursor.

Required OAuth scope: `awards:read`

## showAward - Show Award

Fetch a single award in the caller's company by id.

Required OAuth scope: `awards:read`

## adminRewardsTotalsReport - Admin Rewards Totals Report

Returns per-user or grouped reward spend totals for the caller's company. Use group_by to aggregate by a custom property or country.

Required OAuth scope: `rewards:administer`

## adminRewardsRedemptionsReport - Admin Rewards Redemptions Report

Returns paginated reward redemption records for the caller's company. Supports filtering by state, user email, date range, and fulfillment status.

Required OAuth scope: `rewards:administer`

