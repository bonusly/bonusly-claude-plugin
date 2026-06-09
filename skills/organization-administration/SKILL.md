---
name: organization-administration
description: "Tools for managing your organization within Bonusly (more coming soon)."
---

# Introduction

Tools for managing your organization within Bonusly (more coming soon).

# Available tools

This skill recommends using the following tools from the bonusly MCP server:

## adminCreateUser - Create user

Invite a new user to the caller's company. Reactivates a deactivated user if the email already exists in the same company.

Required OAuth scope: `user:administer`

## adminUpdateUser - Update user

Update attributes of a user in the caller's company. The authenticated caller must be a company admin.

Required OAuth scope: `user:administer`

## adminDeactivateUser - Deactivate user

Schedule a user in the caller's company for deactivation.

Required OAuth scope: `user:administer`

## adminGetUser - Admin get user

Get a single ACTIVE user's full admin profile by ID, email,
or name. Deactivated users surface as not found in this
phase. Returns id, names, email, department, manager,
custom_properties, locale, time_zone, hired_on, and
last_active_at, plus three role-related fields the caller
must not conflate: role (coarse "admin" / "employee"),
company_admin (legacy single-flag), and permission_names
(humanized fine-grained admin capabilities). When the
identifier is ambiguous, returns a disambiguation payload
listing candidates so the caller can re-issue the request
with a chosen ID. Admin-only — gated on the same policy
as the Bizy chat UserAdmin agent.


Required OAuth scope: `user:administer`

## adminListUsers - Admin list users

List active users in the authenticated caller's company with
optional filters: name/email search, department (exact
match), role (admin / employee), manager presence (managers /
without_manager), and Bizy enrollment (bizy_enabled /
bizy_disabled). Returns paginated structured rows plus
counts, available departments, and the filters that were
applied. Pagination is cursor-based: pass `page_size` on the
first call and the returned `next_cursor` on subsequent
calls. Admin-only — gated on the same policy as the Bizy
chat UserAdmin agent.


Required OAuth scope: `user:administer`

