#!/bin/bash
sudo grep -iE "iptables|ufw|firewalld" auth.log | grep "A INPUT" | sort -u | wc -l
