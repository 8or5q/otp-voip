#!/bin/bash

mkdir -p ./otp-voip_1.0.0_all/usr/bin/
cp ./shares/otp_voip_* ./otp-voip_1.0.0_all/usr/bin/
dpkg-deb --build ./otp-voip_1.0.0_all ./build/otp-voip_1.0.0_all.deb
rm ./otp-voip_1.0.0_all/usr/bin/otp_voip_*

