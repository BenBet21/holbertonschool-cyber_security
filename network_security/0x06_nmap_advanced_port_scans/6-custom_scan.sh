#!/bin/bash
sudo nmap -sS -p "$2" --scanflags 0xFF -n -Pn -oN custom_scan.txt "$1" > /dev/null 2>&1
