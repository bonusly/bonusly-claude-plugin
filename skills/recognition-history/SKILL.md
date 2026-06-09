---
name: recognition-history
description: Use when someone wants to see their own or a colleague's recognition history — what they've received, given, when they were last recognized, or to search recognitions by theme or keyword.
---
Recognition history answers questions like "what have I been recognized for this year?", "when did I last recognize someone?", or "show me everything related to the product launch."

Start by clarifying three things:
* **Who** — are we looking at the current user, or a specific colleague?
* **What direction** — received, given, or both?
* **When** — a specific date range, a rolling window, or all time?

If looking up a colleague by name, use `searchUsers` or `getUser` to resolve their ID before making history calls.

For date-bounded lookups (e.g. "this quarter", "in March"), use `getRecognitionReceived` and/or `getRecognitionGiven` with `start_date` and `end_date`. For rolling windows (e.g. "last 30 days"), use the `days_back` parameter. Don't mix the two.

If the user is searching by theme, keyword, or event (e.g. "recognition mentioning the rebrand" or "anything with #teamwork"), use `searchRecognitions` with a natural-language query — it's better suited for this than date filtering.

Summarize findings clearly: total points received or given, most-used hashtags, and any patterns worth highlighting. Do not manually sum per-row `amount` values across pages — use the aggregate totals the API returns.

Offer to paginate, filter by a specific hashtag, or narrow the date range if the results are large. If a date range returns nothing, widen it and ask if the user wants to look further back.
