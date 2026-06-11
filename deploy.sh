#!/usr/bin/env bash
# Deploy claustrophobic.xyz: copy the script and installer into site/public/
# (the repo root stays the source of truth), then wrangler deploy. Set
# WRANGLER_XDG_CONFIG_HOME to deploy with a directory-local auth store.
set -euo pipefail
cd "$(dirname "$0")"

cp claustrophobic site/public/claustrophobic
cp install.sh site/public/install

# Ambient CLOUDFLARE_*/CF_* vars would override wrangler.jsonc's account;
# only the wrangler login should decide identity.
unset CF_API_KEY CF_API_TOKEN CF_EMAIL \
    CLOUDFLARE_ACCOUNT_ID CLOUDFLARE_API_KEY CLOUDFLARE_API_TOKEN \
    CLOUDFLARE_API_USER_SERVICE_KEY CLOUDFLARE_EMAIL CLOUDFLARE_ZONE_ID

if [ -n "${WRANGLER_XDG_CONFIG_HOME:-}" ]; then
    export XDG_CONFIG_HOME="$WRANGLER_XDG_CONFIG_HOME"
fi

cd site
wrangler deploy
