---
name: one-on-ones
description: Use when a user asks about their one-on-ones or 1:1 meetings in Bonusly — including listing upcoming or past meetings, finding out who they have meetings with, reviewing meeting summaries, reading transcripts, or looking up meeting notes from a specific conversation.
---

One-on-ones in Bonusly can be between any two people. They're mostly used for managers and their direct reports, but not always — refer to participants by name rather than inferring a reporting relationship.

## Resolving Participants

If the user names a person ("show me my meetings with Jordan"), resolve that name to a Bonusly user ID first using `searchUsers`, then pass the ID as a participant filter to `listMeetings`. Never pass an unresolved name directly to the API.

## Listing Meetings

Use `listMeetings` to get a list of meetings. Key parameters:

- `status: "upcoming"` — meetings that haven't happened yet
- `status: "complete"` — past meetings
- `participant_ids` — filter by a specific participant (resolve via `searchUsers` first)

Display results as a list with: date, participant names (resolve IDs with `getUser`), and status. If the user asks "who is my next meeting with?" or "what's my next 1:1?", default to `status: "upcoming"` sorted by soonest first.

**Empty state:** If `listMeetings` returns no results, tell the user clearly ("No upcoming 1:1s found") and offer to check the other status or widen the search.

## Getting Meeting Details

When the user wants a summary, transcript, or meeting notes from a specific meeting, use `getMeeting` with the meeting's ID. It returns everything in `listMeetings` plus:

- `summarized_brief` — AI-generated summary of the meeting. May be absent for very recent meetings still being processed; if missing, tell the user it isn't available yet.
- transcript text — the full meeting transcript
- `collaborative_document_html` — **meeting notes** (the shared document both participants edit). Render this as readable prose — do not dump raw HTML. Strip tags and present the content cleanly.

**Empty state:** If `summarized_brief` is missing, say so rather than guessing. If there's no transcript, note that it may not have been recorded.

## Handling Ambiguous Requests

- "Show me my last 1:1" → fetch `listMeetings` with `status: "complete"`, return the most recent one, and offer to show full details with `getMeeting`.
- "Summarize my meeting with [name]" → resolve the name, list their completed meetings, ask which one if there are multiple recent ones, then call `getMeeting`.
- "What did we talk about?" without a person specified → ask who the meeting was with before proceeding.

## Presenting Results

For a **meeting list**: date, participant names (not raw IDs), and status. One line per meeting.

For a **meeting detail**: lead with the date and participants, then the `summarized_brief` if available, then offer to show the transcript or meeting notes if the user wants more depth. Don't dump all fields at once.
