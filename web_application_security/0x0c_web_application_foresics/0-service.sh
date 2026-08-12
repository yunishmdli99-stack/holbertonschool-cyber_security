#!/bin/bash
#
# 0-service.sh
#
# Scans an authentication log (default: auth.log in the current directory,
# or pass a path as $1) and identifies which service the attackers targeted.
#
# It works by:
#   1. Counting how many lines are tagged with pam_unix(sshd:auth) — the PAM
#      module sshd uses for authentication. A very high count here is the
#      signature of a service being hammered by login attempts.
#   2. Breaking down every sshd-related log line by its first message word
#      (Failed, Invalid, Accepted, error:, etc.) to show *what* happened
#      during those attempts.

LOGFILE="${1:-auth.log}"

if [ ! -f "$LOGFILE" ]; then
    echo "Log file not found: $LOGFILE" >&2
    exit 1
fi

TOTAL=$(grep -c "pam_unix(sshd:auth):" "$LOGFILE")

echo "$TOTAL pam_unix(sshd:auth):"

grep "sshd" "$LOGFILE" \
    | sed -E 's/.*sshd(\[[0-9]+\])?: //' \
    | awk '{print $1}' \
    | sort \
    | uniq -c \
    | sort -rn \
    | sed 's/^/  /'
