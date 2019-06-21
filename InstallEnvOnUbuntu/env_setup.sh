#########################################################################
#
#              Author: b51
#                Mail: b51live@gmail.com
#            FileName: env_setup.sh
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
remove_useless() {
  printf "${BLUE}Remove libreoffice and thunderbird.${NORMAL}\n"
  sudo apt remove libreoffice-common libreoffice-core thunderbird firefox --purge -y
  sudo apt update -y
}

# Installing Tools
install_libs() {
  printf "${BLUE}Installing Tools.${NORMAL}\n"
  sudo apt install ssh cmake vim git tree htop silversearcher-ag exuberant-ctags tmux build-essential python-dev python3-dev python-pip python-rosinstall python-rosinstall-generator python-catkin-tools python-wstool libgoogle-glog-dev libprotobuf-dev libleveldb-dev -y
  sudo apt dist-upgrade -y
}

# Installing Chrome
install_chrome() {
  printf "${BLUE}Installing Chrome.${NORMAL}\n"
  sudo tee -a /etc/apt/sources.list.d/google-chrome.list > /dev/null <<'EOF'
  deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main
EOF
  wget -qO - https://dl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
  sudo apt update -y
  sudo apt install google-chrome-stable -y
}

# Vim settings
setting_vim() {
  printf "${YELLOW}Setting Vim.${NORMAL}\n"
  cd $DIRROOT
  cp VimSettings/vimrc.settings $HOME/.vimrc
  cp -rf VimSettings/vim $HOME/.vim
  cp VimSettings/clang-format.setting $HOME/.clang-format
  cd $HOME/.vim/bundle/
  wstool update -j8
  #cat .rosinstall | grep uri | awk '{print $2}' | while read line; do git clone --recursive $line; done; #Can use this instead of wstool
  #cd dracula-theme && git remote add upstream https://github.com/dracula/vim && cd ..
  cd YouCompleteMe
  python3 install.py --clang-completer
  # Alias csfiles to generate cscope.files
  tee -a ~/.bashrc > /dev/null <<'EOF'
  alias csfiles='find `pwd` -name "*.h" -o -name "*.c" -o -name "*.cpp" -o -name "*.cc" -o -name "*.m" -o -name "*.mm" -o -name "*.java" -o -name "*.py" > cscope.files'

  export TERM=xterm-256color
EOF
}

# Git settings
setting_git() {
  printf "${YELLOW}Setting Git.${NORMAL}\n"
  cd $DIRROOT
  cp GitSettings/.gitconfig $HOME
}

# Tmux settings
setting_tmux() {
  printf "${YELLOW}Setting Tmux.${NORMAL}\n"
  cd $DIRROOT
  cp TmuxSettings/.tmux.conf $HOME
}

#Disable system problem report when login
disable_error_report() {
  printf "{$YELLOW}Disable system problem report when login.${NORMAL}\n"
  sudo tee -a /etc/default/apport > /dev/null <<'EOF'
  # set this to 0 to disable apport, or to 1 to enable it
  # you can temporarily override this with
  # sudo service apport start force_start=1
  enabled=0
EOF
}

# Caps Ctrl swap
caps_ctrl_swap() {
  printf "${YELLOW}Making Caps as Ctrl.${NORMAL}\n"
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
}

main() {
  # Use colors, but only if connected to a terminal, and that terminal
  # supports them.
  if which tput >/dev/null 2>&1; then
      ncolors=$(tput colors)
  fi
  if [ -t 1 ] && [ -n "$ncolors" ] && [ "$ncolors" -ge 8 ]; then
    RED="$(tput setaf 1)"
    GREEN="$(tput setaf 2)"
    YELLOW="$(tput setaf 3)"
    BLUE="$(tput setaf 4)"
    BOLD="$(tput bold)"
    NORMAL="$(tput sgr0)"
  else
    RED=""
    GREEN=""
    YELLOW=""
    BLUE=""
    BOLD=""
    NORMAL=""
  fi

  # Only enable exit-on-error after the non-critical colorization stuff,
  # which may fail on systems lacking tput or terminfo
  set -e

  remove_useless
  install_libs
  install_chrome
  setting_vim
  setting_git
  setting_tmux
  disable_error_report
  caps_ctrl_swap
}

main
