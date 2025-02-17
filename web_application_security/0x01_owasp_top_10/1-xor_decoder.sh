#!/bin/bash

# argument prend la valeur de $1
argument="$1"

# Supprime {xor}de $1 
argument="${argument#'{xor}'}"

# Decode argument codée en Base64
arg_decode=$(echo -n "$argument" | base64 -d 2>/dev/null)

#Initialisation de la variable
sortie=""

# Boucle à travers chaque caractère de la phrase décodée
for ((i = 0; i < ${#arg_decode}; i++)); do
    # char prend la valeur de l'index i de arg_decode
    char="${arg_decode:$i:1}"
    # Convertit le caractère en son code ASCII et effectue l'opération XOR avec 95
    xor_converti=$(( $(printf "%d" "'$char") ^ 95 ))
    # Ajoute le résultat à la variable de sortie
    sortie+=$(printf "\\$(printf '%03o' $xor_converti)")
done

# Affiche le résultat
echo "$sortie"
