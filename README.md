# ros2-desktop-vnc

Based on [docker-ubuntu-vnc-desktop](https://github.com/fcwu/docker-ubuntu-vnc-desktop) project with ROS 2 packages installed the same way, as in official [OSRF ROS 2 Docker images](https://github.com/osrf/docker_images/tree/master/ros/foxy/ubuntu/focal)

## Example

### RPLIDAR + remote desktop

Connect RPLIDAR to your laptop and...

1. Start all containers:

```bash
cd examples/rplidar

docker-compose up --build
```

2. In the web browser open url: http://localhost:6080/

3. In the virtual desktop go to: 
> -> "Start" menu 
> -> System Tools 
> -> LXTerminal

4. In the `LXTerminal` type:

```bash
ros2 run rviz2 rviz2
```