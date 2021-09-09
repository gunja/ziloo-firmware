`/data` is 6GB for saving event streams.
`/oem` is 128MB for the App
`/` is 1GB rootfs
`/udisk` is disk via USB

usb-ffs enables debug bridge (adb)

Use PhotoBoot on Mac
Use VLC on Ubuntu (vlc v4l2:///dev/video0)

sudo apt install vlc
sudo snap install flutter --classic


```bash
[root@RV1126_RV1109:/]# mount
sysfs on /sys type sysfs (rw,nosuid,nodev,noexec,relatime)
proc on /proc type proc (rw,nosuid,nodev,noexec,relatime)
udev on /dev type devtmpfs (rw,nosuid,relatime,size=454100k,nr_inodes=113525,mode=755)
devpts on /dev/pts type devpts (rw,nosuid,noexec,relatime,gid=5,mode=620,ptmxmode=000)
tmpfs on /run type tmpfs (rw,nosuid,noexec,relatime,size=91820k,mode=755)
/dev/mmcblk0p6 on / type ext4 (rw,relatime)
tmpfs on /dev/shm type tmpfs (rw,relatime,mode=777)
tmpfs on /tmp type tmpfs (rw,relatime)
debug on /sys/kernel/debug type debugfs (rw,relatime)
pstore on /sys/fs/pstore type pstore (rw,relatime)
/dev/mmcblk0p7 on /oem type ext4 (rw,relatime)
/dev/mmcblk0p8 on /userdata type ext2 (rw,relatime)
none on /sys/kernel/config type configfs (rw,relatime)
adb on /dev/usb-ffs/adb type functionfs (rw,relatime)
```

```bash
[root@RV1126_RV1109:/]# fdisk -l
Found valid GPT with protective MBR; using GPT

Disk /dev/mmcblk0: 15269888 sectors, 3360M
Logical sector size: 512
Disk identifier (GUID): 2d740000-0000-4a1e-8000-723e000032f8
Partition table holds up to 128 entries
First usable sector is 34, last usable sector is 15269854

Number  Start (sector)    End (sector)  Size Name
     1           16384           24575 4096K uboot
     2           24576           32767 4096K misc
     3           32768           98303 32.0M boot
     4           98304          163839 32.0M recovery
     5          163840          229375 32.0M backup
     6          229376         2326527 1024M rootfs
     7         2326528         2588671  128M oem
     8         2588672        15269854 6191M userdata
```

```bash
[root@RV1126_RV1109:/]# ls -al
total 110
drwxr-xr-x  21 root root  4096 Jan  1  1970 .
drwxr-xr-x  21 root root  4096 Jan  1  1970 ..
-rw-r--r--   1 root root     0 Mar  8  2021 .gitkeep
drwxr-xr-x   2 root root  4096 Apr 28  2021 bin
-rw-r--r--   1 root root 30162 Apr 23  2021 busybox.config
lrwxrwxrwx   1 root root     8 Apr 28  2021 data -> userdata
drwxr-xr-x  12 root root  2900 Jan  1 14:08 dev
drwxr-xr-x  17 root root  4096 Jan  1  1970 etc
-rwxr-xr-x   1 root root   178 Apr 28  2021 init
drwxr-xr-x   6 root root  4096 Apr 28  2021 lib
lrwxrwxrwx   1 root root     3 Apr 28  2021 lib32 -> lib
lrwxrwxrwx   1 root root    11 Apr 28  2021 linuxrc -> bin/busybox
drwx------   2 root root 16384 Apr 28  2021 lost+found
drwxr-xr-x   2 root root  4096 Mar  8  2021 media
lrwxrwxrwx   1 root root    23 Mar  8  2021 misc -> /dev/block/by-name/misc
drwxr-xr-x   3 root root  4096 Apr 28  2021 mnt
drwxr-xr-x   5 root root  1024 Jan  3  2017 oem
drwxr-xr-x   2 root root  4096 Mar  8  2021 opt
dr-xr-xr-x 115 root root     0 Jan  1  1970 proc
drwxr-xr-x  16 root root  4096 Apr 28  2021 rockchip_test
drwx------   3 root root  4096 Jan  1 12:00 root
drwxr-xr-x   7 root root   260 Jan  1  1970 run
drwxr-xr-x   2 root root  4096 Apr 28  2021 sbin
lrwxrwxrwx   1 root root    10 Apr 28  2021 sdcard -> mnt/sdcard
dr-xr-xr-x  13 root root     0 Jan  1  1970 sys
-rw-r--r--   1 root root    49 Apr 28  2021 timestamp
drwxrwxrwt   5 root root   300 Jan  1 14:08 tmp
lrwxrwxrwx   1 root root    10 Apr 28  2021 udisk -> media/usb0
drwxr-xr-x   8 root root  1024 Jan  1 14:09 userdata
drwxr-xr-x   9 root root  4096 Apr 22  2021 usr
drwxr-xr-x   4 root root  4096 Apr 28  2021 var
```

```bash
$ ls /bin
ash	   dir		  join	   mountpoint	  rm	     top
base64	   dmesg	  keyctl   mt		  rmdir      touch
bash	   dnsdomainname  kill	   mv		  run-parts  tracepath
busybox    dumpkmap	  link	   netstat	  sed	     traceroute6
cat	   echo		  linux32  nice		  setarch    true
chattr	   egrep	  linux64  pgrep	  setpriv    umount
chgrp	   false	  ln	   pidof	  setserial  uname
chmod	   fdflush	  login    ping		  sh	     uptime
chown	   fgrep	  ls	   pipe_progress  slabtop    usleep
clockdiff  free		  lsattr   pkill	  sleep      vdir
cp	   getopt	  mkdir    pmap		  stty	     vi
cpio	   grep		  mknod    printenv	  su	     vmstat
date	   gunzip	  mktemp   ps		  sync	     w
dd	   gzip		  more	   pwd		  tar	     watch
df	   hostname	  mount    pwdx		  tload      zcat
```

```bash
$ ls usr
bin  html  lib	lib32  libexec	qml  sbin  share

```

```bash
[root@RV1126_RV1109:/]# ls /etc/init.d/
S01cpu_perf	     S30_BMAC	  S50usbdevice	  S99_arcuvc
S01logging	     S30dbus	  S51n4		  S99_auto_reboot
S10atomic_commit.sh  S40network   S58_lunch_init  S99_firefly
S10udev		     S49alsa	  S60NPU_init	  S99z_cpu_auto
S20urandom	     S49ntp	  S65_rtcsync	  rcK
S21mountall.sh	     S50fcgiwrap  S88watchdog	  rcS
S22config_env	     S50nginx	  S98_lunch_init
```


ADB on i.MX 8
https://lzqblog.top/2019-07-27/i-MX8-adb-bring-up/

USB_FUNCTIONFS