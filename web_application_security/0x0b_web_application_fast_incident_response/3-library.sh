#!/bin/bash

# Trouver l'IP la plus active (attaquant)
attacker_ip=$(grep -Eo '([0-9]{1,3}\.){3}[0-9]{1,3}' logs.txt \
  | sort | uniq -c | sort -nr | head -n 1 | awk '{print $2}')

# Filtrer uniquement ses requêtes et extraire les User-Agent
grep "$attacker_ip" logs.txt \
  | awk -F\" '{print $6}' \
  | sort | uniq -c | sort -nr | head -n 1 | awk '{print $2}'
  