#!/bin/bash

# Script de décodage XOR en respectant le style Betty

# Vérifie si un argument est fourni
if [ -z "$1" ]; then
  echo "Usage: $0 <phrase_encodée>"
  exit 1
fi

# Supprime le préfixe '{xor}' de la phrase codée
encoded_phrase="$1"
encoded_phrase="${encoded_phrase#'{xor}'}"

# Décode la phrase en base64
decoded_phrase=$(echo -n "$encoded_phrase" | base64 -d 2>/dev/null)

# Vérifie si la conversion base64 a réussi
if [ $? -ne 0 ]; then
  echo "Erreur : La chaîne encodée n'est pas valide."
  exit 1
fi

output=""

# Boucle à travers chaque caractère de la phrase décodée
i=0
while [ "$i" -lt "${#decoded_phrase}" ]; do
  char="${decoded_phrase:$i:1}"
  xor_char=$(( $(printf "%d" "'$char") ^ 95 ))

  # Ajoute le caractère décodé à la variable output
  output="${output}$(printf "\\$(printf '%03o' "$xor_char")")"

  i=$((i + 1))
done

# Affiche la phrase décodée
echo "$output"
