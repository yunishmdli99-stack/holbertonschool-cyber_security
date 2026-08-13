#!/bin/bash
grep -c "add.*rule\|rule.*add" /var/log/auth.log
