#!/bin/sh

SOURCE_PATH=${PROJECT_DIR}/Configurations/Decrypted
TARGET_PATH=${BUILT_PRODUCTS_DIR}/${PRODUCT_NAME}.app/GoogleService-Info.plist

file=""
if [[ "${CONFIGURATION}" == *"Production"* ]]; then
    file=${SOURCE_PATH}/Production-GoogleService-Info.plist
elif [[ "${CONFIGURATION}" == *"Staging"* ]]; then
    file=${SOURCE_PATH}/Staging-GoogleService-Info.plist
else
    echo "Unknown project configuration '${CONFIGURATION}'"
    exit 1
fi

if [ ! -f $file ] ; then
    echo "Missing plist file at ${file}"
    exit 1
fi

cp "${file}" "${TARGET_PATH}"
