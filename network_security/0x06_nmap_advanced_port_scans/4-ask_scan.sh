#!/bin/bash
sudo nmap -sA -p"$2" --open --host-timeout 1000ms --reason "$1"
