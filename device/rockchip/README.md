


# Booting

`/rkbin` binaries are used to construct loaders.

* [Rockchip Linux GPT partition](http://opensource.rock-chips.com/wiki_Partitions)
* [Rockchip Boot Option](http://opensource.rock-chips.com/wiki_Boot_option)
* [Rockusb Mode](https://roc-rk3328-cc.readthedocs.io/en/latest/flash_emmc.html#rockusb-mode). Found valid IDB on eMMC. Using recovery button.
* [Maskrom Model](https://roc-rk3328-cc.readthedocs.io/en/latest/flash_emmc.html#maskrom-mode). eMMC is empty. No IDB found on eMMC.
* [Rust based Oreboot as future option](https://github.com/oreboot/oreboot)


## Chipsets

* [RKMedia](https://wiki.t-firefly.com/en/CAM-C11262U/Rkmedia.html)
* [Video Decoding VDEC]()
* [Video Input VI]()
* [Cropping, format, scaling, etc. RGA]()
* [Video Output VO]()
* [Video Encoding VENC]()
* [RKNN-Toolkit Introduction](https://wiki.t-firefly.com/en/CAM-C11262U/Algorithm_diy.html)


## Boards

* [Rockchip RP-RV1109 Core board (stamp hole 44mm long*44mm wide*3.2mm high 40x40 pins)](http://www.rpdzkj.com/copy_2_1703937_175104_3523609.html)
* [Rongpin RP-RV1126](https://www.alibaba.com/product-detail/Rockchip-RV1126-Development-Board-RV1126-Core_1600223023771.html?spm=a2700.details.0.0.494b5c74IaAKOi)
* [Firefly Core-1126-JD4](http://en.t-firefly.com/doc/download/page/id/88.html)
* [Firefly Core-1109-JD4](http://en.t-firefly.com/doc/download/87.html)
* [Firefly CAM-C1109S2U](http://en.t-firefly.com/doc/product/index/id/85.html)
* [ASUS Tinker Edge R HS0009 RK3399Pro](https://www.youyeetoo.net/thread-3-post-4.html)


## Apps

* [Face Recognition Gate](https://wiki.t-firefly.com/en/CAM-C11262U/Application_scenarios.html#face-recognition-gate)
* [Facial Gate Power On](https://wiki.t-firefly.com/en/CAM-C11262U/usage.html#facial-gate)
* [AI_UVC Camera](https://wiki.t-firefly.com/en/CAM-C11262U/Application_scenarios.html#ai-uvc-camera)
* [AI UVC Power On](https://wiki.t-firefly.com/en/CAM-C11262U/usage.html#ai-uvc)

## Video and Neural APIs

* [RKMedia](https://wiki.t-firefly.com/en/CAM-C11092U/Rkmedia.html?highlight=rkmedia)
* [ZBar + RKMedia post](https://dev.t-firefly.com/thread-103667-1-1.html)


## Build Firmware

```bash
docker compose run --rm builder-rv1109
/workspace # ./build.sh cam-crv1126s2u-uvcc.mk
/workspace # FORCE_UNSAFE_CONFIGURE=1 ./build.sh
```

Upon completion the build produces the equalent of [a Firefly release](https://drive.google.com/drive/folders/1YOT6JQOdz1ufBu0nm3Cu2Dz6Xh1rwT3c).

- aio-rv1126-jd4-ipc.cfg
- boot.img
- MiniLoaderAll.bin
- misc.img
- oem.img
- parameter.txt
- recovery.img
- rootfs.img
- uboot.img
- userdata.img

The exact names will be revised to match the relevant build output.

To write them to the device using Windows load the config named rv1126_rv1109-config.cfg


### Debugging

* [Debug interface](https://wiki.t-firefly.com/en/CAM-C11262U/usage.html#debug-interface)
* [Setup Linux RNDIS](https://wiki.t-firefly.com/en/CAM-C11262U/usage.html#linux-host)



## TODO

1. Builds for RV1109 and RV1126
2. Intermediate build output from builds (in rockdev) is copied to /dist/build/rockchip/
3. Final images and dtb/config/params is copied to /dist/rv1109 and /dist/rv1126
4. Working builds for Facial Gate using builder-rv1109-facial-gate.Dockerfile
5. Working builds for AI UVC using builder-rv1109.Dockerfile
6. README howto updated, docker-compose.yml updated, Makefile updated
7. OV2640 vs GC2093 (1080p 2MP)
