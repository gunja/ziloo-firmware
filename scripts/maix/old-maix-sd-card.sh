#!/bin/bash
set -ex
# this script should be run only inside of a Docker container
if [ ! -f /.dockerenv ]; then
  echo "ERROR: script works only in a Docker container!"
  exit 1
fi

### setting up some important variables to control the build process
BUILD_RESULT_PATH="/workspace"
IMAGE_PATH="/ziloo-maix-card.img"
SD_CARD_SIZE=1400
BOOT_PARTITION_SIZE=6
ROOT_PARTITION_SIZE=320
SWAP_PARTITION_SIZE=80

# create empty BOOT/ROOTFS image file
# - SD_CARD_SIZE in MByte
# - DD uses 256 Bytes
# - sector block size is 512Bytes
# - Plenty of space for partition and EFI secorts, we start at sector 49152 (24MByte reserved space)

# name=env flags=msftdata 25165824 262144
ENVFS_START=49152
ENVFS_SIZE=512   # 262144 B  512 sectors

# 49664 12288
BOOTFS_START=$((ENVFS_START + ENVFS_SIZE))
BOOTFS_SIZE=$((BOOT_PARTITION_SIZE * 2048))

# 61952 655360
ROOTFS_START=$((BOOTFS_SIZE + BOOTFS_START))
ROOTFS_SIZE=$((ROOT_PARTITION_SIZE * 2048))

# swap msftdata 717312 163840
SWAPFS_START=$((ROOTFS_SIZE + ROOTFS_START))
SWAPFS_SIZE=$((SWAP_PARTITION_SIZE * 2048))

# UDISK fat32 881152 101855
UDISKFS_START=$((SWAPFS_SIZE + SWAPFS_START))
SD_MINUS_DD=$((SD_CARD_SIZE * 1024 * 1024 - 256))
UDISKFS_SIZE=$((SD_MINUS_DD / 512 - UDISKFS_START))

# total 983007 sectors

dd if=/dev/zero of=${IMAGE_PATH} bs=1MiB count=${SD_CARD_SIZE}

DEVICE=$(losetup -f --show ${IMAGE_PATH})

echo "Image ${IMAGE_PATH} created and mounted as ${DEVICE}."

# create partions (sgdisk for gpt, sfdisk for mbr)
sfdisk --force "${DEVICE}" <<PARTITION
unit: sectors

/dev/loop0p1 : start= ${ENVFS_START}, size= ${ENVFS_SIZE}, Id= c
/dev/loop0p2 : start= ${BOOTFS_START}, size= ${BOOTFS_SIZE}, Id= c, bootable
/dev/loop0p3 : start= ${ROOTFS_START}, size= ${ROOTFS_SIZE}, Id=83
/dev/loop0p4 : start= ${SWAPFS_START}, size= ${SWAPFS_SIZE}, Id=82
PARTITION
# /dev/loop0p5 : start= ${UDISKFS_START}, size= ${UDISKFS_SIZE}, Id=07

# Forget disk mapping, done partitioning.
losetup -d "${DEVICE}"


# Working with partitions
DEVICE=$(kpartx -va ${IMAGE_PATH} | sed -E 's/.*(loop[0-9])p.*/\1/g' | head -1)
dmsetup --noudevsync mknodes
BOOTP="/dev/mapper/${DEVICE}p2"
ROOTP="/dev/mapper/${DEVICE}p3"
UDISKP="/dev/mapper/${DEVICE}p4"
DEVICE="/dev/${DEVICE}"

BOOT_IMG="/boot-extract.img"
ROOT_IMG="/rootfs-extract.img"
gunzip -c /workspace/images/boot-extract.img.gz >/boot-extract.img
gunzip -c /workspace/images/rootfs-extract.img.gz >/rootfs-extract.img

# give some time to system to refresh
sleep 3

# create file systems
# mkfs.vfat "${BOOTP}" -n boot
mkfs.ext4 "${ROOTP}" -L root -i 4096 # create 1 inode per 4kByte block (maximum ratio is 1 per 1kByte)
# mkfs.vfat "${UDISKP}" -n UDISK

dd of=${BOOTP} if=${BOOT_IMG} bs=1k conv=noerror
dd of=${ROOTP} if=${ROOT_IMG} bs=1k conv=noerror

echo "### remove dev mapper devices for image partitions"
kpartx -vds ${IMAGE_PATH} || true

dd bs=512 count=96 skip=16 if=/spl-extract.img of=${IMAGE_PATH}

# ensure that the travis-ci user can access the sd-card image file
umask 0000

# compress image
zip "${BUILD_RESULT_PATH}/${IMAGE_PATH}.zip" "${IMAGE_PATH}"
sleep 2
cd ${BUILD_RESULT_PATH} && sha256sum "${IMAGE_PATH}.zip" > "${IMAGE_PATH}.zip.sha256" && cd -

fdisk -l /${IMAGE_PATH}
# test raw image that we have built
# rspec --format documentation --color /scripts/raw


