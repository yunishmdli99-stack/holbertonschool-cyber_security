#!/bin/bash
whois $1 | grep -E "^(Registrant|Admin|Tech)" | awk '{print $1","$2}' | tr -d ':'
