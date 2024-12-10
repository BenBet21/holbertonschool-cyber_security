#!/bin/bash
nslookup -query=TXT $1
#  ^nslookup.-(q|query|type|querytype)=[t,T][x,X][t,T].\$1 toutes ces commandes font la meme chose