ARG DOCKER_TAG=focal

FROM dorowu/ubuntu-desktop-lxde-vnc:${DOCKER_TAG}

# from https://github.com/osrf/docker_images/tree/master/ros/foxy/ubuntu/focal/ros-core

# setup timezone
RUN echo 'Etc/UTC' > /etc/timezone && \
    apt-get update && \
    apt-get install -q -y --no-install-recommends tzdata && \
    rm -rf /var/lib/apt/lists/*

# install packages
RUN apt-get update && apt-get install -q -y --no-install-recommends \
    dirmngr \
    gnupg2 \
    && rm -rf /var/lib/apt/lists/*

# setup sources.list
RUN echo "deb http://packages.ros.org/ros2/ubuntu focal main" > /etc/apt/sources.list.d/ros2-latest.list

# setup keys
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys C1CF6E31E6BADE8868B172B4F42ED6FBAB17C654

# setup environment
ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8

ENV ROS_DISTRO foxy

# install ros2 packages
RUN apt-get update && apt-get install -y --no-install-recommends \
    ros-foxy-ros-core=0.9.2-1* \
    && rm -rf /var/lib/apt/lists/*

# from https://github.com/osrf/docker_images/blob/master/ros/foxy/ubuntu/focal/ros-base/Dockerfile

# install bootstrap tools
RUN apt-get update && apt-get install --no-install-recommends -y \
    build-essential \
    git \
    python3-colcon-common-extensions \
    python3-colcon-mixin \
    python3-rosdep \
    python3-vcstool \
    && rm -rf /var/lib/apt/lists/*

# bootstrap rosdep
RUN rosdep init && \
  rosdep update --rosdistro $ROS_DISTRO

# setup colcon mixin and metadata
RUN colcon mixin add default \
      https://raw.githubusercontent.com/colcon/colcon-mixin-repository/master/index.yaml && \
    colcon mixin update && \
    colcon metadata add default \
      https://raw.githubusercontent.com/colcon/colcon-metadata-repository/master/index.yaml && \
    colcon metadata update

# install ros2 packages
RUN apt-get update && apt-get install -y --no-install-recommends \
    ros-foxy-ros-base=0.9.2-1* \
    && rm -rf /var/lib/apt/lists/*

# from https://github.com/osrf/docker_images/tree/master/ros/foxy/ubuntu/focal/desktop

# install ros2 packages
RUN apt-get update && apt-get install -y --no-install-recommends \
    ros-foxy-desktop=0.9.2-1* \
    && rm -rf /var/lib/apt/lists/*

RUN sudo apt update && \
    sudo apt install -y \
    ros-foxy-nav2-rviz-plugins \
    ros-foxy-rmw-cyclonedds-cpp \
    ros-foxy-gazebo-ros-pkgs && \
    sudo rm -rf /var/lib/apt/lists/*

RUN echo "\
\n\
source /opt/ros/$ROS_DISTRO/setup.bash \n\
export RMW_IMPLEMENTATION=rmw_cyclonedds_cpp \n\
" \
| tee -a /root/.bashrc /home/ubuntu/.bashrc

COPY ./resources/LXTerminal /Desktop/

COPY ./resources/husarion_1.jpg /usr/local/share/doro-lxde-wallpapers/bg1.jpg
COPY ./resources/husarion_2.jpg /usr/local/share/doro-lxde-wallpapers/bg2.jpg

