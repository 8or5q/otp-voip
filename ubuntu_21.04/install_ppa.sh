#!/bin/bash

DEBIAN_FRONTEND=noninteractive

mkdir /tmp/nouveau
cd /tmp/nouveau
wget https://raw.github.com/envytools/firmware/master/extract_firmware.py
wget http://us.download.nvidia.com/XFree86/Linux-x86/340.108/NVIDIA-Linux-x86-340.108.run
sh NVIDIA-Linux-x86-340.108.run --extract-only
python3 extract_firmware.py
sudo mkdir /lib/firmware/nouveau
sudo cp -d nv* vuc-* /lib/firmware/nouveau/

sudo add-apt-repository -y universe multiverse
sudo add-apt-repository ppa:ikagyse/ppa
sudo apt update -y
sudo apt install --no-install-recommends -y otp-voip

# vainfo should now show H264 support
rm ~/.cache/gstreamer-1.0/registry.x86_64.bin
# gst-inspect-1.0 libav should now show H264 support
# gst-inspect-1.0 libav
