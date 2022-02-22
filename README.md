# One Time Pad Video and Voice Chat

## Table of contents
* [General info](#general-info)
* [Technologies](#technologies)
* [Buliding From Source](#building-from-source)
* [Installation](#installation)
* [UI Options](#ui-options)
* [Random Number Generators](#random-number-generators)

## General info

A quick and dirty One Time Pad Video and Voice Chat tool written in Python based on GStreamer, SRT (simple reliable transport) and a simple OTP UDP proxy.

## Technologies
* [GStreamer v1.18.4](https://github.com/GStreamer/gst-build) 
* [SRT (Simple Reliable Transport) v1.4.2](https://github.com/Haivision/srt)
* [WebRTC AudioProcessing v0.3.1](https://www.freedesktop.org/software/pulseaudio/webrtc-audio-processing/)

## Buliding From Source
I recommend everyone build from source as the new version based on ubuntu 21.04 doesn't require any custom built dependency packages (21.10 seems to have some kind of issue most probably due to a race condition in some gstreamer library that causes it to crash). 
The following instruction assumes you are building the amd64 PC variant but there is also a armhf variant for the Raspberry PI but it requires a number of special steps.
* Clone this repository to ~/Docker/otp-voip/ if you intend to use the docker test_pX.sh scripts as is.
* Build the otp-proxy debian package
```
cd ~/Docker/otp-voip/ubuntu_21.04
./build_deb.sh
```
* Build the docker test image assuming you want to run the software in docker (this builds a 1.6GB docker image)
* Install [docker-ce](https://www.digitalocean.com/community/tutorials/how-to-install-and-use-docker-on-ubuntu-20-04)
* Install nxagent
* Install [x11docker](https://github.com/mviereck/x11docker)
```
cd ~/Docker/otp-voip/
sudo docker build -t otp-voip/otp-voip:amd64-ubuntu-21.04 -f Dockerfile_ubuntu_21.04 .
```
* Run the docker test image
```
./test_ubuntu_21.04.sh
otp_voip_client
```

## Installation
* If you so desire install the software from the packages you built you can do so as follows
```
sudo add-apt-repository -y universe multiverse
sudo apt update -y
sudo apt install --no-install-recommends -y gdebi-core xz-utils
sudo gdebi --non-interactive ~/Docker/otp-voip/ubuntu_21.04/otp-voip_0.0.4_all.deb
rm ~/.cache/gstreamer-1.0/registry.x86_64.bin
```
* If you want to build a bootable persistant ubuntu usb stick with the software I recommend using mkusb and doing the following
```
sudo add-apt-repository ppa:mkusb/ppa
sudo apt update
sudo apt install --install-recommends mkusb mkusb-nox usb-pack-efi
cd ~/Docker/otp-voip/ubuntu_21.04
[run mkusb and setup a persistent usb stick with ubuntu 21.04 or 21.10 or later]
sudo mkdir -p /media/${SUDO_USER:-${USER}}/writable/upper/home/ubuntu/
sudo cp ./install_deb.sh /media/${SUDO_USER:-${USER}}/writable/upper/home/ubuntu/
sudo cp ./install_shortcuts.sh /media/${SUDO_USER:-${USER}}/writable/upper/home/ubuntu/
[unmount the usb stick from your system and boot it up on bootable device you intend to use then open a terminal for the "ubuntu" user and run the follow commands]
sudo ./install_deb.sh
sudo ./install_shortcuts.sh
```

## UI Options
The options are pretty hectic and the UI needs re-organization. I will update this with more specifics later.

* First confirm your AV settings are correct (use the override checkbox only for those values that differ than defaults)
```
Click on Edit AV Setting Defaults
Video In: /dev/video0 (unless you have multiple cameras)
Video Source: webcam 320x240 30.000 (use a different mode if you prefer but better to start low, rpicamsrc should be used for the Raspberry PI camera)
Video Bitrate: 524288
Video Encoder: x264 (x264 for PC or rpicamsrc for Raspberry PI camera)
Audio In: eg alsa_input.pci-0000_00_1f.3.analog-stereo (use whatever input seems reasonable to you avoid inputs that end in "monitor" as these are loopbacks)
Audio Out: eg alsa_output.pci-0000_00_1f.3.analog-stereo (use whatever output seems reasonable)
Audio Bitrate: 24576
Echo Cancellation: yes
Embedded: yes
Click Update AV Setting Defaults and close the window.
For Selected AV Setting choose audio_and_video
```

* I recommend you first do a loopback test by pluging in some headphones and then clicking Connect for the connection called loopback_test. Then confirm your audio and video are working and you see and hear yourself.

* I next recommend doing a direct connection test without encryption (if possible, if not skip to next test).
Setup another PC identically to how you setup this one with the same settings as above, then add a new connection with the settings as below on both systems. (use the override checkbox only for those values that differ than defaults)
```
Connection Name -> Direct Test A
Shared Session Id -> direct_test_a (the shared session id can be anything for direct connections and doesn't need to match on both machines)
Use Protocol -> srt-direct
Direct Local Port: the local port to receive connections on
Direct Partner Address: the partner IP to connect to
Direct Partner Port: the partner port to connect to
```
Now plugin some headphones and click Start and confirm your audio and video are working and connect between both systems.

* I next recommend doing a proxy connection test without encryption.
This allows two systems both behind firewalls to connect to one another using UDP NAT hole punching.
It requires that you run the script "otp_voip_server" on a server with known public IP. (it should have minimum requirements except for python)
It will listen on all interfaces on port 10000 by default, you can edit the script to change this if required.
Once the server is running add a new connection with the settings as below on both systems. (use the override checkbox only for those values that differ than defaults)
```
Connection Name -> Proxy Test A
Shared Session Id -> proxy_test_a (the shared session id must match on both machines when using a proxy)
Use Protocol -> srt-proxy
Pairing Server Address: the IP address or domain name of the proxy server you setup above
Pairing Server Port: the port of the proxy server you setup above
```
Now plugin some headphones and click Start and confirm your audio and video are working and connect on both systems.

* The last test is turning on encryption.
This requires that you have two identical random data files on both clients and you will want to ensure that the "OTP Out File" on one system is set as the "OTP In File" on the other system.
The settings you will need to change are as follows.
```
Use Encryption: yes
OTP Out File -> Browse (be sure to use opposite files on opposite systems)
OTP In File -> Browse (be sure to use opposite files on opposite systems)
```
You should notice now that "OTP Out Position" on both systems in pointing to the last byte in each of the corresponding "OTP Out File", meanwhile "OTP In Position" is "999999999999999" as no connection has been established yet.
Now plugin some headphones and click Start and confirm your audio and video are working on both systems.
As the call progresses you should see the values for "OTP Out Position" and "OTP In Position" update every 10 seconds or so with a slowly decreasing value (if you have the edit window open).
This is the amount of remaining random data in your OTP file that you can use to make encrypted calls, if this reaches 0, things will crash.

### Known Issues
* You cannot change the video bitrate during a call currently.
* Picture in Picture for self preview doesn't work on PC
* The "Select OTP XXX File" dialog appears to show folder names with an unreadable white font on some systems.

## Random Number Generators
### Prebuilt RNG
http://ubld.it/truerng_v3
https://www.tindie.com/products/ubldit/truerng-v3/
https://leetronics.de/en/shop/infinite-noise-trng/
https://www.tindie.com/products/manueldomke/infinite-noise-trng-true-random-number-generator/

### Build Your Own RNG Based On A Camera
* This is one of the best approaches because you can generate huge amounts of data very quickly and are fully able to audit the raw and conditioned data.
https://journals.aps.org/prx/pdf/10.1103/PhysRevX.4.031056

