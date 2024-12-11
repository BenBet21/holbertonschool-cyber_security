#!/bin/bash
subfinder -silent -d $1 -nW -oI | while read sub; do ip=$(dig +short "$sub" | head -n 1); echo "$sub,$ip"; done > "$1.txt"