#!/bin/bash
# Identify the tool/library the attacker used via User-Agent string

LOGFILE="${1:-logs.txt}"

# Find the attacker IP (most requests)
TOP_IP=$(awk '{print $1}' "$LOGFILE" | sort | uniq -c | sort -rn | head -n 1 | awk '{print $2}')

# Filter attacker's requests, grab the last quoted field on each line (the User-Agent),
# count occurrences, and print the most common one
grep "^$TOP_IP " "$LOGFILE" | grep -oE '"[^"]*"$' | tr -d '"' | sort | uniq -c | sort -rn | head -n 1 | sed -E 's/^ *[0-9]+ //'
