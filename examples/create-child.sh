#!/bin/sh

# InstantDNS - create a child hostname
#
# Usage:
#   INSTANTDNS_TOKEN='your-token' ./create-child.sh camera1

set -eu

if [ -z "${INSTANTDNS_TOKEN:-}" ]; then
    echo "Error: INSTANTDNS_TOKEN is not set" >&2
    exit 1
fi

if [ "$#" -ne 1 ]; then
    echo "Usage: $0 CHILD_NAME" >&2
    exit 1
fi

NAME="$1"

curl -fsS \
    -H "Authorization: Bearer $INSTANTDNS_TOKEN" \
    "https://api.instantdns.io/record/new?name=$NAME"

echo
