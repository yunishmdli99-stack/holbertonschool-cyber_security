#!/bin/bash
find "$1" -perm -2000 -type f -exec ls -la {} \; 2>/dev/null
