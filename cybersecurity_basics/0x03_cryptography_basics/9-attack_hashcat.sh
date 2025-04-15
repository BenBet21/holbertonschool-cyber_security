#!/bin/bash
hashcat -m 0 -a 1 "$1" wordlist1.txt wordlist2.txt
hashcat -m 0 --show "$1" | cut -d ':' -f2 | head -n 1 > 9-password.txt