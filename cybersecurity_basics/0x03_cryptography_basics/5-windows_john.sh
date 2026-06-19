#!/bin/bash
john --format=NT --wordlist=/usr/share/wordlists/rockyou.txt $1 2>&1 | grep -oP '^.*(?=\s+\(\?\))' > 5-password.txt
