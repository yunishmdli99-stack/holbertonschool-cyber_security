#!/bin/bash
# Count the number of requests made by the attacking IP (the IP with most requests)

LOGFILE="${1:-logs.txt}"

TOP_IP=$(awk '{print $1}' "$LOGFILE" | sort | uniq -c | sort -rn | head -n 1 | awk '{print $2}')

grep -c "^$TOP_IP " "$LOGFILE"
