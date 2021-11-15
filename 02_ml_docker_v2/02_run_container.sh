#!/bin/bash

if ! command -v glxinfo &> /dev/null
then
    echo "glxinfo command  not found! Execute \'sudo apt install mesa-utils\' to install it."
    exit
fi

vendor=`glxinfo | grep vendor | grep OpenGL | awk '{ print $4 }'`

if [ $vendor == "NVIDIA" ]; then
    docker run -it --rm \
        --name pxl_ml_container \
        --hostname pxl_ml_container \
        --device /dev/snd \
        --env="DISPLAY" \
        --env="QT_X11_NO_MITSHM=1" \
        --volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" \
        -v `pwd`/../commands/bin:/home/user/bin \
        -v `pwd`/../notebooks:/home/user/notebooks \
        -v `pwd`/../data:/home/user/data \
        -env="XAUTHORITY=$XAUTH" \
        --volume="$XAUTH:$XAUTH" \
        --gpus all \
        -p 7777:7777 \
        pxl_ml_image_2:latest \
        bash
else
    docker run --privileged -it --rm \
        --name pxl_ml_container \
        --hostname pxl_ml_container \
        --volume=/tmp/.X11-unix:/tmp/.X11-unix \
        -v `pwd`/../commands/bin:/home/user/bin \
        -v `pwd`/../notebooks:/home/user/notebooks \
        -v `pwd`/../data:/home/user/data \
        --device=/dev/dri:/dev/dri \
        --env="DISPLAY=$DISPLAY" \
        -e "TERM=xterm-256color" \
        --cap-add SYS_ADMIN --device /dev/fuse \
        -p 7777:7777 \
        pxl_ml_image_2:latest \
        bash
fi
