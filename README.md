# Bonusly Claude Plugin

Bonusly recognition, rewards, and reporting tools for Claude Code, Desktop or Claude.ai. The plugin connects Claude to the Bonusly MCP server and ships a set of skills that guide common recognition, rewards, admin, and reporting workflows.

## What's included

- **MCP server** — connects to the Bonusly MCP endpoint (`https://bonus.ly/mcp`) over HTTP, exposing the recognition, rewards, user-admin, and reporting tools.
- **16 skills** — task-oriented guides that tell Claude how to combine those tools safely (resolving people before acting, confirming before writes, surfacing required OAuth scopes on failure).

## Installation

Add this repo as a marketplace, then install the plugin:

```
/plugin marketplace add bonusly/bonusly-claude-plugin
/plugin install bonusly@bonusly
```

Alternatively, check out the [latest release](https://github.com/bonusly/bonusly-claude-plugin/releases/latest) or add this repository as a plugin directly. Once installed, Claude auto-discovers the skills and connects to the Bonusly MCP server defined in `plugin.json`. You'll authenticate with Bonusly the first time a tool needs it.


## Skills

### Recognition

| Skill | Use it when… |
|-------|--------------|
| `give-recognition` | Giving recognition to one or more colleagues (or a group), and editing or undoing a recognition within the short editing window. |
| `recognize-my-team` | A manager wants to recognize their direct reports, check who they've missed, or send team-wide recognition. |
| `recognition-history` | Viewing your own or a colleague's recognition history — received, given, last recognized, or searching by theme. |
| `browse-recognition-feed` | Browsing the company recognition feed, filtered by hashtag, department, location, team, type, giver, or receiver. |
| `find-unrecognized-employees` | Finding people who haven't been recognized recently — participation gaps across a team, department, or company. |

### Rewards

| Skill | Use it when… |
|-------|--------------|
| `my-redemptions` | Seeing your own reward redemptions — status, claim links, or whether a redemption went through. |
| `process-redemptions` | An admin reviews the redemption queue — approving, declining, fulfilling, or refunding requests. |
| `rewards-spend-report` | Read-only reporting on reward spend — totals and detail by department or country. |

### People & org admin

| Skill | Use it when… |
|-------|--------------|
| `onboard-new-hire` | Adding a new employee / creating a user account. |
| `update-employee` | Editing an active employee — reassigning manager, changing department/location, adjusting admin access, fixing profile fields. |
| `offboard-employee` | Deactivating a departing employee (handling their reports first) or reactivating an account. |
| `manage-giving-balances` | Checking a user's giving balance or granting a points boost. |
| `explore-org-chart` | Navigating the reporting hierarchy — manager chains, reporting trees, top-level users. |

### Awards & reporting

| Skill | Use it when… |
|-------|--------------|
| `manage-awards` | Creating, updating, reviewing, or retiring custom awards. |
| `participation-report` | Pulling recognition participation rates by department, location, or manager team. |
| `admin-mcp-usage` | Reporting on MCP tool usage — call counts, most-used tools, or per-date breakdowns. |

## Development

- Skills live in `skills/<name>/SKILL.md` and are auto-discovered — no manifest registration needed.
- `.claude/TOOLS.md` is a reference list of the available MCP tools, used when authoring new skills.
- Build a distributable zip with `bash scripts/package.sh` (output lands in `dist/`).
