#!/bin/bash

cp ../shares/otp_voip_* ./otp-voip/
cd ./otp-voip/
debuild -b
cd ..
rm ./otp-voip/otp_voip_*

