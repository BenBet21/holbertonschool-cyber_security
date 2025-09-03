#!/bin/bash
grep -iE "iptables|ufw|firewalld" auth.log | wc -l
