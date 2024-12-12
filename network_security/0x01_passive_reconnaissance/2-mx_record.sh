#!/bin/bash
nslookup -type=MX "$1"
# (q|query|type|querytype)=[m,M][x,X] toutes ces commandes font la meme chose