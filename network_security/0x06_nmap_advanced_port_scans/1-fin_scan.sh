#!/bin/bash
sudo nmap -sF -p 80-85 --mtu 24 -T2 "$1"