#!/bin/bash
sudo cut -d' ' -f5 auth.log | cut -d'[' -f1 | cut -d':' -f1 | sort | uniq -c | sort -nr
