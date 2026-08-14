#!/bin/bash
# Identify the IP address responsible for the most requests in a log file
# Usage: ./dos_finder.sh logs.txt

LOGFILE="$1"

if [ -z "$LOGFILE" ] || [ ! -f "$LOGFILE" ]; then
    echo "Usage: $0 <logfile>"
    exit 1
fi

awk '{print $1}' "$LOGFILE" | sort | uniq -c | sort -rn | head -n 1 | \
awk '{print "Most requests from IP: " $2 " (" $1 " requests)"}'
