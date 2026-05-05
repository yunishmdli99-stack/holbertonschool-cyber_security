#!/bin/bash
ps -u $1 -o user,pid,%cpu,%mem,vsz,rss,tt,stat,start,time,command |grep -v " 0 "
