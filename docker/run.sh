#!/usr/bin/bash

xhost +local:root

docker run -it --rm \
    --name r2g2 \
    --network host \
    --env="NVIDIA_DRIVER_CAPABILITIES=all" \
    --runtime=nvidia \
    --env DISPLAY=$DISPLAY \
    --env XDG_RUNTIME_DIR=$XDG_RUNTIME_DIR \
    --env QT_X11_NO_MITSHM=1 \
    --volume /tmp/.X11-unix:/tmp/.X11-unix \
    --gpus all \
    -v /dev/dri:/dev/dri \
    -v $PWD/../ros2_ws/src:/ros2_ws/src \
    --hostname ros2-container \
    --cpus="4" --memory="8g" \
    ros2_go2 bash