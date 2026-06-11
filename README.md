# ✻ Claustrophobic

Multi-account harness for Claude Code — for when the walls close in.

**[claustrophobic.xyz](https://claustrophobic.xyz)** ·
`curl -fsSL https://claustrophobic.xyz/install | bash`

Run several Claude subscriptions side by side, switch between them with one
keystroke, and always know how much air each one has left. Sessions, settings,
skills, and plugins are shared across accounts, so switching mid-task is just:
exit Claude, run `cr`, and the session resumes on whichever account has the
most headroom.

## Install

Copy the single script anywhere and run:

```sh
bash claustrophobic setup
```

Setup registers your current `~/.claude` login as room 1, installs the
`c` / `cr` / `cw` / `cl` shell bindings (commenting out any aliases with those
names — a backup of your rc file is kept), optionally installs the statusline,
and walks you through adding more accounts via the official `claude` login
flow. Safe to re-run.

Requires: bash 3.2+ (stock macOS is fine), the `claude` CLI, and `python3`
(Xcode Command Line Tools) or `node`.

## Use

```text
c                 launch Claude on the airiest room (lowest 5h usage)
c 2               launch Claude as account 2
cr [id]           resume — works across accounts, sessions are shared
cw [id]           launch in a git worktree
cl                show all rooms, plans, and usage
cl add            add another account
cl label 2 "Max 20x"
cl rm 3 · cl relogin 3 · cl help
```

The statusline inside Claude shows the active room and its air supply:

```text
✻ 2 ai-001 │ 5h ▓▓░░░ 34% → 15:00 │ wk 12% │ Opus 4.8 │ builder
```

## How it works

- Each extra account lives in its own `CLAUDE_CONFIG_DIR` profile under
  `~/.claustrophobic/profiles/<id>` — credentials are isolated, and the
  official Claude CLI handles login.
- `projects/` (sessions + memory), `settings.json`, skills, agents, commands,
  hooks, and plugins are symlinked back to your main `~/.claude`, so every
  room feels identical.
- The statusline doubles as the usage collector: every time it renders, it
  snapshots that account's rate-limit usage to `~/.claustrophobic/usage/`.
  `cl` and the auto-picker read those snapshots. Idle rooms show their last
  known reading (marked by SEEN); rooms past their reset count as fresh.

## Notes

- Default launch flags are `--dangerously-skip-permissions` (configurable in
  `~/.claustrophobic/config`, asked during setup).
- Accounts must be distinct emails — two rooms on one account share rate
  limits and may fight over the macOS Keychain entry.
- First launch of a new room in a given project directory re-asks the folder
  trust prompt (trust state lives per profile).
- Uninstall: remove the `>>> claustrophobic >>>` block from your rc file,
  restore the commented aliases, run
  `~/.claustrophobic/bin/claustrophobic statusline uninstall`, then delete
  `~/.claustrophobic/`.

## Repo layout

- `claustrophobic` — the entire tool, one bash script (canonical source).
- `install.sh` — the `curl | bash` installer, served at `/install`.
- `site/` — claustrophobic.xyz, a Cloudflare assets-only Worker. `public/`
  holds the page, `llms.txt` (agent setup instructions), and deploy-time
  copies of the script/installer (gitignored).
- `deploy.sh` — copies the script + installer into `site/public/` and runs
  `wrangler deploy`. Uses your ambient wrangler login; set
  `WRANGLER_XDG_CONFIG_HOME` to deploy with a directory-local auth store.
