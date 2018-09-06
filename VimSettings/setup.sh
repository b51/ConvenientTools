#########################################################################
#
#              Author: b51
#                Mail: b51live@gmail.com
#            FileName: setup.sh
#
#          Created On: Thu 06 Sep 2018 08:46:10 PM CST
#
#########################################################################

#!/bin/bash

cp -rf .vim* ~/
cd ~/.vim/bundle/
cat .rosinstall | grep uri | awk '{print $2}' | while read line; do git clone --recursive $line; done;
cd YouCompleteMe
python3 install.py --clang-completer
