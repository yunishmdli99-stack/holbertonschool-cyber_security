#!/bin/bash
postconf -n | grep -i "tls" || echo "STARTTLS not configured"
