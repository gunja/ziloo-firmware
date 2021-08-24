#!/bin/bash
set -ex
# this script should be run only inside of a Docker container
if [ ! -f /.dockerenv ]; then
  echo "ERROR: script works only in a Docker container!"
  exit 1
fi

parted $MAIXPY_IMG UNIT b print
fdisk -lu $MAIXPY_IMG
lsblk

# Extract parts spotted (SPL)
dd bs=512 count=96 skip=16 of=/workspace/images/spl-extract.img if=$MAIXPY_IMG

# Set up /dev/loop0
# https://askubuntu.com/questions/69363/mount-single-partition-from-image-of-entire-disk-device
# kpartx -av $MAIXPY_IMG
DEVICE=$(kpartx -va ${MAIXPY_IMG} | sed -E 's/.*(loop[0-9])p.*/\1/g' | head -1)
# DEVICE=$(losetup -f --show ${MAIXPY_IMG})

echo "Image ${MAIXPY_IMG} created and mounted as ${DEVICE}."

# give some time to system to refresh
sleep 3

# Extract boot & rootfs
dd bs=1k conv=noerror if="/dev/mapper/${DEVICE}p2" of=/workspace/images/boot-extract.img
gzip /workspace/images/boot-extract.img
dd bs=1k conv=noerror if="/dev/mapper/${DEVICE}p3" of=/workspace/images/rootfs-extract.img
gzip /workspace/images/rootfs-extract.img

# mount /dev/mapper/loop0p2 /mnt
mkdir -p /mnt/img-rootfs
mount -t ext4 -o "/dev/mapper/${DEVICE}p3" /mnt/img-rootfs
# mount -t fat32 -o "/dev/mapper/$(DEVICE)p5" /mnt/img-UDISK

# Unmount the loopYpX disks
# umount /mnt/img-env
umount /mnt/img-rootfs
# umount /mnt/img-UDISK

echo "### remove dev mapper devices for image partitions"
kpartx -vds ${MAIXPY_IMG} || true
dmsetup remove_all
