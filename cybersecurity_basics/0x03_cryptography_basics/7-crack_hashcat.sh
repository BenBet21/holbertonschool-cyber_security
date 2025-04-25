#!/bin/bash
hashcat -m 0 -a 0 "$1" /usr/share/wordlists/rockyou.txt
hashcat -m 0 --show "$1" | cut -d ':' -f2 | head -n 1 > 7-password.txt