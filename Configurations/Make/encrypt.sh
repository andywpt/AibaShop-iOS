#!/bin/sh

DECRYPTED_DIR="Configurations/Decrypted"
ENCRYPTED_DIR="Configurations/Encrypted"

[ -d "$ENCRYPTED_DIR" ] && rm -rf "$ENCRYPTED_DIR"
mkdir -p "$ENCRYPTED_DIR"

# Find all files in the folder, excluding .DS_Store files
find "$DECRYPTED_DIR" -type f ! -name ".DS_Store" | while read -r file; do
  # Construct the output path with .gpg extension
  encrypted_file="${ENCRYPTED_DIR}/${file##*/}.gpg"
  mkdir -p "$(dirname "$encrypted_file")"
  
  # Run the gpg encryption command
  gpg --symmetric --cipher-algo AES256 --batch --yes --passphrase="$(cat passphrase)" \
    --output "$encrypted_file" "$file"
done
