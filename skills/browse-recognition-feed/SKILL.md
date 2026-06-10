---
name: browse-recognition-feed
description: Use when browsing the company recognition feed — seeing what recognition is happening across the company, filtering the feed by hashtag, department, location, team, recognition type, or a specific giver or receiver.
---
The recognition feed is the same reverse-chronological stream shown on Bonusly's web home — top-level recognition posts across the company. This skill is for reading and filtering that feed, not for looking up one person's history (use `recognition-history` for that) or searching by theme (use `searchRecognitions`).

Start by clarifying what slice of the feed the user wants. The feed can be filtered by any combination of these (all combined as AND):
* **Hashtags** — e.g. `#teamwork`. The leading `#` is optional and matching is case-insensitive.
* **Departments, locations, or teams** — pass group names. Use `listDepartments` and `listLocations` to discover valid values when the user is vague about exact names.
* **Recognition types** — celebrations, awards, incentives, or peer recognition. Call `listRecognitionTypes` to enumerate the exact values before filtering.
* **A specific giver or receiver** — resolve the person with `searchUsers` or `getUser` first, then pass their ID as `giver_id` or `receiver_id`.
* **The caller's own activity** — `current_user_only` can narrow to recognition the caller gave or received.
* **Relevance** — set `relevance: true` to bias toward the caller's most-relevant colleagues (mirrors the web "Relevant" tab).

Call `getRecognitionFeed` with the chosen filters. Each row carries the giver, receivers, amount, message, hashtags, and whether it's a top-level post or an add-on/comment. Add-on rows are not inlined, so the page stays focused on top-level recognition.

The feed is cursor-paginated. `recognitions` is one page (default 25, max 100). When `next_cursor` is non-null there are more pages — pass it back as `cursor` and keep every other input identical across pages. Don't try to fetch the whole feed at once; show a page, summarize the highlights, and offer to load more or tighten the filters.

If a filter combination returns nothing, say so and suggest loosening it — drop a filter, widen the type set, or remove the date/relevance bias.

**Access note:** this requires `recognition:read` or `recognition:administer`. If a call fails on permissions, surface the required scope.
