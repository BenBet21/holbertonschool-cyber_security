#!/bin/bash
whois $1 | awk '/^(Registrant|Admin|Tech)/ {print $0}'