#########################################################################
#
#              Author: b51
#                Mail: b51live@gmail.com
#            FileName: installEnv.sh
#
#          Created On: Fri 24 Nov 2017 10:44:09 AM CST
#
#########################################################################

#!/bin/bash

# Script for installing my settings on New Ubuntu Machine.
# Last test on Ubuntu 16.04

PWD=`pwd`
DIRROOT=$PWD/..

# Remove libreoffice
/bin/echo -e "\e[1;32mRemove libreoffice.\e[0m"
sudo apt remove libreoffice-common libreoffice-core -y
sudo apt update -y
sudo apt dist-upgrade -y

# Install
/bin/echo -e "\e[1;32mInstall Something.\e[0m"
sudo apt-get install ssh vim git tree htop silversearcher-ag exuberant-ctags x11vnc python-pip python-wstool build-essential -y

# Vim settings
/bin/echo -e "\e[1;32mSetting Vim.\e[0m"
cd $DIRROOT
cp -r VimSettings/.vim* $HOME
cd $HOME/.vim/bundle/
wstool update
cd YouCompleteMe
python install.py

# Git settings
/bin/echo -e "\e[1;32mSetting Git.\e[0m"
cd $DIRROOT
cp GitSettings/.gitconfig $HOME

# Caps Ctrl exchange
/bin/echo -e "\e[1;32mMaking Caps as Ctrl.\e[0m"
sudo tee -a /etc/default/keyboard > /dev/null <<'EOF'
# KEYBOARD CONFIGURATION FILE

# Consult the keyboard(5) manual page.

XKBMODEL="pc105"
XKBLAYOUT="us"
XKBVARIANT=""
XKBOPTIONS="ctrl:nocaps"

BACKSPACE="guess"
EOF

sudo dpkg-reconfigure keyboard-configuration

# Try auto press enter for keyboard configuration
#expect << "END"
#    spawn sudo dpkg-reconfigure keyboard-configuration
#    expect "Please select the model of the keyboard of this machine."
#    sleep 2
#    send "\r"
#    expect "Country of origin for the keyboard:"
#    sleep 2
#    send "\r"
#    expect "Please select the layout matching the keyboard for this machine."
#    sleep 2
#    send "\r"
#    expect "Keep current keyboard options in the configuration file?"
#    sleep 2
#    send "\r"
#END

# Install ROS
/bin/echo -e "\e[1;32mInstalling ROS Kinetic.\e[0m"
sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'
sudo apt-key adv --keyserver hkp://ha.pool.sks-keyservers.net:80 --recv-key 421C365BD9FF1F717815A3895523BAEEB01FA116
sudo apt-get update -y
sudo apt-get install ros-kinetic-desktop -y
sudo rosdep init
rosdep update
echo "source /opt/ros/kinetic/setup.bash" >> ~/.bashrc
source ~/.bashrc
sudo apt-get install python-rosinstall python-rosinstall-generator python-wstool build-essential python-catkin-tools
