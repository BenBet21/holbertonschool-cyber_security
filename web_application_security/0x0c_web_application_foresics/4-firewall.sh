#!/bin/bash
sudo grep -i 'iptables -A' auth.log | wc -l
