---
name: recognition
description: "Tools for giving recognition and seeing what recognition you've received."
---

# Introduction

Tools for giving recognition and seeing what recognition you've received.

# Giving Recognition

Recognition is the core of Bonusly and each one requires a few pieces of information: 

* A recipient: this is at least one person, or a group.  Use searchUsers or getUser to look for people or groups the user may be talking about to find the id to use in `recipient_ids`.
* An amount: Sometimes, bonuses can have zero points, and sometimes they can't.  Use the `getPointsBalance` tool to see how many points you have available to give.
* A reason: Why are you recognizing this person? What did they do? It should be meaningful, genuine and specific.
* A hashtag: The hashtag to use in the recognition.  This is optional most of the time. If it's required, an error will come back and the list of hashtags will be in the required schema.

The way to think about recognition is to look at it in these five ways, so if someone asks for feedback on a recognition they way to give someone, this is a good way to think about it:

1. **specific** — names the concrete action, not just the result
2. **contextual** — explains why the contribution mattered in context
3. **values_aligned** — connects to company values
4. **personal** — addresses the individual personally
5. **genuine** — feels authentic, not formulaic

The tool to call when actually sending the recognition is `giveRecognition`.

# Available tools

This skill recommends using the following tools from the bonusly MCP server:

## getPointsBalance - Get points balance

Get the authenticated user's current points balances and lifetime stats.
Returns giving balance, earned/redeemable balance (earnings), monthly budget,
currency, exchange rate, lifetime earnings, lifetime given, and lifetime redeemed.
Also returns `exchange_rate` (points per 1 unit of `currency`) and
`purchasing_power_parity_enabled` so callers can answer fiat-conversion
questions like "how much is N points worth?".
Use this for any question about your own points balance, earnings, or recognition stats.


Required OAuth scope: `user:read`

## giveRecognition - Give recognition

Send recognition (a bonus) to a single colleague on behalf of the authenticated
caller. Minimum-viable shape: one recipient, an integer points amount, a free-form
reason, and one company hashtag. The hashtag must be one of the caller's company's
configured hashtags (see `listRecognitionTypes` for the current list, or rely on the
enum returned by the elicitation form).

Inputs:
- `recipient` (string) — recipient as a user id, email address, or display name.
- `amount` (integer) — points to give. Pass 0 only if your company allows zero-point.
- `reason` (string) — free-form recognition message (no need to include @mentions or
  `+amount` — they're synthesized from `recipient` and `amount`).
- `hashtag` (string) — one company hashtag without the leading `#` (e.g. "teamwork").

When any required input is missing, the response either carries a `requestedSchema`
(for clients that declared `elicitation` at initialize) or a standard `INVALID_PARAMS`
error. Either way the missing-field list is returned so the caller can retry.

Returns the new bonus id and a permalink path on success.


Required OAuth scope: `recognition:write`

## getRecognitionReceived - Get recognition received

List recognition (bonuses) received BY a user within your company. Returns who gave them
recognition, the hashtags used, and the recognition message — plus windowed earned totals.
Use this to understand what someone has been recognized for, or for "how many points did a
user earn/receive this month?".

Identify the user with `target_user` (an ID, email address, or name); omit it to look up the
authenticated caller.

Time window: pass `start_date` and `end_date` (ISO `YYYY-MM-DD`) for calendar-based ranges
("this month", "last month", a specific month). `days_back` is a rolling lookback (default 90,
max 1825) and is only correct when the request is explicitly "last N days".

For windowed earned totals use `total_points_received` (the full-window sum of points earned)
and `total_recognition_count` (full-window count). Never sum the per-row `amount` across
`recognitions` — that array is one page and will undercount.

Pagination is cursor-based. `recognitions` is a single page (size `limit`, default
20, max 50);
when more pages exist `next_cursor` is non-null — pass it back as `cursor` to fetch the next
page. Keep the rest of the input identical across pages.


Required OAuth scope: `recognition:read` or `recognition:administer`

## getRecognitionGiven - Get recognition given

List recognition (bonuses) given BY a user to others within your company. Returns
recipients, hashtags, the recognition message, and the giver's per-recognition spend.
Use for "When did a user recognize X?", "What have they recognized people for?", or
"How many points did a user give this month?".

Identify the giver with `target_user` (an ID, email address, or name); omit it to look up
the authenticated caller. Optionally narrow to recognition given TO a specific person with
`receiver_user`, or to a group with `target_group`.

Cost model (important for math): a recognition's `points_per_recipient` is the amount on the
post; the giver pays `points_per_recipient * recipient_count`. Use
`total_points_spent_by_giver` for the giver-side total — never split a post amount across
recipients, and never sum the per-row `cost` across `recognitions` (that array is one page;
the summary totals cover the full window).

Time window: pass `start_date` and `end_date` (ISO `YYYY-MM-DD`) for calendar ranges
("this month", a specific month). `days_back` is a rolling lookback (default 90, max 1825)
and is only correct for "last N days".

Cursor pagination: set the filters and `page_size` on the first call; to fetch the next page
pass ONLY the returned `next_cursor` (it encodes the filters, page size, and position — no
other arguments are needed or read). A null `next_cursor` means there are no more pages.


Required OAuth scope: `recognition:read` or `recognition:administer`

## getGroupRecognitionRecipientCount - Get group recognition recipient count

Resolve a Bonusly user group by name, slug, or type and return how many
recipients an actual group post would reach within your company — plus a
paginated roster of those recipients (id and name).

Accepted inputs for `group_name`:
- "everyone" → the @everyone group (all active receiving users in the
  company)
- A department name (e.g. "Engineering")
- A location name (e.g. "Berlin")
- A team — the manager's name plus "team" (e.g. "Sarah's team") or the
  team slug

Returns `recipient_count` plus the resolved `group_name` / `group_type` /
`group_slug`, and a `members` array of {id, name}. Membership is
paginated: `members` is one page (size `limit`, default
50, max
200); when more pages
exist `next_cursor` is non-null — pass it back as `cursor` to fetch the
next page. Keep the rest of the input (notably `group_name`) identical
across pages.

Returns an error if no matching group is found, or if more than one
non-reserved group matches the same name (e.g. a department and a
location both named "Sales").


Required OAuth scope: `recognition:read` or `recognition:administer`

## getRecognitionFeed - Get recognition feed

Return a page of the recognition feed for the authenticated caller's company —
the same content shown in Bonusly's web home feed (top-level posts in
reverse-chronological order).

