#!/bin/sh

# InstantDNS - update parent and all active child records
#
# Usage:
#   INSTANTDNS_TOKEN='your-token' ./update-all.sh

set -eu

if [ -z "${INSTANTDNS_TOKEN:-}" ]; then
    echo "Error: INSTANTDNS_TOKEN is not set" >&2
    exit 1
fi

curl -fsS \
    -H "Authorization: Bearer $INSTANTDNS_TOKEN" \
    "https://api.instantdns.io/update?scope=all"

echo
