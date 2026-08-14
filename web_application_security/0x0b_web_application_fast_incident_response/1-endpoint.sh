#!/bin/bash
# Find the endpoint (URL) that received the most requests
awk -F'"' '{print $2}' logs.txt | awk '{print $2}' | sort | uniq -c | sort -rn | head -n 1 | awk '{print $2}'
