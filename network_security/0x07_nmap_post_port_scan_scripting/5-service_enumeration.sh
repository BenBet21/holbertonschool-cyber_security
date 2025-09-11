#!/bin/bash
nmap -A -p- --script banner http vuln* ssl-enum-ciphers default smb-enum-domains $1 -oN service_enumeration_results.txt
