#!/bin/bash
sshd -T 2>/dev/null | grep -v "^#" | grep -v "^$"
