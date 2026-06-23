# Bonusly Claude Plugin

Bonusly recognition, rewards, and reporting tools for Claude Code, Desktop or Claude.ai. The plugin connects Claude to the Bonusly MCP server and ships a set of skills that guide common recognition, rewards, admin, and reporting workflows.

**Note**: We consider this early access as both it, and the [MCP server](https://docs.bonus.ly/v3.0/reference/getting-started-1) that backs it, are in active development.  Things will probably change frequently!

## What's included

- **MCP server** — connects to the Bonusly MCP endpoint (`https://bonus.ly/mcp`) over HTTP, exposing the recognition, rewards, user-admin, and reporting tools.
- **17 skills** — task-oriented guides that tell Claude how to combine those tools safely (resolving people before acting, confirming before writes, surfacing required OAuth scopes on failure).

# Installation

## Installation in Claude 

Add this repo as a marketplace in Claude Code, then install the plugin:

```
/plugin marketplace add bonusly/bonusly-claude-plugin
/plugin install bonusly@bonusly
```

These commands also work in the desktop app — open the Claude Code panel in Claude Desktop and run them there; the install is shared with your CLI.

### Distribute to a Claude organization

Plugin marketplaces are a Claude Code feature, so org-wide distribution is done through settings files, not a console screen:

- **Auto-prompt a team/repo** — add the marketplace to the project's `.claude/settings.json` so members are prompted to install when they trust the folder:

  ```json
  {
    "extraKnownMarketplaces": {
      "bonusly": {
        "source": { "source": "github", "repo": "bonusly/bonusly-claude-plugin" }
      }
    },
    "enabledPlugins": {
      "bonusly@bonusly": true
    }
  }
  ```

- **Lock it down org-wide** — admins can restrict which marketplaces users may add via the [`strictKnownMarketplaces`](https://code.claude.com/docs/en/settings#strictknownmarketplaces) setting in managed settings (e.g. allowlist only `bonusly/bonusly-claude-plugin`).

Alternatively, check out the [latest release page](https://github.com/bonusly/bonusly-claude-plugin/releases/latest) to download the zip file and add the plugin to your Claude Organization manually on the [plugins page](https://claude.ai/admin-settings/plugins).  Just upload the zip file and choose whether it's automatically installed, or just available. The only issue with this approach is that the plugin doesn't automatically update as we make improvements to it, but it does give you more control!

## Installation in OpenAI Codex

Installation in Codex is straightforward.  There's no _official_ marketplace for plugins yet, so installation is only supported from this repo at the moment.

In the Codex desktop app:

* Click Plugins in the left column.
* Next to the **+** in the top right corner, click the down arrow and choose **+ Add marketplace**.
* The fields to fill out:
  * Source: `bonusly/bonusly-claude-plugin`
  * Git ref: `main`
* Click **Add marketplace**

It will open up Bonusly and take you to a page asking you to authorize Codex to act on your behalf.  Clicking **Authorize** allows Codex to make calls to the Bonusly Connector to do things like give recognition, fetch the recognition feed, etc.

# Skills

## Recognition

| Skill | Use it when… |
|-------|--------------|
| `give-recognition` | Giving recognition to one or more colleagues (or a group), and editing or undoing a recognition within the short editing window. |
| `recognize-my-team` | A manager wants to recognize their direct reports, check who they've missed, or send team-wide recognition. |
| `recognition-history` | Viewing your own or a colleague's recognition history — received, given, last recognized, or searching by theme. |
| `browse-recognition-feed` | Browsing the company recognition feed, filtered by hashtag, department, location, team, type, giver, or receiver. |
| `find-unrecognized-employees` | Finding people who haven't been recognized recently — participation gaps across a team, department, or company. |

## Rewards

| Skill | Use it when… |
|-------|--------------|
| `my-redemptions` | Seeing your own reward redemptions — status, claim links, or whether a redemption went through. |
| `process-redemptions` | An admin reviews the redemption queue — approving, declining, fulfilling, or refunding requests. |
| `rewards-spend-report` | Read-only reporting on reward spend — totals and detail by department or country. |
| `claim-incentive` | Claiming a claimable award ("incentive") for yourself — a self-service achievement, milestone, or perk you've earned. |

## People & org admin

| Skill | Use it when… |
|-------|--------------|
| `onboard-new-hire` | Adding a new employee / creating a user account. |
| `update-employee` | Editing an active employee — reassigning manager, changing department/location, adjusting admin access, fixing profile fields. |
| `offboard-employee` | Deactivating a departing employee (handling their reports first) or reactivating an account. |
| `manage-giving-balances` | Checking a user's giving balance or granting a points boost. |
| `explore-org-chart` | Navigating the reporting hierarchy — manager chains, reporting trees, top-level users. |

## Awards & reporting

| Skill | Use it when… |
|-------|--------------|
| `manage-awards` | Creating, updating, reviewing, or retiring custom awards. |
| `participation-report` | Pulling recognition participation rates by department, location, or manager team. |
| `admin-mcp-usage` | Reporting on MCP tool usage — call counts, most-used tools, or per-date breakdowns. |

# Development

- Skills live in `skills/<name>/SKILL.md` and are auto-discovered — no manifest registration needed.
- `.claude/TOOLS.md` is a reference list of the available MCP tools, used when authoring new skills.
- Build a distributable zip with `bash scripts/package.sh` (output lands in `dist/`).
