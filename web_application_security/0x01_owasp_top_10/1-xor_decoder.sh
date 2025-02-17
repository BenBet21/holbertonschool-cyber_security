#!/bin/bash

# Supprime le préfixe '{xor}' de la phrase codée
encoded_phrase="$1"
encoded_phrase="${encoded_phrase#'{xor}'}"

# Décode la phrase en base64
decoded_phrase=$(echo -n "$encoded_phrase" | base64 -d)
output=""

# Boucle à travers chaque caractère de la phrase décodée
for ((i = 0; i < ${#decoded_phrase}; i++)); do
  char="${decoded_phrase:$i:1}"
  # Effectue l'opération XOR avec 95 et convertit en caractère
  xor_char=$(printf "\\x$(printf '%x' "$(( $(printf '%d' "'$char") ^ 95 ))")")
  output+="$xor_char"
done

# Affiche la phrase décodée
echo -n "$output"