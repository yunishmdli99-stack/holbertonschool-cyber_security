#!/bin/bash
john --format=Raw-SHA256 --wordlist=/usr/share/wordlists/rockyou.txt $1 2>&1 | grep -oP '^.*(?=\s+\(\?\))' > 6-password.txt
