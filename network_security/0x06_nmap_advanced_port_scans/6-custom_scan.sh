#!/bin/bash
sudo nmap -p "$2" --scanflags 0xFF  $1 -oN custom_scan.txt >/dev/null 2>&1
