#!/bin/bash

DEBIAN_FRONTEND=noninteractive

sudo add-apt-repository -y universe multiverse
sudo apt update -y
sudo apt install --no-install-recommends -y gdebi-core xz-utils
wget https://github.com/8or5q/otp-voip/raw/master/pi_11/otp-voip_0.0.4_all.deb
sudo gdebi --non-interactive otp-voip_0.0.4_all.deb
wget https://github.com/8or5q/otp-voip/raw/master/pi_11/libgstrpicamsrc.so
sudo cp libgstrpicamsrc.so /usr/lib/arm-linux-gnueabihf/gstreamer-1.0/

# vainfo should now show H264 support
rm ~/.cache/gstreamer-1.0/registry.x86_64.bin
# gst-inspect-1.0 libav should now show H264 support
# gst-inspect-1.0 libav
