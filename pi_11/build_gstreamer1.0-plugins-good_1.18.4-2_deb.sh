#!/bin/bash

cd /build/gst-plugins-good1.0-1.18.4/
debuild -b -uc -us
cp /build/gst-plugins-good1.0-1.18.4/debian/tmp/usr/lib/*/gstreamer-1.0/libgstrpicamsrc.so /home/pi/Docker/otp-voip/pi_11/
cp /build/gstreamer1.0*.deb /home/pi/Docker/otp-voip/pi_11/

