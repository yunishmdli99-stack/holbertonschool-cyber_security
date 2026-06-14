#!/bin/bash
subfinder -d $1 -silent -o $1.txt -oJ=false -csv -ip && cat $1.txt | cut -d',' -f1
