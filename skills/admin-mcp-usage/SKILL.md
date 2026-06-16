---
name: admin-mcp-usage
description: Use when reporting on MCP tool usage — how many MCP calls were made over a period, which tools or methods were used most, or a per-date breakdown of who used what and when.
---
This is a read-only reporting skill for MCP tool usage. It answers questions like "how many MCP calls did we make last month?", "which MCP tools get used the most?", or "show me MCP usage by user and date for Q2." It takes no action — it only reads usage data.

Start by clarifying scope:
* **Totals vs. detail** — a single rolled-up count (totals report) or a per-date breakdown of individual usage events (details report)?
* **Date range** — if not specified, default to the current calendar month and tell the user what range you used. Both tools accept `start_date` and `end_date` (format `YYYY-MM-DD`).
* **Filters** — narrow by `user_id` (a single id or an array) or `method_name`.  Use method_name when you want to filter by MCP tool name.  `klass` and `name` are currently unused and won't return results.

For an overall count or a quick "how much usage" answer, call `adminGetMcpUsageTotals`. It returns totals grouped by company, user, date range, class, method, or name based on the filters you pass.

For a breakdown by tool and the dates usage occurred, call `adminGetMcpUsageDetails`. It returns per-method totals plus a per-date breakdown of each `(user_id, occurred_at)` event and the distinct `name` values seen in the range. This endpoint paginates by method via `page_size` (max 200) and a `cursor` — page through it and tell the user if results were truncated.

If the user wants to filter to a specific person but only has a name or email, resolve it to a `user_id` first (use the `general-organization` tools).

Present results clearly. Rank or highlight outliers — "the `give-recognition` tools account for 60% of MCP calls this month" beats a raw table. Don't manually re-sum figures the report already totals.

**Note:** Neither tool tracks its own usage, so MCP usage reporting calls won't appear in the numbers.

**Access note:** Both `adminGetMcpUsageTotals` and `adminGetMcpUsageDetails` are admin-only. If a call fails, surface the required permission.
