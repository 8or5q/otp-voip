#!/bin/bash

mkdir -p ./.otp_client

DEVICES=""
for device in /dev/ttyUSB*
do
  if [ -c $device ]; then
    DEVICES="${DEVICES} --share $device"
  fi
done
for device in /dev/gpiochip*
do
  if [ -c $device ]; then
    DEVICES="${DEVICES} --share $device"
  fi
done

#<<'###BLOCK-COMMENT'
x11docker --pw pkexec --no-entrypoint --sudouser \
  --group-add video --group-add plugdev \
  --share $HOME/Downloads --share $HOME/Documents --share $HOME/Videos ${DEVICES} \
  --clipboard --nxagent --name otp-voip-001 \
  --pulseaudio \
  --webcam \
  -- \
  --network host \
  --volume /dev/bus:/dev/bus:ro \
  --volume $HOME/Docker/otp-voip/shares:$HOME/shares \
  --volume $HOME/Docker/otp-voip/.otp_client:$HOME/.otp_client \
  --volume /media/:/media/ \
  --rm \
  --env-file $HOME/Docker/otp-voip/pc.env \
  -- \
  otp-voip/otp-voip:amd64-1.18.4-1.4.2-20210428 \
  ~/shares/otp_voip_client
###BLOCK-COMMENT

<<'###BLOCK-COMMENT'
x11docker --pw pkexec --interactive --no-entrypoint --sudouser \
  --group-add video --group-add plugdev \
  --share $HOME/Downloads --share $HOME/Documents --share $HOME/Videos ${DEVICES} \
  --clipboard --nxagent --name otp-voip-001 \
  --pulseaudio \
  --webcam \
  -- \
  --network host \
  --volume /dev/bus:/dev/bus:ro \
  --volume $HOME/Docker/otp-voip/shares:$HOME/shares \
  --volume $HOME/Docker/otp-voip/.otp_client:$HOME/.otp_client \
  --volume /media/:/media/ \
  --rm \
  --env-file $HOME/Docker/otp-voip/pc.env \
  -- \
  otp-voip/otp-voip:amd64-1.18.4-1.4.2-20210428 \
  /bin/bash
###BLOCK-COMMENT
  
exit

# install docker https://www.digitalocean.com/community/tutorials/how-to-install-and-use-docker-on-ubuntu-20-04
# install nxagent

# otp-voip/otp-voip-build:pi-1.18.4-1.4.2-20210428 \
# otp-voip/otp-voip:pi-1.18.4-1.4.2-20210428 \
# otp-voip/otp-voip-build:amd64-1.18.4-1.4.2-20210428 \
# otp-voip/otp-voip:amd64-1.18.4-1.4.2-20210428 \

