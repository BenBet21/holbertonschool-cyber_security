#!/bin/bash
sudo nmap -sX -p440-450 --open --reason -vv "$1"
