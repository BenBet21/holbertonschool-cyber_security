#!/bin/bash
john --format=nt --wordlist=/usr/share/wordlists/rockyou.txt "$1" > /dev/null && john --show --format=nt "$1" | cut -d: -f2 | head -n 1 > 5-password.txt