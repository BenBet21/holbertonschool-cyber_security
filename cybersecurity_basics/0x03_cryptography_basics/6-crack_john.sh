#!/bin/bash
john --format=Raw-SHA256 --wordlist=/usr/share/wordlists/rockyou.txt "$1" > /dev/null && john --show --format=Raw-SHA256 "$1" | cut -d: -f2 | head -n 1 > 6-password.txt