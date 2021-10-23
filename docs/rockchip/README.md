# Rockchip Instructions

Download [Android Studio](https://developer.android.com/studio)




- [96boards Linux/macOS Host](https://github.com/96boards/documentation/blob/master/consumer/rock/installation/linux-mac-rkdeveloptool.md)
- 
- 
- 

Install build dependency:

```
brew install automake autoconf libusb
```

Clone the source code and build:

```
git clone https://github.com/rockchip-linux/rkdeveloptool
cd rkdeveloptool
autoreconf -i
./configure
make
```

Now you have rkdeveloptool executable at the current directory.

```
sudo cp rkdeveloptool /usr/local/bin/
```
