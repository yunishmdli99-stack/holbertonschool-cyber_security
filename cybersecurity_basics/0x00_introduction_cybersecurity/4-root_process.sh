#!/bin/bash
ps -u $1 | grep -v "VSZ\|RSS\| 0 "
