#!/bin/bash
if [ "$EUID" -eq 0 ]; then last -n 5 | grep "$1"; else echo "Run as root"; fi
