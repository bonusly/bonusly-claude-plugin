---
name: manage-giving-balances
description: Use when checking a user's giving balance, granting a points boost or allowance, topping up someone's giving balance, or adjusting how many points a user has to give.
---
This skill lets an admin inspect a user's giving balance and grant increments (boosts) to it. The giving balance is the pool of points a user has available to recognize others — separate from points they've earned and can redeem.

Start by resolving the user. Use `searchUsers` or `getUser` to find them by name or email, then confirm you have the right person before continuing.

**Inspect the current balance.** Call `adminGetGiveBalance` for the user to show their current giving balance line items. Present this clearly — current balance and recent increments — so the admin understands the starting point. If they only asked to check the balance, stop here.

**Granting an increment requires explicit confirmation.** If the admin wants to add points:
* Collect the **amount** and a **reason** for the increment (for example an admin-initiated boost).
* Present back exactly what you're about to do: "Add [amount] points to [name]'s giving balance, reason: [reason]."
* Wait for the admin to explicitly say to proceed — e.g. "Yes, grant it." Do not call `adminCreateGiveBalanceIncrement` until they do.
* Then call `adminCreateGiveBalanceIncrement` with the user's ID, amount, and reason.

After granting, call `adminGetGiveBalance` again to verify the new balance and report the before/after to the admin.

If the admin wants to boost several people, handle them one at a time — confirm each grant individually rather than batching, so nothing is added without explicit sign-off.

To check the *caller's own* balances rather than another user's, use `getPointsBalance`.

**Access note:** `adminGetGiveBalance` and `adminCreateGiveBalanceIncrement` require `user:administer` or `rewards:administer`. If a call fails on permissions, surface the required scope.
