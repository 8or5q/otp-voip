#!/bin/bash

cp ./shares/otp_voip_* ./otp-voip_1.0.0_all/usr/bin/
dpkg-deb --build ./otp-voip_1.0.0_all ./build/otp-voip_1.0.0_all.deb

