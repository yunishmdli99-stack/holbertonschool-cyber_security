#!/bin/bash
#
# 3-ips.sh
#
# Scans an authentication log (default: auth.log in the current directory,
# or pass a path as $1) and counts how many distinct source IP addresses
# achieved a *successful* login ("Accepted password" OR "Accepted
# publickey"). Each unique IP is treated as a separate attacker.
#
# The IP is extracted by locating the literal word "from" in the log line
# and taking the field right after it - this works for IPv4 and IPv6
# addresses alike, unlike a plain IPv4 regex which would silently drop
# any IPv6 sources.

LOGFILE="${1:-auth.log}"

if [ ! -f "$LOGFILE" ]; then
    echo "Log file not found: $LOGFILE" >&2
    exit 1
fi

grep -E "Accepted (password|publickey)" "$LOGFILE" \
    | awk '{for (i=1;i<=NF;i++) if ($i=="from") print $(i+1)}' \
    | sort -u \
    | wc -l
