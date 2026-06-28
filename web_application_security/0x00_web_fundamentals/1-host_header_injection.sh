#!/bin/bash
curl -si -X POST -H "Host: $1" -d "$3" "$2"
