#!/bin/bash
sudo nmap -sX -p440-450 --reason -vv "$1"
