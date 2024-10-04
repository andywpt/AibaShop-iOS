if [ ! -f "passphrase" ]; then
  echo "Error: File 'passphrase' not found"
  exit 1
fi

PASSPHRASE=$(cat passphrase)
ENCRYPTED_DIR="Configurations/Encrypted"
DECRYPTED_DIR="Configurations/Decrypted"

# Remove the Decrypted directory if it exists, then create it again
[ -d "$DECRYPTED_DIR" ] && rm -r "$DECRYPTED_DIR"
mkdir "$DECRYPTED_DIR"
# Find all .gpg files in the Encrypted folder
find $ENCRYPTED_DIR -type f -name "*.gpg" | while read file; do
  # Extract the filename without the .gpg extension
  decrypted_file="$DECRYPTED_DIR/$(basename "${file%.gpg}")"
  gpg --quiet --batch --yes --decrypt --passphrase="$PASSPHRASE" \
    --output "$decrypted_file" "$file"
done
