---
name: give-recognition
description: Use to give recognition to one or more colleagues (or a group) through Bonusly, and to edit or undo a recognition you just gave within the short editing window.
---
Recognition is the core of Bonusly and each one requires a few pieces of information:

* Recipients: At least one person, or a group.  Use searchUsers or getUser to look for people or groups the user may be talking about to find the id to use in `recipient_ids`.
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

If you don't know who you want to recognize, you can look at who's recognized you recently using the `getRecognitionReceived` tool.  You can also ask when you last recognized someone and use the `getRecognitionGivenToUsers` tool to see when you last recognized a group of users.

If the user has direct reports (you can find that out by using the `getDirectReports` tool), it's always a good idea to see when you last recognized them.

If recognizing a group — `@everyone`, a department, a location, or a manager's team — you can check how many people it would reach (and who they are) before posting with `getGroupRecognitionRecipientCount`. This matters because the giver pays the point amount for *each* recipient, so a group post can cost far more than it first appears. Surface the recipient count and the total cost so the user understands the spend before approving.

Always ask the user to approve the final recognition text and point value before sending the recognition.

**Editing or undoing a recognition you just gave.** Because of the short editing window, this often comes up right after sending one. Both actions only work on recognition the caller gave/initiated, within 24 hours of creation, and only while the points haven't already been spent (a company admin can also delete). If a call fails because the window has closed or points were spent, surface that plainly rather than retrying.

* **Edit the message** — use `updateRecognition` with the recognition's `id` and the NEW, *complete* `reason`. This **replaces the entire message**, so it must include the `+amount`, `@mentions`, and `#hashtag` you want to keep (e.g. `+50 @jane.doe Updated message #teamwork`). Omitting any of them drops them from the recognition. Build the full replacement string from the existing recognition, show the user the exact new text, and get approval before sending.
* **Undo / delete** — use `deleteRecognition` with the recognition's `id`. This is destructive and cannot be reversed, so confirm explicitly ("Yes, delete it") before calling it.

If you don't have the recognition's `id`, find it first — e.g. via `getRecognitionGiven` for the caller, or `searchRecognitions`.
