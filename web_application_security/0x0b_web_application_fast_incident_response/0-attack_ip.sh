#!/bin/bash
# Identify the IP address responsible for the most requests in a log file
awk '{print $1}' logs.txt | sort | uniq -c | sort -rn | head -n 1 | awk '{print $2}'
