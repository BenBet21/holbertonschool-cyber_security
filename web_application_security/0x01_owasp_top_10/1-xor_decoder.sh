#!/bin/bash
phrase_codee="$1"
phrase_codee="${phrase_codee#'{xor}'}"
phrase_decodee=$(echo -n "$phrase_codee" | base64 -d)
sortie=""

for ((n=0;n<${#phrase_decodee};n++)); do
  char="${phrase_decodee:$n:1}"
  printf -v xor_char "\\x$(printf '%x' "$(( $(printf '%d' "'$char") ^ 95))")"
  sortie+="$xor_char"
done

echo "$sortie"
