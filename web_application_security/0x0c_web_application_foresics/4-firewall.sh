#!/bin/bash
sudo grep "root" auth.log | grep "iptables -A" | wc -l
