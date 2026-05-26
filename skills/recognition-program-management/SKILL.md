---
name: recognition-program-management
description: Tools for giving awards and managing the recognition program, give balances, and redemptions.
---

Tools for giving awards and managing the recognition program, give balances, and redemptions.

This plugin provides the following tools:

- **giveAward**: Give an award to one or more recipients in the caller's company. Mirrors POST /api/v2/bonuses with an award_id: creates an approval request. Auto-approved awards immediately produce a bonus; awards with an approval process wait for approvers. File attachments are not supported over MCP.
- **adminCreateUser**: Invite a new user to the caller's company. Reactivates a deactivated user if the email already exists in the same company.
- **adminUpdateUser**: Update attributes of a user in the caller's company. The authenticated caller must be a company admin.
- **adminDeactivateUser**: Schedule a user in the caller's company for deactivation.
- **adminGetGiveBalance**: Fetch a user's giving balance line items with pagination.
- **adminCreateGiveBalanceIncrement**: Add a giving balance increment (e.g. admin_initiated_boost) to a user in the caller's company.
- **adminRewardsApproveRedemption**: Approves a pending reward redemption for the caller's company.
- **adminRewardsDeclineRedemption**: Declines a reward redemption for the caller's company.
- **adminRewardsRefundRedemption**: Refunds a custom reward redemption for the caller's company. Superadmins must use the super_admin path instead.
- **adminRewardsFulfillRedemption**: Fulfills a custom reward redemption for the caller's company.
- **adminRewardsUnfulfillRedemption**: Marks a fulfilled custom reward redemption as unfulfilled for the caller's company.
