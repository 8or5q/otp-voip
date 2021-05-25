#!/bin/bash

export LD_LIBRARY_PATH=/usr/local/lib/x86_64-linux-gnu:/usr/local/lib
export PKG_CONFIG_PATH=/usr/local/lib/pkgconfig:/usr/local/lib/x86_64-linux-gnu/pkgconfig
export CPPFLAGS='-I/usr/local/include'
export PYTHONPATH=/usr/local/lib/python3.7/site-packages
export GI_TYPELIB_PATH=/usr/local/lib/x86_64-linux-gnu/girepository-1.0
export GST_PLUGIN_PATH=/usr/local/lib/x86_64-linux-gnu/gstreamer-1.0

otp_voip_client

