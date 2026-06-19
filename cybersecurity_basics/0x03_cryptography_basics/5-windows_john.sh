#!/bin/bash
john --format=NT --show $(john --format=NT --wordlist=/usr/share/wordlists/rockyou.txt $1 > /dev/null 2>&1) $1 > 5-password.txt
