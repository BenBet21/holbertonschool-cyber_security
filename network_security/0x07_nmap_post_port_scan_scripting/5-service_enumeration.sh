#!/bin/bash
nmap -sS -sV -O --traceroute --script="banner,ssl-enum-ciphers,default,smb-enum-domains" -oN service_enumeration_results.txt
