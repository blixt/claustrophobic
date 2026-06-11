#!/usr/bin/env bash
#
#   ✻ Claustrophobic installer
#   curl -fsSL https://claustrophobic.xyz/install | bash
#
set -euo pipefail

# substituted by deploy.sh; pins the exact script this installer will accept
CLAUSTRO_SHA256="__CLAUSTRO_SHA256__"

main() {
    local bin_dir="$HOME/.claustrophobic/bin"
    local bin="$bin_dir/claustrophobic"
    local tmp sum

    case "$CLAUSTRO_SHA256" in
        __*) echo "this installer is built at deploy time; use https://claustrophobic.xyz/install" >&2; exit 1 ;;
    esac

    tmp=$(mktemp)
    trap 'rm -f "$tmp"' EXIT
    curl -fsSL https://claustrophobic.xyz/claustrophobic -o "$tmp"

    if command -v sha256sum >/dev/null 2>&1; then
        sum=$(sha256sum "$tmp")
    else
        sum=$(shasum -a 256 "$tmp")
    fi
    sum=${sum%% *}
    if [ "$sum" != "$CLAUSTRO_SHA256" ]; then
        echo "✻ claustrophobic: download does not match the pinned checksum; refusing to install" >&2
        echo "  expected $CLAUSTRO_SHA256" >&2
        echo "  got      $sum" >&2
        exit 1
    fi

    mkdir -p "$bin_dir"
    mv -f "$tmp" "$bin"
    chmod +x "$bin"
    trap - EXIT
    echo "✻ verified sha256 $sum"

    # Setup prompts via /dev/tty, so it works under curl | bash. Without a TTY
    # (CI, agents) install bindings only; adding accounts needs a human.
    if [ -e /dev/tty ] && [ -t 1 ]; then
        exec "$bin" setup
    else
        "$bin" install
    fi
}

main "$@"
