---
name: awards-program-management
description: Tools for managing the awards program, including listing, creating, updating, and deleting awards.
---

Tools for managing the awards program, including listing, creating, updating, and deleting awards.

This plugin provides the following tools:

- **adminListAwards**: List custom awards in the caller's company. Supports filtering by state ('active' or 'inactive') and cursor pagination. Pass page_size and (optionally) state on the first call; on subsequent calls pass only the returned next_cursor — the state filter is encoded in the cursor and carried forward automatically.
- **adminShowAward**: Fetch a single award in the caller's company by id.
- **adminCreateAward**: Create a new custom award in the caller's company. Defines conditions, budget, period, approval levels, and giver-bot metadata.
- **adminUpdateAward**: Update an existing award in the caller's company. Any subset of mutable fields may be passed.
- **adminDeleteAward**: Soft-delete an award in the caller's company and deactivate its giver bot.
- **listAwards**: List custom awards in the caller's company. Supports cursor pagination. Pass type ('claimable' or 'manual') and page_size on the first call; on subsequent calls pass only the returned next_cursor.
- **showAward**: Fetch a single award in the caller's company by id.
