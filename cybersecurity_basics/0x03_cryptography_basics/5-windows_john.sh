#!/bin/bash
john --format=NT --wordlist=/usr/share/wordlists/rockyou.txt $1 | tee 5-password.txt
