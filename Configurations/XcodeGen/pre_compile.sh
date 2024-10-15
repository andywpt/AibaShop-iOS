#!/bin/sh

DIR="${PROJECT_DIR}/Configurations"
chmod +x ${DIR}/Firebase/firebase.sh
chmod +x ${DIR}/SwiftGen/swiftgen.sh
chmod +x ${DIR}/Sourcery/sourcery.sh
${DIR}/Firebase/firebase.sh
${DIR}/SwiftGen/swiftgen.sh
${DIR}/Sourcery/sourcery.sh
