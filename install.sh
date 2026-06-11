#!/usr/bin/env bash
#
#   ✻ Claustrophobic installer
#   curl -fsSL https://claustrophobic.xyz/install | bash
#
set -euo pipefail

BIN_DIR="$HOME/.claustrophobic/bin"
BIN="$BIN_DIR/claustrophobic"

mkdir -p "$BIN_DIR"
curl -fsSL https://claustrophobic.xyz/claustrophobic -o "$BIN"
chmod +x "$BIN"

# Interactive terminal: walk through the full setup (it prompts via /dev/tty,
# so this works under `curl | bash`). Non-interactive (CI, AI agents): just
# install the bindings; account adding needs a human at a TTY anyway.
if [ -e /dev/tty ] && [ -t 1 ]; then
    exec "$BIN" setup
else
    "$BIN" install
fi
