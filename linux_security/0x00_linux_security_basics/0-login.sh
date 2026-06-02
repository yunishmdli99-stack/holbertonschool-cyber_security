#!/bin/bash
[ "$EUID" -ne 0 ] && echo "Please run as root/sudo." && exit 1 || last -n 5 | grep -vE '(reboot|shutdown|^$)'
