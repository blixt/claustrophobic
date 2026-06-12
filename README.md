# ✻ Claustrophobic

Multi-account harness for Claude Code. When the walls close in, switch rooms.

[claustrophobic.xyz](https://claustrophobic.xyz) ·
[github.com/blixt/claustrophobic](https://github.com/blixt/claustrophobic)

```sh
curl -fsSL https://claustrophobic.xyz/install | bash
```

Setup keeps your current login as room 1 and adds more rooms through the
official `claude` login. Safe to re-run. The whole tool is one bash script:
[`claustrophobic`](claustrophobic).

## Use

```text
c                 launch on the airiest room (coolest of 5h + weekly usage)
c 2               launch as account 2; same for cr 2, cw 3
cr [id]           resume any session, from any account
cw [id]           launch in a git worktree
/swap             in Claude: hop this session to the airiest room
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
1. `/swap` is the escape hatch. `c`/`cr`/`cw` keep a small wrapper around
   Claude; `/swap` (or `! cl swap-request`) exits Claude and the wrapper
   resumes the same session on the airiest room. The statusline offers it
   once usage hits `CLAUSTRO_SWAP_HINT_PCT` (default 90).

## Notes

- Needs macOS or Linux, bash 3.2+, the `claude` CLI, and python3 or node.
- Accounts must be distinct emails.
- Launch flags default to `--dangerously-skip-permissions`; change them in
  `~/.claustrophobic/config`.
- Whether multiple subscription accounts sit within Anthropic's consumer
  terms is between you and Anthropic. Read them first.
- The installer pins the script's sha256 and refuses mismatches; current
  checksums at <https://claustrophobic.xyz/checksums.txt>.
- Uninstall: remove the claustrophobic block from your rc file, run
  `claustrophobic statusline uninstall`, delete `~/.claustrophobic/` and
  `~/.claude/commands/swap.md`.

## Repo layout

- `claustrophobic`: the tool, one bash script.
- `CHANGELOG.md`: notable changes per release.
- `install.sh`: the installer, served at `/install`.
- `site/`: claustrophobic.xyz, a Cloudflare assets-only Worker.
- `deploy.sh`: copies script and installer into `site/public/`, then runs
  `wrangler deploy`.
