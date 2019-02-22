# Running a ROS Program Running Quickly
A description of how to quickly run a ROS program on Rock64 OS install.

1. Repositories setup as-is have some changes that need to be explicity accepted:

`sudo apt-get --allow-releaseinfo-change update`

2. Install docker

`curl -fsSL https://get.docker.com -o get-docker.sh`
`sudo sh get-docker.sh` 
`sudo usermod -aG docker rock64`
 
3. Logout and log back in
4. Test docker
`docker run hello-world`
5. Grab ROS image
`docker pull ros:melodic-ros-core`
6. SCP/Clone your package
7. Build and run (see below)

# Building and Running a ROS package.
ROS provides (a comprehensive set of Docker Images)[ https://hub.docker.com/_/ros ].

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

### Mapping in device files to runnining container.
Use the device option: `docker run --device /dev/asdf ...` 
