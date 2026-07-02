---
name: recognize-my-team
description: Use when a manager wants to recognize their direct reports, check who they haven't recognized recently, or send team-wide recognition.
---
Recognizing your team is one of the highest-impact things a manager can do. This skill helps you do it thoughtfully — making sure nobody is overlooked and every message feels personal.

Start by calling `me` to establish who you are, then call `getDirectReports` with your user ID to get your full team roster.

Before drafting any messages, call `adminUsersLastRecognized` with your direct reports' IDs to see who you've recognized recently and who is overdue. Present this to the manager — something like "You haven't recognized [name] in over 30 days" — so they can make an informed choice about who to prioritize.

Ask: **recognize everyone, or focus on those who haven't been recognized recently?**

Before sending, always check `getPointsBalance` to confirm there are enough points to cover the planned recognitions. If not, surface the constraint and let the manager adjust scope.

Call `listRecognitionTypes` to get valid hashtags if the manager doesn't already know which ones to use.

For each recognition, draft a unique message. Apply the five quality criteria:

1. **specific** — names the concrete action, not just a vague compliment
2. **contextual** — explains why it mattered in context
3. **values_aligned** — connects to company values
4. **personal** — addresses the individual, not a generic team member
5. **genuine** — feels authentic, not copy-pasted

If you don't know what a specific person did to deserve recognition, **ask the manager** — don't invent reasons. A fabricated recognition does more harm than none.

Present all draft messages to the manager for review and approval before sending anything. Allow edits to individual messages. Only call `giveRecognition` once the manager has confirmed each message.

Send recognitions one at a time via `giveRecognition` and report success or failure after each. Finish with a summary: who was recognized, total points spent, and remaining balance.

**If a `giveRecognition` call reports an error, don't blindly retry.** A timeout or network error can come back *after* the recognition already posted, and re-sending risks a duplicate post and a double point charge — costly when recognizing a whole team. First verify whether it took effect — re-fetch with `getRecognitionGivenToUsers` or `getRecognitionGiven` — and only re-send to that person if it genuinely didn't go through.

**If the caller has no direct reports**, let them know and offer to help recognize a specific colleague instead using the standard `give-recognition` workflow.

**If `adminUsersLastRecognized` fails** (access-gated for non-admins), fall back to asking the manager directly: "When did you last recognize each person on your team?" and use that to guide prioritization.
