#!/bin/bash
find "$1" -type f -exec ls -l {} \; 2> /dev/null
if [ $3 = "user2" ]; then
    chown user3
