#!/bin/bash
# Count the number of distinct attackers who gained access to the
# system, treating each unique source IP address as a separate
# attacker.
#
# The attackers are the source IPs that successfully authenticated
# as the compromised account. Extracting the IP from each such
# "Accepted password" line for that account and counting the
# unique values gives the number of distinct attackers.

grep "Accepted password for root" auth.log | grep -oP "from \K\S+" | sort -u | wc -l
