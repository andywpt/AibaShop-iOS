#!/bin/bash

# Check if the passphrase file exists
if [ ! -f "passphrase" ]; then
    echo "Error: File 'passphrase' not found"
    exit 1
fi

# Read the passphrase from the file
PASSPHRASE=$(cat passphrase)

# Define directory paths
ENCRYPTED_DIR="Configurations/Encrypted"
DECRYPTED_DIR="Configurations/Decrypted"

# Remove the Decrypted directory if it exists, then create it again
[ -d "$DECRYPTED_DIR" ] && rm -r "$DECRYPTED_DIR"
mkdir -p "$DECRYPTED_DIR"

# Find all .gpg files in the Encrypted folder
find "$ENCRYPTED_DIR" -type f -name "*.gpg" | while read -r file; do
  # Extract the filename without the .gpg extension
  decrypted_file="$DECRYPTED_DIR/$(basename "${file%.gpg}")"
  
  # Decrypt the file using gpg
  if ! gpg --quiet --batch --yes --decrypt --passphrase="$PASSPHRASE" \
    --output "$decrypted_file" "$file"; then
      echo "Error: Failed to decrypt $file"
  fi
done
