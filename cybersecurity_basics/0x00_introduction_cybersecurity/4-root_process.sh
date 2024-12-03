#!/bin/bash
ps -u "$1" -o pid,vsz,rss,cmd | grep -v " 0 0 "
