#!/bin/sh

PLIST_DIR="$PROJECT_DIR/Configurations/Decrypted"
plist_file=""
case "$CONFIGURATION" in
    *Production*) plist_file="$PLIST_DIR/Production-GoogleService-Info.plist" ;;
    *Staging*) plist_file="$PLIST_DIR/Staging-GoogleService-Info.plist" ;;
    *) echo "Unknown project configuration: $CONFIGURATION"; exit 1 ;;
esac
[ -f $plist_file ] || { echo "😳 Missing plist file at $plist_file" ; exit 1 ; }
cp "${plist_file}" "${BUILT_PRODUCTS_DIR}/${PRODUCT_NAME}.app/GoogleService-Info.plist"