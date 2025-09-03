#!/bin/bash
tail -n 1000 auth.log | grep "Failed password" | awk '{print $9}' | sort | uniq -c | sort -nr > /tmp/failed_users

# Extraire les utilisateurs avec tentatives réussies
tail -n 1000 auth.log | grep "Accepted password" | awk '{print $9}' | sort | uniq -c | sort -nr > /tmp/success_users

# Identifier le compte compromis : présent dans les deux fichiers
awk 'NR==FNR{a[$2];next} $2 in a{print $2}' /tmp/failed_users /tmp/success_users | head -n 1
