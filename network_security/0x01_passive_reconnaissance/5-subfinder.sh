#!/bin/bash
subfinder -d $1 -silent -ip -oI -o $1.txt && cat $1.txt | cut -d',' -f1
