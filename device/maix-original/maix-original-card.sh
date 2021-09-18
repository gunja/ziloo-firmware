#!/bin/bash
set -ex
# this script should be run only inside of a Docker container
if [ ! -f /.dockerenv ]; then
  echo "ERROR: script works only in a Docker container!"
  exit 1
fi
BOARD_DIR="$(dirname $0)"
BINARIES_DIR="/workspace/dist"
TARGET="/workspace"
GENIMAGE_CFG="${BOARD_DIR}/genimage.cfg"
GENIMAGE_TMP="/tmp/genimage.tmp"

rm -rf ${GENIMAGE_TMP}
mkdir -p ${GENIMAGE_TMP}

genimage --loglevel 5 \
  --inputpath "${BOARD_DIR}" \
  --outputpath "${BINARIES_DIR}" \
  --rootpath "${TARGET}" \
  --tmppath "${GENIMAGE_TMP}" \
  --config "${GENIMAGE_CFG}"

rm -rf ${GENIMAGE_TMP}




# ensure that the travis-ci user can access the sd-card image file
# umask 0000

# # compress image
# rm "${BUILD_RESULT_PATH}/${IMAGE_PATH}.zip"
# zip "${BUILD_RESULT_PATH}/${IMAGE_PATH}.zip" "${IMAGE_PATH}"
# sleep 2
# cd ${BUILD_RESULT_PATH} && sha256sum "${IMAGE_PATH}.zip" > "${IMAGE_PATH}.zip.sha256" && cd -

# fdisk -l /${IMAGE_PATH}
# # test raw image that we have built
# # rspec --format documentation --color /device/raw