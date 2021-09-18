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

truncate -s 25M /core-files.img
mkfs.ext4 /core-files.img
mount -oloop /core-files.img /mnt
mkdir -p /mnt/data /mnt/dev /mnt/mnt /mnt/overlay /mnt/proc /mnt/rom /mnt/root /mnt/sys /mnt/tmp
mkdir -p /mnt/usr/bin /mnt/usr/lib /mnt/usr/include  /mnt/usr/sbin /mnt/usr/share
cp -a /workspace/device/maix/core-files/. /mnt/.
cp -a /workspace/device/maix/etc-files/. /mnt/.
# resize2fs -M /workspace/core-files.img
umount /core-files.img


# echo "The following should be put in alpine.vfat"
cd /workspace/device/maix
echo > files.cfg
find /workspace/dist/for-rpi -maxdepth 1 -type f -printf "%f\n" | awk -F: '{print "\t\tfile " $1 " {\n\t\t\timage = /workspace/dist/for-rpi/" $1 "\n\t\t}" }' >> files.cfg
find /workspace/dist/for-rpi/boot -maxdepth 1 -type f -printf "%f\n" | awk -F: '{print "\t\tfile boot/" $1 " {\n\t\t\timage = /workspace/dist/for-rpi/boot/" $1 "\n\t\t}" }' >> files.cfg
find /workspace/dist/for-rpi/overlays -maxdepth 1 -type f -printf "%f\n" | awk -F: '{print "\t\tfile overlays/" $1 " {\n\t\t\timage = /workspace/dist/for-rpi/overlays/" $1 "\n\t\t}" }' >> files.cfg
find /workspace/dist/for-rpi/apks/aarch64 -maxdepth 1 -type f -printf "%f\n" | awk -F: '{print "\t\tfile apks/aarch64/" $1 " {\n\t\t\timage = /workspace/dist/for-rpi/apks/aarch64/" $1 "\n\t\t}" }' >> files.cfg

awk 'NR==FNR { a[n++]=$0; next } /# SDK Dist files/ { for (i=0;i<n;++i) print a[i]; next } 1' files.cfg genimage.tpl.cfg > genimage.cfg
cd /

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