Filters (all optional, all combined as AND):
- `departments`, `locations`, `teams` — arrays of group names; combine with
  `listDepartments` / `listLocations` to discover valid values.
- `hashtags` — array of hashtag strings; leading `#` is optional and
  matching is case-insensitive (e.g. both `"teamwork"` and `"#teamwork"`
  match `#teamwork`).
- `recognition_types` — subset of celebrations, awards, incentives, peer.
  Call `listRecognitionTypes` to enumerate the values.
- `current_user_only` — subset of given, received
  (recognition the caller gave / received).
- `giver_id`, `receiver_id` — restrict to a specific user.
- `relevance` — when `true`, bias toward the caller's most-relevant
  colleagues (mirrors the web "Relevant" tab).

Pagination is cursor-based. `recognitions` is a single page (size `limit`,
default 25, max
100); when more pages exist
`next_cursor` is non-null — pass it back as `cursor` to fetch the next
page. Keep the rest of the input identical across pages.

Each row carries giver + receivers, amount, reason, hashtags, top-level vs
add-on/comment shape, and `child_bonus_count` (number of add-ons/comments
attached). Add-on rows themselves are not inlined to keep pages small.


Required OAuth scope: `recognition:read` or `recognition:administer`

## listRecognitionTypes - List recognition types

Return the recognition-type values accepted by the `recognition_types` filter
on `getRecognitionFeed`. Each entry has a machine-readable `value` (pass this
into the filter) and a human-readable `name`.


Required OAuth scope: `recognition:read` or `recognition:administer`

## searchRecognitions - Search recognitions

Search recognition (bonuses) in your company using natural language. Combines semantic
(vector) and keyword (BM25) retrieval, so themes like "leadership during difficult times"
and exact terms like a project codename or hashtag both work. Returns ranked excerpts
with the giver, the source bonus id, and a link.

Pass `query` (required) on the first call, with an optional `limit`
(default 10, max 25). For subsequent pages echo the returned
`next_cursor` back as `cursor` — the cursor preserves the original `query` and `limit`,
so you do not need to (and should not) re-send them. `next_cursor` is null when there
are no more pages.


Required OAuth scope: `recognition:read` or `recognition:administer`

