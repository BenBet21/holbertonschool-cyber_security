#!/bin/bash
sudo nmap -sS -p "$2" --scanflags 0xFF -n -Pn "$1"
