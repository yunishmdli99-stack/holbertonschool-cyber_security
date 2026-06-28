#!/bin/bash
curl -si -H "Host: $1" -d "$3" "$2"
