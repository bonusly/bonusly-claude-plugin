---
name: give-recognition
description: Use to give someone, or several people, on your team recognition through Bonusly!
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

If you don't know who you want to recognize, you can look at who's recognized you recently using the `getRecognitionReceived` tool.  

If the user has direct report (you can find that out by using the `getDirectReports` tool), it's always a good idea to see when you last recognized them.
