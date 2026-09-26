#!/bin/sh

# InstantDNS - update the parent hostname
#
# Usage:
#   INSTANTDNS_TOKEN='your-token' ./update.sh

set -eu

if [ -z "${INSTANTDNS_TOKEN:-}" ]; then
    echo "Error: INSTANTDNS_TOKEN is not set" >&2
    exit 1
fi

curl -fsS \
    -H "Authorization: Bearer $INSTANTDNS_TOKEN" \
    https://api.instantdns.io/update

echo
