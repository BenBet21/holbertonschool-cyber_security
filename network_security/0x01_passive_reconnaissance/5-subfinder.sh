#!/bin/bash
subfinder -d "$1" | while read sub; do ip=$(dig +short "$sub" | head -n 1); echo "$sub,$ip"; done | tee "$1.txt"