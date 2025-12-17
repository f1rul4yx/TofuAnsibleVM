#!/bin/bash

RESET="\e[0m"
ROJO="\e[31m"
VERDE="\e[32m"

read -rp "Introduce la ruta completa de tu clave pública (.pub): " PUB_KEY_FILE

if [[ ! -f "$PUB_KEY_FILE" ]]; then
  echo -e "${ROJO}[-] El fichero no existe.${RESET}"
  exit 1
fi

if [[ "$PUB_KEY_FILE" != *.pub ]]; then
  echo -e "${ROJO}[-] El fichero no es una clave pública (.pub).${RESET}"
  exit 1
fi

PUBLIC_KEY_CONTENT=$(cat "$PUB_KEY_FILE")

BASE_DIR="OpenTofu/cloud-init"

for FILE in "$BASE_DIR"/server*/user-data.yaml; do
  if [[ -f "$FILE" ]]; then
    echo -e "${VERDE}[+] Actualizando $FILE ...${RESET}"
    sed -i -E "s|^\s*-\s*public_key$|      - \"$PUBLIC_KEY_CONTENT\"|g" "$FILE"
  fi
done
