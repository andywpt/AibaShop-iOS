#!/bin/sh

[ -f "passphrase" ] || { echo "Error: File 'passphrase' not found" ; exit 1 ; } 

ENCRYPTED_DIR="Configurations/Encrypted"
DECRYPTED_DIR="Configurations/Decrypted"

[ -d "$DECRYPTED_DIR" ] && rm -r "$DECRYPTED_DIR"
mkdir -p "$DECRYPTED_DIR"

# Find all .gpg files in the Encrypted folder
find "$ENCRYPTED_DIR" -type f -name "*.gpg" | while read -r file; do
  # Extract the filename without the .gpg extension
  decrypted_file="$DECRYPTED_DIR/$(basename "${file%.gpg}")"
  # Decrypt the file using gpg
  if ! gpg --quiet --batch --yes --decrypt --passphrase="$(cat passphrase)" \
    --output "$decrypted_file" "$file"; then
      echo "Error: Failed to decrypt $file"
  fi
done