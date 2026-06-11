# ✻ Claustrophobic

Multi-account harness for Claude Code. When the walls close in, switch rooms.

[claustrophobic.xyz](https://claustrophobic.xyz)

```sh
curl -fsSL https://claustrophobic.xyz/install | bash
```

Setup keeps your current login as room 1 and adds more rooms through the
official `claude` login. Safe to re-run. The whole tool is one bash script:
[`claustrophobic`](claustrophobic).

## Use

```text
c                 launch on the airiest room (lowest 5h usage wins)
c 2               launch as account 2; same for cr 2, cw 3
cr [id]           resume any session, from any account
cw [id]           launch in a git worktree
cl                rooms, plans, usage
cl add            add a room · cl rm 3 · cl help
```

## How it works

1. Every account gets its own room: a separate `CLAUDE_CONFIG_DIR` profile.
   The official Claude CLI does the logging in.
1. Rooms share furniture. Sessions, settings, skills and plugins are
   symlinked to your main `~/.claude`, so `cr` resumes any session from any
   account.
1. The statusline is the sensor. Every render snapshots that room's rate
   limits for `cl` and the auto-picker. Idle rooms show their last known air.

## Notes

- Needs macOS or Linux, bash 3.2+, the `claude` CLI, and python3 or node.
- Accounts must be distinct emails.
- Launch flags default to `--dangerously-skip-permissions`; change them in
  `~/.claustrophobic/config`.
- Whether multiple subscription accounts sit within Anthropic's consumer
  terms is between you and Anthropic. Read them first.
- Uninstall: remove the claustrophobic block from your rc file, run
  `claustrophobic statusline uninstall`, delete `~/.claustrophobic/`.

## Repo layout

- `claustrophobic`: the tool, one bash script.
- `install.sh`: the installer, served at `/install`.
- `site/`: claustrophobic.xyz, a Cloudflare assets-only Worker.
- `deploy.sh`: copies script and installer into `site/public/`, then runs
  `wrangler deploy`.
