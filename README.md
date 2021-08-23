# ros2-desktop-vnc

Based on [docker-ubuntu-vnc-desktop](https://github.com/fcwu/docker-ubuntu-vnc-desktop) project with ROS 2 packages installed the same way, as in official [OSRF ROS 2 Docker images](https://github.com/osrf/docker_images/tree/master/ros/foxy/ubuntu/focal).
This container initiates [vnc server](https://github.com/LibVNC/x11vnc) that allows remote access using graphical user interface. [HTML VNC Client](https://github.com/novnc/noVNC) is than used to allow for easy access in web browser. 
Container creates separate graphical (Ubuntu LXDE/LxQT) and user environment, so no user files nor any applications launched on host will be accessible via VNC.  


## Example

### RPLIDAR + remote desktop

Connect RPLIDAR to your laptop and...

1. Start all containers:

```bash
cd examples/rplidar
docker-compsoe pull
docker-compose up 
```

2. In the web browser open url: http://localhost:6080/

3. In the virtual desktop open LXTerminal from desktop shortcut

4. In the `LXTerminal` type:

```bash
ros2 run rviz2 rviz2
```

### RPLIDAR + remote desktop + husarnet


1. Get your Husarnet JoinCode

Before running example with Husarnet get your JoinCode, that you will use to connect Docker containers to the same P2P VPN network.

You will find your JoinCode at **https://app.husarnet.com  
 -> Click on the desired network  
 -> `Add element` button  
 -> `Join code` tab**

…and change the `JOINCODE` variable in the `.env` file located in `examples/husarnet` folder.

Additional information about Husarnet can be found here: **https://husarnet.com/docs/begin-linux**.

2. Start all containers:

```bash
cd husarion/rplidar
docker-compsoe pull
docker-compose up 
```

3. In the web browser open url: **[\<ip-v6-from-husarnet-network>]:6080/** (remember about square brackets around ipv6 address).

4. In the virtual desktop open LXTerminal from desktop shortcut.

5. In the `LXTerminal` type:

```bash
ros2 run rviz2 rviz2
```
