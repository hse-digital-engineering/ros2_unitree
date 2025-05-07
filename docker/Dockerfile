ARG ROS_DISTRO="jazzy"
FROM ros:${ROS_DISTRO}-ros-base 

#RUN apt-get update && apt-get install -y \
#    ros-${ROS_DISTRO}-rmw-cyclonedds-cpp \
#    ros-${ROS_DISTRO}-rosidl-generator-dds-idl

# Install basic requirements
RUN apt-get update && apt-get install -y --no-install-recommends \
    curl \
    gnupg2 \
    lsb-release \
    python3-pip \
    python3-venv \
    portaudio19-dev \
    mesa-utils \
    libgl1 \
    libglx-mesa0 \
    libgl1-mesa-dri \
    ros-${ROS_DISTRO}-rviz2 \
    ros-${ROS_DISTRO}-joint-state-publisher-gui \
    software-properties-common

# Create workspace
WORKDIR /ros2_ws

# Clone the repository with submodules
COPY ros2_ws /ros2_ws

# Install Python requirements (with numpy constraint)
RUN python3 -m venv .venv && .venv/bin/pip install -r requirements.txt

# Install ROS dependencies
RUN . /opt/ros/${ROS_DISTRO}/setup.sh && \
    rosdep install --from-paths src --ignore-src -r -y

# Build the workspace
RUN . /opt/ros/${ROS_DISTRO}/setup.sh && \
    colcon build

# Source ROS2 and workspace in bashrc
RUN echo "source /opt/ros/${ROS_DISTRO}/setup.bash" >> /root/.bashrc && \
    echo "source /ros2_ws/install/setup.bash" >> /root/.bashrc

# Set environment variables
ENV ROBOT_IP=""
ENV CONN_TYPE="webrtc"
ENV WEBRTC_SERVER_HOST="0.0.0.0"
ENV WEBRTC_SERVER_PORT="9991"

# add /ros2_ws to the entrypoint
RUN sed --in-place --expression \
      '$isource "/ros2_ws/install/setup.bash"' \
      /ros_entrypoint.sh

CMD ["ros2", "launch", "go2_robot_sdk", "robot.launch.py"]
