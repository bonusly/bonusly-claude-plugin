---
name: give-recognition
description: Use to give recognition to one or more colleagues (or a group) through Bonusly, and to edit or undo a recognition you just gave within the short editing window.
---
Recognition is the core of Bonusly and each one requires a few pieces of information:

* Recipients: At least one person, or a group.  Use searchUsers or getUser to look for people, and `listSystemUserGroups` or `listCustomUserGroups` to find groups the user may be talking about to find the id to use in `recipient_ids`.
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

If the user wants to recognize multiple people, _and_ give each of those people (or groups) points, they all need to be addressed in the recognition as `@username` separately.  You can combine both regular users and groups in a recognition.

When including multiple people or a group in a recognition with points attached, _each_ person will receive that number of points.  So if the recognition has `+3` in it, and has `@tim`, `@jane` and `@murray` in it, the user is spending 9 points on that recognition. Confirm that the user has enough points available to distribute that many points. If they are giving points to a group, the same thing happens: that many points are given to _every_ member of the group.  You can use the `listSystemUserGroups` and `listCustomUserGroups` tools to get the counts for every group to do the calculation and confirm that the user has enough points for the recognition. 

If the user just wants to "tag" another user in the recognition, but _not_ give them points, you do that by using the `&` character directly followed by the user's username or the group's name, like: `&jimmy.olsen`.

**Always** ask the user to approve the final recognition text and point value before sending the recognition.

**Editing or undoing a recognition you just gave.** Because of the short editing window, this often comes up right after sending one. Both actions only work on recognition the caller gave/initiated, within 24 hours of creation, and only while the points haven't already been spent (a company admin can also delete). If a call fails because the window has closed or points were spent, surface that plainly rather than retrying.

* **Edit the message** — use `updateRecognition` with the recognition's `id` and the NEW, *complete* `reason`. This **replaces the entire message**, so it must include the `+amount`, `@mentions`, and `#hashtag` you want to keep (e.g. `+50 @jane.doe Updated message #teamwork`). Omitting any of them drops them from the recognition. Build the full replacement string from the existing recognition, show the user the exact new text, and get approval before sending.
* **Undo / delete** — use `deleteRecognition` with the recognition's `id`. This is destructive and cannot be reversed, so confirm explicitly ("Yes, delete it") before calling it.

If you don't have the recognition's `id`, find it first — e.g. via `getRecognitionGiven` for the caller, or `searchRecognitions`.

**If a write call (`giveRecognition`, `updateRecognition`, `deleteRecognition`) reports an error, don't blindly retry.** Timeouts and network errors can come back *after* the write already succeeded, and a blind retry risks a duplicate recognition (or a double point charge). First verify whether it actually took effect — re-fetch with `getRecognitionGiven` or `getRecognition` — and only retry if it genuinely didn't happen.
