#!/bin/bash

export LD_LIBRARY_PATH=/usr/local/lib/arm-linux-gnueabihf:/usr/local/lib
export PKG_CONFIG_PATH=/usr/local/lib/pkgconfig:/usr/local/lib/arm-linux-gnueabihf/pkgconfig:/usr/vc/lib/pkgconfig
export CPPFLAGS='-I/usr/local/include'
export PYTHONPATH=/usr/local/lib/python3.7/site-packages
export GI_TYPELIB_PATH=/usr/local/lib/arm-linux-gnueabihf/girepository-1.0
export GST_PLUGIN_PATH=/usr/local/lib/arm-linux-gnueabihf/gstreamer-1.0

otp_voip_client

