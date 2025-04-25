#!/bin/bash
find "$1" -type f -perm /2000 -exec basename {} \; 2> /dev/null