#########################################################################
#
#              Author: b51
#                Mail: b51live@gmail.com
#            FileName: setup.sh
#
#          Created On: Sat 01 Jun 2019 12:35:38 PM CST
#
#########################################################################

#!/bin/bash

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

  if ! command -v zsh >/dev/null 2>&1; then
    printf "${YELLOW}Zsh is not installed! Now will install zsh first!${NORMAL}\n"
    sudo apt install zsh -y
  fi

  if [ ! -n "$ZSH" ]; then
    ZSH=~/.oh-my-zsh
  fi

  if [ -d "$ZSH" ]; then
    printf "${YELLOW}You already have Oh My Zsh installed.${NORMAL}\n"
    printf "You'll need to remove $ZSH if you want to re-install.\n"
    exit
  fi

  # Prevent the cloned repository from having insecure permissions. Failing to do
  # so causes compinit() calls to fail with "command not found: compdef" errors
  # for users with insecure umasks (e.g., "002", allowing group writability). Note
  # that this will be ignored under Cygwin by default, as Windows ACLs take
  # precedence over umasks except for filesystems mounted with option "noacl".
  umask g-w,o-w

  printf "${BLUE}Cloning Oh My Zsh...${NORMAL}\n"
  command -v git >/dev/null 2>&1 || {
    echo "Error: git is not installed"
    exit 1
  }
  # The Windows (MSYS) Git is not compatible with normal use on cygwin
  if [ "$OSTYPE" = cygwin ]; then
    if git --version | grep msysgit > /dev/null; then
      echo "Error: Windows/MSYS Git is not supported on Cygwin"
      echo "Error: Make sure the Cygwin git package is installed and is first on the path"
      exit 1
    fi
  fi
  env git clone --depth=1 https://github.com/robbyrussell/oh-my-zsh.git "$ZSH" || {
    printf "Error: git clone of oh-my-zsh repo failed\n"
    exit 1
  }

  printf "${BLUE}Looking for an existing zsh config...${NORMAL}\n"
  if [ -f ~/.zshrc ] || [ -h ~/.zshrc ]; then
    printf "${YELLOW}Found ~/.zshrc.${NORMAL} ${GREEN}Backing up to ~/.zshrc.pre-oh-my-zsh${NORMAL}\n";
    mv ~/.zshrc ~/.zshrc.pre-oh-my-zsh;
  fi

  printf "${BLUE}Using b51's Zsh file and adding it to ~/.zshrc${NORMAL}\n"
  cp zshrc.settings ~/.zshrc

  printf "${BLUE}Using fixed sunrizsh theme as default theme and add to git${NORMAL}\n"
  cp sunrise.zsh-theme "$ZSH"/themes/
  cd $ZSH && git add $ZSH/themes/sunrise.zsh-theme && git commit -m "Fixed sunrise theme" && cd -

  printf "${BLUE}Installing thefuck & autojump${NORMAL}\n"
  if ! command -v pip3 > /dev/null 2>&1; then
    printf "${YELLOW}pip3 is not installed!${NORMAL} Now will install pip3!\n"
    sudo apt install python3-dev python3-pip python3-setuptools -y
  fi
  sudo pip3 install -i https://mirrors.aliyun.com/pypi/simple/ thefuck
  sudo apt install autojump

  printf "${BLUE}Installing zsh-iterm-touchbar${NORMAL}\n"
  env git clone https://github.com/robbyrussell/oh-my-zsh.git "${ZSH_CUSTOM1:-$ZSH/custom}/plugins" || {
    printf "Error: git clone of zsh-iterm-touchbar repo failed\n"
    exit 1
  }

  #env git clone https://github.com/wting/autojump || {
  #  printf "Error: git clone of autojump repo failed\n"
  #  exit 1
  #}
  #cd autojump && python3 install.py && cd - && rm -rf autojump

  # If this user's login shell is not already "zsh", attempt to switch.
  TEST_CURRENT_SHELL=$(basename "$SHELL")
  if [ "$TEST_CURRENT_SHELL" != "zsh" ]; then
    # If this platform provides a "chsh" command (not Cygwin), do it, man!
    if hash chsh >/dev/null 2>&1; then
      printf "${BLUE}Time to change your default shell to zsh!${NORMAL}\n"
      chsh -s $(grep /zsh$ /etc/shells | tail -1)
    # Else, suggest the user do so manually.
    else
      printf "I can't change your shell automatically because this system does not have chsh.\n"
      printf "${BLUE}Please manually change your default shell to zsh!${NORMAL}\n"
    fi
  fi

  printf "${GREEN}"
  echo '         __                                     __   '
  echo '  ____  / /_     ____ ___  __  __   ____  _____/ /_  '
  echo ' / __ \/ __ \   / __ `__ \/ / / /  /_  / / ___/ __ \ '
  echo '/ /_/ / / / /  / / / / / / /_/ /    / /_(__  ) / / / '
  echo '\____/_/ /_/  /_/ /_/ /_/\__, /    /___/____/_/ /_/  '
  echo '                        /____/                       with b51`s configs ....is now installed!'
  echo ''
  echo ''
  echo 'Please look over the ~/.zshrc file to select plugins, themes, and options.'
  echo ''
  echo 'p.s. Follow us at https://twitter.com/ohmyzsh'
  echo ''
  echo 'p.p.s. Get stickers, shirts, and coffee mugs at https://shop.planetargon.com/collections/oh-my-zsh'
  echo ''
  printf "${NORMAL}"
  env zsh -l
}

main
