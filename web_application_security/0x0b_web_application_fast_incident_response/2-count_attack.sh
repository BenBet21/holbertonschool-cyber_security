#!/bin/bash
# Compter combien de requêtes a envoyées l'IP la plus active (attaquant)
grep -Eo '([0-9]{1,3}\.){3}[0-9]{1,3}' logs.txt \
  | sort | uniq -c | sort -nr | head -n 1 | awk '{print $1}'
