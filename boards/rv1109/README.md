

Links

* [Main Wiki page](https://wiki.t-firefly.com/en/CAM-C11262U/hardware.html)


CAM-CRV1126S2U/CAM-CRV1109S2U can virtualize itself as a UVC and RNDIS device, through the Typec otg interface, it can be connected to any host computer to make a AI_UVC camera.

To start a shell use the -shell service to get stdin & tty. If the container has already been built skip the build step.

```bash
docker compose build rockchip-amd
docker compose run --rm rockchip-amd
```



```bash
docker compose build rockchip-amd
# docker compose up rockchip-amd
# docker compose start rockchip-amd-shell
# docker compose exec rockchip-amd /rkbin/tools/upgrade_tool
docker compose run --rm rockchip-amd
```


## Connecting Dev - Board

Connect the USB to the OTG port next to the lights.

## Fixing adb on Linux Dev Machine

https://itsfoss.com/fix-error-insufficient-permissions-device/

> adb kill-server
> sudo adb start-server


## USB Ethernet / IP connection

Figure out the drivers used by Lego
https://www.ev3dev.org/docs/tutorials/connecting-to-the-internet-via-usb/

Support CNC Ethernet over RNDIS


