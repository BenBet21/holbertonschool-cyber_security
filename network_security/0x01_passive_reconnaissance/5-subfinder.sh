#!/bin/bash
subfinder -silent -d "$1" -nW -o "$1.tmp" && awk -F ',' '!/,/{print $1","$2 > "'$1.txt'"} {print $1}' "$1.tmp"