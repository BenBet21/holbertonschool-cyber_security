#!/bin/bash
grep -i "new user" auth.log | sed -n 's/.*name=\([^,]*\).*/\1/p' | sort -u | tr '\n' ',' | sed 's/,$/\n/'
