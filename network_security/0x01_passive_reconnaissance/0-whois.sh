#!/bin/bash
whois "$1" | awk 'BEGIN { FS=": "; OFS="," } /^(Registrant|Admin|Tech)/ { if ($1 ~ /Street$/) { $2 = $2 " " } gsub(/^[ \t]+|[ \t]+$/, "", $2); print $1, $2 }' > "$1.csv"