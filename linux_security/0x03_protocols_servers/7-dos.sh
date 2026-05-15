#!/bin/bash
echo "Simulating traffic to $1"
hping3 --flood -S "$1" >/dev/null 2>&1
