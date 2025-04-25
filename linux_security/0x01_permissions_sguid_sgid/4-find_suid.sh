#!/bin/bash
find "$1" -type f -perm /4000 -exec basename {} \; 2> /dev/null