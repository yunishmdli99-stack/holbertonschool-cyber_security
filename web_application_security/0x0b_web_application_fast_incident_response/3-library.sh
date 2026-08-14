#!/bin/bash
# Identify the tool/library the attacker used via User-Agent string

LOGFILE="${1:-logs.txt}"

# Find the attacker IP (most requests)
TOP_IP=$(awk '{print $1}' "$LOGFILE" | sort | uniq -c | sort -rn | head -n 1 | awk '{print $2}')

# Filter attacker's requests, extract User-Agent (last quoted field), count, print top
grep "^$TOP_IP " "$LOGFILE" | awk -F'"' '{print $(NF-1)}' | sort | uniq -c | sort -rn | head -n 1 | awk '{$1=""; print $0}' | sed 's/^ //'
