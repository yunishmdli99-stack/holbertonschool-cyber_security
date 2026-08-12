#!/bin/bash
#
# 1-operating.sh
#
# Scans a dmesg log (default: dmesg in the current directory, or pass a
# path as $1) and extracts the line reporting the Linux kernel/OS version
# of the targeted system. The kernel boot banner always starts with
# "Linux version", so grepping for that line is enough to identify the
# exact kernel build, compiler, and distro tag.

LOGFILE="${1:-dmesg}"

if [ ! -f "$LOGFILE" ]; then
    echo "Log file not found: $LOGFILE" >&2
    exit 1
fi

grep "Linux version" "$LOGFILE"
