#!/bin/bash
echo $1$(openssl rand -base64 16) | openssl dgst -sha512 | awk '{print $2}' > 3_hash.txt
