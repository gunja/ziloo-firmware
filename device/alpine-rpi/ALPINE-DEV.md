# Outstanding Alpine Development

## Setup network

> udhcpc -i wlan0


## Rpi 4 support

First for Rpi3: https://wiki.alpinelinux.org/wiki/Create_a_bootable_SDHC_from_a_Mac

Then: https://raspberrypi.stackexchange.com/questions/119503/rpi-4b-alpine-linux-3-12-3-headless

https://wiki.alpinelinux.org/wiki/Raspberry_Pi

The partition type should be W95 FAT32 (LBA).

## Log

1. Booting from USB stick created from Format+tar
2. setup-alpine
3. Insert SD Card
4. apk add lsblk & lsblk
5. setup-bootable /media/usb /dev/mmcblk0p1


## Allwinner

DIY Fully working Alpine Linux for Allwinner and Other ARM SOCs
https://wiki.alpinelinux.org/wiki/DIY_Fully_working_Alpine_Linux_for_Allwinner_and_Other_ARM_SOCs



## Setup

The first partition must be FAT, and will be erased and replaced as part of the setup process.
The second partition can be used for `/cache` and `/apks`. Make sure those directories are present.


> diskutil resizeVolume disk2s1 1G
> diskutil eraseDisk exFAT ALPINE MBRFormat disk3

SD Card partition = 0x0c W95 FAT32 (LBA)

```
diskutil list
diskutil partitionDisk /dev/disk2 MBR "FAT32" ALP 256MB "Free Space" SYS R
sudo fdisk -e /dev/disk2
> f 1
> w
> exit
```

> tar xvf ./alpine-rpi-3.14.0-aarch64.tar -C /Volumes/"ALPINE 1"

>> tar to the disk

OFTC chat #alpine-linux
https://webchat.oftc.net


run setup-alpine
Setup 
- us us
- ziloo 
- eth0 
- dhcp
- wlan0
- Experiential/...
- dhcp
- pass: ziloo no zee
- UTC
- NTP client: chrony (alt is busybox)
- mirror.ungleich.ch or dl-cdn.alpinelinux.org
- dropbear
- main storage mmcblk0p1 (usb) y
- mmcblk0
- data


Boot USB write to SD Card


## Multiboot

- [Sunxi Berryboot](https://sunxi.org/Berryboot)
