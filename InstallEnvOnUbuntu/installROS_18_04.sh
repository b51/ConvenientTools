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
sudo apt-key adv --keyserver 'hkp://keyserver.ubuntu.com:80' --recv-key C1CF6E31E6BADE8868B172B4F42ED6FBAB17C654
sudo apt-get update -y
sudo apt-get install ros-melodic-desktop -y
sudo rosdep init
rosdep update

tee -a ~/.zshrc > /dev/null <<'EOF'
source /opt/ros/melodic/setup.zsh
ros_ip=`ifconfig wlan0 | grep "inet addr" | awk -F: '{print $2}' | awk '{print $1}'`
export ROS_IP=$ros_ip
EOF

source ~/.zshrc
sudo apt install python-rosinstall python-rosinstall-generator python-wstool build-essential python-catkin-tools -y

### Use catkin with anaconda3 ###
#conda install setuptools
#pip install -U rosdep rosinstall_generator wstool rosinstall six vcstools
