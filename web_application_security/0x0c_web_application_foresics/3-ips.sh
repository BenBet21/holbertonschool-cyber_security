#!/bin/bash
# Extraire les adresses IP des connexions réussies
grep "Accepted password for root" auth.log | awk '{print $11}' | sort | uniq | wc -l
