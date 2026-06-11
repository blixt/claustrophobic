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

# Setup prompts via /dev/tty, so it works under curl | bash. Without a TTY
# (CI, agents) install bindings only; adding accounts needs a human.
if [ -e /dev/tty ] && [ -t 1 ]; then
    exec "$BIN" setup
else
    "$BIN" install
fi
