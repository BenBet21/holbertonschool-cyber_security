#!/bin/bash
# subfinder -silent -d "$1" | while read sub; do ip=$(dig +short "$sub" | grep -E '^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$' | head -n 1); if [[ -n $ip ]]; then echo "$sub,$ip" | tee -a "$1.txt"; echo "$sub"; fi; done

subfinder -silent -d "$1" | while read sub; do ip=$(dig +short "$sub" | grep -E '^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$' | head -n 1); if [[ -n $ip ]]; then echo "$sub,$ip" >> "$1.txt"; echo "$sub"; fi; done
