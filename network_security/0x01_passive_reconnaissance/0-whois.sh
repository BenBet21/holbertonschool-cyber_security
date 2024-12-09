#!/bin/bash
sudo whois $1 | awk -F ',' '/^Registrant|^Admin|^Tech/{gsub(":", ",");print $0}' > $1.csv