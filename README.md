# Docker and ROS on Embedded Linux (Ubuntu in this case)
A description of how to quickly run a ROS program on embeded Linux install (in this case, Rock64). Everything besides the first line also 
applies to Debian or Raspbian on a RPi3.

Note this example shows how build your Docker container image on the device. Much more convenient, although more complicated methods (to explain) are 
to cross-compile the ARM Docker image on x86 using QEMU, push to registry, then download on device. This allows for seamless Over-the-Air updates to your device. **It can save a lot of time.** You can also use a RPi linked up to a CI/CD service like Gitlab or CI/CD to automatically build the ARM images instead of cross-compiling.

# Steps

Repositories setup as-is have some changes that need to be explicity accepted:

1. `sudo apt-get --allow-releaseinfo-change update`

Install docker

1. `curl -fsSL https://get.docker.com -o get-docker.sh`
2. `sudo sh get-docker.sh` 
3. `sudo usermod -aG docker rock64`
 
4. Logout and log back in

Test docker

1. `docker run hello-world`

Grab ROS image

1. `docker pull ros:melodic-ros-core`

SCP/Clone your package

Build and run (see below)

# Building and Running a ROS package.
ROS provides a comprehensive set of Docker Images): https://hub.docker.com/_/ros.

You can use these images directly or build your own image. If you have dependencies, you will need to build your own base image.

### Example using the image directly:
Let's say I have a ROS package in `~/catkin_ws/src/somePackage`.
From `~/catkin_ws/src/` on Host:
1. `tar -czf package.tar.gz ./somePackage`
2. `scp package.tar.gz rock64@192.168.1.25`

On Device:
1. `tar -xzf package.tar.gz`
2. `docker run --rm -it $PWD/somePackage:/home/ros/catkin_ws/src/somePackage ros:melodic-ros-core`
3. You are now in the container.
4. Go to `/home/ros/catkin_ws` and you can run `catkin_make` just fine.

### Example using ros-melodic-core as a base image
In the repository I've included a couple files that demonstrate how to use the ros-melodic core as a base image for adding additional dependencies, and directly copying the source code into the image. The ROS Docker page also has more examples.

The ros-entrypoint.sh file is copied into the image and provides a convenient way to source your development file before the main command is executed.

### Mapping in device files to runnining container.
Use the device option: `docker run --device /dev/asdf ...` 
