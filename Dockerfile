FROM ros:melodic-ros-base

RUN apt-get update && apt-get install -y --no-install-recommends \
    libncurses5 libncurses5-dev

# Create the workspace
WORKDIR /home/ros/catkin_ws

# copy in our files to catkin_ws/src
ADD . ./src/yourPackageName

COPY ./scripts/ros-entrypoint.sh /

RUN ["/bin/bash","-c","/ros-entrypoint.sh catkin_make"]

ENTRYPOINT ["/ros-entrypoint.sh"]
# This is the default command if none is supplied
CMD ["bash"]

