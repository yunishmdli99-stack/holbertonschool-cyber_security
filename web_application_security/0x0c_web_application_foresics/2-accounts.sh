#!/bin/bash
#
# 2-accounts.sh
#
# Scans the last 1000 lines of an authentication log (default: auth.log
# in the current directory, or pass a path as $1) and identifies the
# compromised account: the username that was hit with repeated failed
# login attempts (Failed password / Invalid user) AND later had at least
# one successful login (Accepted password). That pattern — many failures
# followed by a success — is the classic signature of a brute-forced
# account that eventually got cracked.

LOGFILE="${1:-auth.log}"

if [ ! -f "$LOGFILE" ]; then
    echo "Log file not found: $LOGFILE" >&2
    exit 1
fi

RECENT=$(tail -n 1000 "$LOGFILE")

# Usernames that had at least one successful login
ACCEPTED_USERS=$(echo "$RECENT" | grep "Accepted password" | awk '{print $9}' | sort -u)

# For each accepted user, count how many failed/invalid attempts they had
# before/around the success. The one with the most failed attempts is our
# compromised account.
BEST_USER=""
BEST_COUNT=-1

for user in $ACCEPTED_USERS; do
    FAIL_COUNT=$(echo "$RECENT" | grep -E "Failed password for( invalid user)? $user |Invalid user $user " | wc -l)
    if [ "$FAIL_COUNT" -gt "$BEST_COUNT" ]; then
        BEST_COUNT="$FAIL_COUNT"
        BEST_USER="$user"
    fi
done

echo "$BEST_USER"
