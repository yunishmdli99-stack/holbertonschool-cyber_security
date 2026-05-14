#!/bin/bash
grep -vP "^#|^$" /etc/ssh/sshd_config
