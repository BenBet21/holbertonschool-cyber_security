#!/bin/bash
sudo nmap -sW -p "$2" --exclude-ports "$3" --reason "$1"
