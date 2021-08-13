#!/bin/bash

mkdir -p ./otp-voip_1.0.2_all/usr/bin/
cp ../shares/otp_voip_* ./otp-voip_1.0.2_all/usr/bin/
dpkg-deb --build ./otp-voip_1.0.2_all ./otp-voip_1.0.2_all.deb
rm ./otp-voip_1.0.2_all/usr/bin/otp_voip_*

