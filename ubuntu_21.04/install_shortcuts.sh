#!/bin/bash

DEBIAN_FRONTEND=noninteractive

wget https://github.com/8or5q/otp-voip/raw/master/ubuntu_21.04/otp_voip_client.desktop
mkdir -p /home/ubuntu/Desktop/
cp ./otp_voip_client.desktop /home/ubuntu/Desktop/
chown -R ubuntu:ubuntu /home/ubuntu/Desktop
mkdir -p /home/ubuntu/.config/autostart/
cp ./otp_voip_client.desktop /home/ubuntu/.config/autostart/
chown -R ubuntu:ubuntu /home/ubuntu/.config/autostart/
mkdir -p /home/ubuntu/.local/share/applications/
cp ./otp_voip_client.desktop /home/ubuntu/.local/share/applications/
chown -R ubuntu:ubuntu /home/ubuntu/.local/share/applications/
gio set /home/ubuntu/Desktop/otp_voip_client.desktop metadata::trusted true
chmod +x /home/ubuntu/Desktop/otp_voip_client.desktop

