# Changelog

## 1.1.0 — 2026-06-13

- `/swap`: hop a live session to the airiest room. `c`/`cr`/`cw` now keep a
  wrapper around Claude; `swap-request` ends the session and the wrapper
  resumes it on the picked room. Statusline offers `/swap` at
  `CLAUSTRO_SWAP_HINT_PCT` (default 90).

## 1.0.9 — 2026-06-12

- Autopick scores the hotter of the 5h and weekly meters.
- Installer hardening: pinned sha256, atomic install, no partial execution.

## 1.0.8 — 2026-06-11

- Derive the plan from the login; drop hand-written labels.

## 1.0.7 — 2026-06-11

- Review fixes: quoting, atomic snapshots, install gating, alignment.

## 1.0.6 — 2026-06-11

- Arbitrate statusline freshness between the live payload and the snapshot.

## 1.0.5 — 2026-06-11

- Fix a bash 3.2 multibyte append bug in the usage bars.

## 1.0.3 — 2026-06-11

- Dingbat star usage bars; animated terminal demo on the site.

## 1.0.2 — 2026-06-11

- Tighter copy; cached statusline fallback for idle rooms.

## 1.0.1 — 2026-06-11

- First release: multi-account harness, rooms, autopick, statusline,
  claustrophobic.xyz.
