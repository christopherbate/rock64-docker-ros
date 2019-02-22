#!/bin/bash

# Note this a script to be run inside the docker container, not 
# for local dev
source /opt/ros/melodic/setup.bash
source /home/ros/catkin_ws/devel/setup.bash

exec "$@"