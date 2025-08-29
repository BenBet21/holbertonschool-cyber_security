#!/bin/bash
# Extract the requested URLs from the log file and Count the occurrences of each endpoint and identify the most frequently requested one
awk -F\" '{print $2}' "logs.txt" \
  | awk '{print $2}' \
  | sort | uniq -c | sort -nr | head -n 1 | awk '{print $2}'
