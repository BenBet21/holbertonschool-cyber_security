#!/bin/bash
# Extract the most frequent attacking IP address from a log file
awk '{print $1}' "logs.txt" \
  | grep -Eo '([0-9]{1,3}\.){3}[0-9]{1,3}' \
  | sort | uniq -c | sort -nr | head -n 1 | awk '{print $2}'