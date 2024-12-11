#!/bin/bash
subfinder -silent -d "$1" | while read sub; do ip=$(dig +short "$sub" | head -n 1); echo "$sub,$ip" >> "$1.txt"; echo "$sub"; done