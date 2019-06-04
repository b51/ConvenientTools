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

# Remove Useless
/bin/echo -e "\e[1;32mRemove libreoffice and thunderbird.\e[0m"
sudo apt remove libreoffice-common libreoffice-core thunderbird --purge -y
sudo apt update -y

# Installing Tools
/bin/echo -e "\e[1;32mInstalling Tools.\e[0m"
sudo apt install ssh cmake vim git tree htop silversearcher-ag exuberant-ctags x11vnc tmux build-essential -y

# Installing Chrome
/bin/echo -e "\e[1;32mInstalling Chrome.\e[0m"
sudo tee -a /etc/apt/sources.list.d/google-chrome.list > /dev/null <<'EOF'
deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main
EOF
wget -qO - https://dl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
sudo apt update -y
sudo apt remove firefox -y
sudo apt install google-chrome-stable -y

# Installing Others
/bin/echo -e "\e[1;32mInstalling Others.\e[0m"
sudo apt install python-dev python3-dev python-pip python-rosinstall python-rosinstall-generator python-catkin-tools python-wstool libgoogle-glog-dev libprotobuf-dev libleveldb-dev -y

sudo apt dist-upgrade -y

# Vim settings
/bin/echo -e "\e[1;32mSetting Vim.\e[0m"
cd $DIRROOT
cp -r VimSettings/.vim* $HOME
cd $HOME/.vim/bundle/
wstool update -j8
#cat .rosinstall | grep uri | awk '{print $2}' | while read line; do git clone --recursive $line; done; #Can use this instead of wstool
cd dracula-theme && git remote add upstream https://github.com/dracula/vim && cd ..
cd YouCompleteMe
python3 install.py --clang-completer
# Alias csfiles to generate cscope.files
tee -a ~/.bashrc > /dev/null <<'EOF'
alias csfiles='find `pwd` -name "*.h" -o -name "*.c" -o -name "*.cpp" -o -name "*.cc" -o -name "*.m" -o -name "*.mm" -o -name "*.java" -o -name "*.py" > cscope.files'

export TERM=xterm-256color
EOF

# Git settings
/bin/echo -e "\e[1;32mSetting Git.\e[0m"
cd $DIRROOT
cp GitSettings/.gitconfig $HOME

# Tmux settings
/bin/echo -e "\e[1;32mSetting Tmux.\e[0m"
cd $DIRROOT
cp TmuxSettings/.tmux.conf $HOME

#Disable system problem report when login
/bin/echo -e "\e[1;32mDisable system problem report when login.\e[0m"
sudo tee -a /etc/default/apport > /dev/null <<'EOF'
# set this to 0 to disable apport, or to 1 to enable it
# you can temporarily override this with
# sudo service apport start force_start=1
enabled=0
EOF

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
