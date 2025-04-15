#!/bin/bash

# Vérifie si un argument est fourni
if [ $# -ne 1 ]; then
    echo "Usage: $0 '<encoded_string>'"
    exit 1
fi

# Supprime le préfixe {xor} de l'argument
encoded_string="$1"
encoded_string="${encoded_string#'{xor}'}"

# Déchiffre la chaîne en utilisant Python
decoded_string=$(python3 -c "
import sys
from base64 import b64decode

try:
    encoded = sys.argv[1]
    decoded = b64decode(encoded)
    result = ''.join(chr(byte ^ 0x5f) for byte in decoded)
    print(result)
except Exception:
    print('Error: Invalid input')
    sys.exit(1)
" "$encoded_string")

# Affiche le résultat
echo "$decoded_string"
