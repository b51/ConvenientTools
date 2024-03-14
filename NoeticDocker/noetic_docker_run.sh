#########################################################################
#
#              Author: b51
#                Mail: b51live@gmail.com
#            FileName: docker_run.sh
#
#          Created On: Thu 14 Mar 2024 04:59:50 PM CST
#
#########################################################################

#!/bin/bash

XAUTH=/tmp/.docker.xauth
if [ ! -f $XAUTH ]; then
    touch $XAUTH
    xauth_list=$(xauth nlist :0 | sed -e 's/^..../ffff/')
    if [ ! -z "$xauth_list" ]
    then
        echo $xauth_list | xauth -f $XAUTH nmerge -
    fi
    chmod a+r $XAUTH
fi

# share host X server to docker
xhost +local:

docker run --rm -it \
  --privileged \
  --gpus all \
  --network host \
  -e DISPLAY=$DISPLAY \
  -e NVIDIA_DRIVER_CAPABILITIES=all \
  -e NVIDIA_VISIBLE_DEVICES=all \
  -e QT_X11_NO_MITSHM=1 \
  -v /tmp/.X11-unix:/tmp/.X11-unix:rw \
  -e $XAUTH:$XAUTH \
  -w /home/noetic/ \
  --runtime nvidia \
  --name ros_docker \
  --user noetic \
  noetic-local /bin/zsh "$@"
