# One Time Pad Video and Voice Chat

## Table of contents
* [General info](#general-info)
* [Technologies](#technologies)
* [Buliding From Source](#building-from-source)
* [UI Options](#ui-options)
* [Random Number Generators](#random-number-generators)

## General info

A quick and dirty One Time Pad Video and Voice Chat tool written in Python based on GStreamer, SRT (simple reliable transport) and a simple OTP UDP proxy.

## Technologies
* [GStreamer v1.18.4](https://github.com/GStreamer/gst-build) 
* [SRT (Simple Reliable Transport) v1.4.2](https://github.com/Haivision/srt)
* [WebRTC AudioProcessing v0.3.1](https://www.freedesktop.org/software/pulseaudio/webrtc-audio-processing/)

## Buliding From Source
I recommend everyone build from source after reading the docker build files to understand the dependencies. 
The following instruction assumes you are building the amd64 PC variant but there is also a armhf variant for the Raspberry PI.
* Install [docker-ce](https://www.digitalocean.com/community/tutorials/how-to-install-and-use-docker-on-ubuntu-20-04)
* Install nxagent
* Install [x11docker](https://github.com/mviereck/x11docker)
* Clone this repository to ~/Docker/otp-voip/ if you intend to use the docker test_pX.sh scripts as is.
* Build the debian packages using the docker build image then copy the debian packages to the build folder (this builds a 4.5GB docker image).
```
sudo docker build -t otp-voip/otp-voip-build:amd64-1.18.4-1.4.2-20210428 -f Dockerfile_pc_build_1.18.4 .
x11docker -- --volume $HOME/Docker/otp-voip/build:$HOME/build --rm -- otp-voip/otp-voip-build:amd64-1.18.4-1.4.2-20210428 /bin/bash -c "cp /build/srt/*.deb ~/build/; cp /build/webrtc-audio-processing/*.deb ~/build/; cp /build/gstreamer-src/gst-build/*.deb ~/build"
```
* Build the otp-proxy debian package
```
./build_deb.sh
```
* Build the docker test image (this builds a 1.6GB docker image)
```
sudo docker build -t otp-voip/otp-voip:amd64-1.18.4-1.4.2-20210428 -f Dockerfile_pc_1.18.4 .
```
* Run the docker test image
```
./test_pc.sh
```
* If you so desire install the software from the packages you built, (beware this will uninstall potentially conflicting gstreamer packages if they are already installed, this may not be necessary so you may have luck removing the package exclusion policies and rebuilding if this is an issue.)
```
./install_pc.sh
```
* If you install the package you can launch it with the required environment variables as follows.
'''
./run_pc.sh
'''

## UI Options
The options are pretty hectic and the UI needs re-organization. I will update this with more specifics later.
For now I've just attempted to highlight the role of various settings below.

## Random Number Generators
### Prebuilt RNG
http://ubld.it/truerng_v3
https://www.tindie.com/products/ubldit/truerng-v3/

https://leetronics.de/en/shop/infinite-noise-trng/
https://www.tindie.com/products/manueldomke/infinite-noise-trng-true-random-number-generator/

### Build Your Own + FPGA based whitener:
https://github.com/secworks/trng
