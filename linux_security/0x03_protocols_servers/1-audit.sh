#!/bin/bash
grep -vP "^\s*#|^\s*$" /etc/ssh/sshd_config /etc/ssh/sshd_config.d/*.conf 2>/dev/null
