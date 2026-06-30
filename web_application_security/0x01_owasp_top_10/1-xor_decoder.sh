#!/bin/bash
# 1-xor_decoder.sh
# Decodes IBM WebSphere {xor} obfuscated strings.
#
# WebSphere's {xor} obfuscation works as follows:
#   1. Strip the literal "{xor}" prefix.
#   2. Base64-decode the remaining string.
#   3. XOR every resulting byte with the fixed key 0x5F.
#
# Usage: ./1-xor_decoder.sh {xor}KzosKw==

HASH="$1"

if [ -z "$HASH" ]
then
	echo "Usage: $0 {xor}<base64-string>"
	exit 1
fi

STRIPPED="${HASH#\{xor\}}"

echo -n "$STRIPPED" | base64 -d 2>/dev/null | python3 -c "
import sys
data = sys.stdin.buffer.read()
result = bytes(b ^ 0x5F for b in data)
sys.stdout.write(result.decode('utf-8', errors='replace'))
"
echo
