


# Booting

`/rkbin` binaries are used to construct loaders.

* [Rockchip Linux GPT partition](http://opensource.rock-chips.com/wiki_Partitions)
* [Rockchip Boot Option](http://opensource.rock-chips.com/wiki_Boot_option)


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


## Apps

* [Face Recognition Gate](https://wiki.t-firefly.com/en/CAM-C11262U/Application_scenarios.html#face-recognition-gate)
* [Facial Gate Power On](https://wiki.t-firefly.com/en/CAM-C11262U/usage.html#facial-gate)
* [AI_UVC Camera](https://wiki.t-firefly.com/en/CAM-C11262U/Application_scenarios.html#ai-uvc-camera)
* [AI UVC Power On](https://wiki.t-firefly.com/en/CAM-C11262U/usage.html#ai-uvc)


## Build Firmware

```bash
docker compose run --rm builder-rv1109
/workspace # ./build.sh cam-crv1126s2u-uvcc.mk
/workspace # FORCE_UNSAFE_CONFIGURE=1 ./build.sh
```

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
