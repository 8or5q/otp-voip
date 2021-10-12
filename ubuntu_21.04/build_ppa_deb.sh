#!/bin/bash

cp ../shares/otp_voip_* ./otp-voip/
cd ./otp-voip/
debuild -S
cd ..
rm ./otp-voip/otp_voip_*
#dput ppa:ikagyse/ppa otp-voip_0.0.1_source.changes


