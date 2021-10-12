#!/bin/bash

cp /home/pi/Docker/otp-voip/shares/otp_voip_* /home/pi/Docker/otp-voip/pi_11/otp-voip/
cd /home/pi/Docker/otp-voip/pi_11/otp-voip/
debuild -b -uc -us
cd ..
rm /home/pi/Docker/otp-voip/pi_11/otp-voip/otp_voip_*


