#!/usr/bin/bash

xhost +local:root

docker run -it --rm \
    --network host \
    --env DISPLAY=$DISPLAY \
    --env XDG_RUNTIME_DIR=$XDG_RUNTIME_DIR \
    --volume /tmp/.X11-unix:/tmp/.X11-unix \
    --gpus all \
    -v /dev/dri:/dev/dri \
    -v $PWD/../ros2_ws/src:/ros2_ws/src \
    --hostname ros2-container \
    ros2_go2 bash