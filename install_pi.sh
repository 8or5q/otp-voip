#!/bin/bash

DEBIAN_FRONTEND=noninteractive apt update -y
DEBIAN_FRONTEND=noninteractive apt --no-install-recommends -y full-upgrade
DEBIAN_FRONTEND=noninteractive apt install --no-install-recommends -y \
    gdebi-core \
    xz-utils
DEBIAN_FRONTEND=noninteractive apt remove --no-install-recommends -y \
    gstreamer1.0-alsa \
    gstreamer1.0-libav \
    gstreamer1.0-plugins-bad \
    gstreamer1.0-plugins-base \
    gstreamer1.0-plugins-good \
    gstreamer1.0-x
gdebi --non-interactive ./build/srt_1.4.2.20210428-1_armhf.deb
gdebi --non-interactive ./build/webrtc-audio-processing_0.3.1.20210428-1_armhf.deb
gdebi --non-interactive ./build/gstreamer-voip_1.18.4.20210428-1_armhf.deb
gdebi --non-interactive ./build/otp-voip_1.0.0_all.deb

