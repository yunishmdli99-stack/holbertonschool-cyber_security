#!/bin/bash
john --format=NT --wordlist=/usr/share/wordlists/rockyou.txt $1 > 5-password.txt 2>&1
