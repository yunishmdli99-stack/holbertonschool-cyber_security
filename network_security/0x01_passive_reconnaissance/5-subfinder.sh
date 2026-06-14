#!/bin/bash
subfinder -d $1 -silent -ip -csv -o $1.txt && cat $1.txt | awk -F',' '{print $1}'
