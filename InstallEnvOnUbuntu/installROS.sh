#########################################################################
#
#              Author: b51
#                Mail: b51live@gmail.com
#            FileName: installROS.sh
#
#          Created On: Wed Jul  4 17:31:05 2018
#
#########################################################################

#!/bin/bash

PWD=`pwd`
DIRROOT=$PWD/..

# Installing ROS
/bin/echo -e "\e[1;32mInstalling ROS Kinetic.\e[0m"
sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'
sudo apt-key adv --keyserver hkp://ha.pool.sks-keyservers.net:80 --recv-key 421C365BD9FF1F717815A3895523BAEEB01FA116
sudo apt-get update -y
sudo apt-get install ros-kinetic-desktop -y
sudo rosdep init
rosdep update

tee -a ~/.bashrc > /dev/null <<'EOF'
source /opt/ros/kinetic/setup.bash
ros_ip=`ifconfig wlan0 | grep "inet addr" | awk -F: '{print $2}' | awk '{print $1}'`
export ROS_IP=$ros_ip
EOF

source ~/.bashrc
