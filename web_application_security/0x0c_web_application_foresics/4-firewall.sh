#!/bin/bash
sudo grep -iE "iptables|ufw|firewalld" auth.log | wc -l
