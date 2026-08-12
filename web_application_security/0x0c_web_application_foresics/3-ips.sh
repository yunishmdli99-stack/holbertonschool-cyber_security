#!/bin/bash
#
# 3-ips.sh
#
# Scans an authentication log (default: auth.log in the current directory,
# or pass a path as $1) and counts how many distinct source IP addresses
# achieved a *successful* login ("Accepted password"). Each unique IP is
# treated as a separate attacker.

LOGFILE="${1:-auth.log}"

if [ ! -f "$LOGFILE" ]; then
    echo "Log file not found: $LOGFILE" >&2
    exit 1
fi

grep "Accepted password" "$LOGFILE" \
    | grep -oE '([0-9]{1,3}\.){3}[0-9]{1,3}' \
    | sort -u \
    | wc -l
