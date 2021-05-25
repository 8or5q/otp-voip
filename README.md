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

* I recommend you first do a loopback test by setting the following values.
'''
Encryption -> Use Encryption: No
Video -> Camera: webcam-jpeg (assuming your webcam supports JPEG mode, more modes will be supported later rpicamsrc should be used for the Raspberry PI camera)
Video -> Video Encoder: x264 (x264 for PC or rpicamsrc for Raspberry PI camera)
Video -> Resolution: 848x480 (start with a low value you can increase it later)
Video -> Video Bitrate: 524288
Audio -> Echo Cancellation: yes
Audio -> Audio Bitrate: 24576
Audio -> Sound In: eg alsa_input.pci-0000_00_1f.3.analog-stereo (use whatever input seems reasonable to you avoid inputs that end in "monitor" as these are loopbacks)
Audio -> Sound Out: eg alsa_output.pci-0000_00_1f.3.analog-stereo (use whatever output seems reasonable)
General -> Video and Audio: both
General -> Protocol: srt-direct (since we are testing loopback we can't use a proxy protocol type)
General -> Embedded: yes
General -> Loopback Mode: yes
'''
Now plugin some headphones and click Start and confirm your audio and video are working.

* I next recommend doing a direct connection test without encryption (if possible, if not skip to next test).
Setup another PC identically to how you setup this one with the same settings as above, then change the settings you set above as follows on both systems.
'''
General -> Direct Partner Address: the partner IP to connect to
General -> Direct Partner Port: the partner port to connect to
General -> Direct Local Port: the local port to receive connections on
General -> Loopback Mode: no
'''
Now plugin some headphones and click Start and confirm your audio and video are working on both systems.

* I next recommend doing a proxy connection test without encryption.
This allows two systems both behind firewalls to connect to one another using UDP NAT hole punching.
It requires that you run the script "otp_voip_server" on a server with known public IP. (it should have minimum requirements except for python)
It will listen on all interfaces on port 10000 by default, you can edit the script to change this if required.
Once the server is running change the settings you set above as follows.
'''
General -> Server Address: the IP address or domain name of the proxy server you setup above
General -> Server Port: the port of the proxy server you setup above
General -> Session Id: A string you will use on both clients the uniquely identify the session to allow them to pair together.
General -> Protocol: srt-proxy
'''
Now plugin some headphones and click Start and confirm your audio and video are working on both systems.

* The last test is turning on encryption.
This requires that you have two identical random data files on both clients and you will want ot ensure that the "OTP Out File" on one system is set as the "OTP In File" on the other system.
The settings you will need to change are as follows.
'''
Encryption -> Use Encryption: yes
Encryption -> Select OTP Out File (be sure to use opposite files on opposite systems)
Encryption -> Select OTP In File (be sure to use opposite files on opposite systems)
'''
You should notice now that "OTP Out Position" on both systems in pointing to the last byte in each of the corresponding "OTP Out File", meanwhile "OTP In Position" is "999999999999999" as no connection has been established yet.
Now plugin some headphones and click Start and confirm your audio and video are working on both systems.
As the call progresses you should see the values for "OTP Out Position" and "OTP In Position" update every 5 seconds or so with a slowly decreasing value.
This is the amount of remaining random data in your OTP file that you can use to make encrypted calls, if this reaches 0, things will crash.

### Special Usage Notes
* When you click "Select OTP Out File" and choose a different file for talking with a different person (you should have two different random data files for each person you will talk to), the software should remember the last "OTP Out Position" for a given file in it's config file. This means later if you select that file again, the "OTP Out Position" should start at the value set at the end of your last call.

### Known Issues
* You cannot change the video bitrate during a call currently.
* Picture in Picture for self preview doesn't work on PC
* The software requires an encryption file to be set even if "Use Encryption" is "no", it sets a default dummy encryption file by default to work-around this, it needs to be fixed.
* The "Select OTP XXX File" dialog appears to show folder names with an unreadable white font on some systems.

## Random Number Generators
### Prebuilt RNG
http://ubld.it/truerng_v3
https://www.tindie.com/products/ubldit/truerng-v3/

https://leetronics.de/en/shop/infinite-noise-trng/
https://www.tindie.com/products/manueldomke/infinite-noise-trng-true-random-number-generator/

### Build Your Own + FPGA based whitener:
https://github.com/secworks/trng
