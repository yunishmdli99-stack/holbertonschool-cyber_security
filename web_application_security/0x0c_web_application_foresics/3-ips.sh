#!/bin/bash
#
# 3-ips.sh - Count distinct attacker IP addresses that gained access.
#
# Each unique source IP behind a successful login (Accepted password or
# Accepted publickey) is treated as a separate attacker. The IP is pulled
# out with a lookbehind for the literal word "from", so both IPv4 and
# IPv6 sources are counted.
#
# Usage: ./3-ips.sh [logfile]   (defaults to auth.log)

LOGFILE=auth.log
if [ $# -ge 1 ]
then
    LOGFILE=$1
fi

if [ ! -f "$LOGFILE" ]
then
    echo "Log file not found: $LOGFILE" >&2
    exit 1
fi

grep -E "Accepted (password|publickey)" "$LOGFILE" |
    grep -oP '(?<=from )\S+' |
    sort -u |
    wc -l
