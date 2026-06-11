#!/usr/bin/env bash
# Deploy claustrophobic.xyz. The site is a Cloudflare assets-only Worker; the
# served script/installer are copies of the repo-root originals made here so
# the repo root stays the single source of truth.
#
# Auth: uses your ambient `wrangler login` session. To deploy with a
# directory-local wrangler auth store (the XDG pattern), set
# WRANGLER_XDG_CONFIG_HOME to that xdg-config directory first.
set -euo pipefail
cd "$(dirname "$0")"

cp claustrophobic site/public/claustrophobic
cp install.sh site/public/install

# Ambient CLOUDFLARE_*/CF_* vars (e.g. from another project's env) would
# override the account in wrangler.jsonc — strip them so only the wrangler
# login decides who we are.
unset CF_API_KEY CF_API_TOKEN CF_EMAIL \
    CLOUDFLARE_ACCOUNT_ID CLOUDFLARE_API_KEY CLOUDFLARE_API_TOKEN \
    CLOUDFLARE_API_USER_SERVICE_KEY CLOUDFLARE_EMAIL CLOUDFLARE_ZONE_ID

if [ -n "${WRANGLER_XDG_CONFIG_HOME:-}" ]; then
    export XDG_CONFIG_HOME="$WRANGLER_XDG_CONFIG_HOME"
fi

cd site
wrangler deploy
