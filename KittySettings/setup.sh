#########################################################################
#
#              Author: b51
#                Mail: b51live@gmail.com
#            FileName: setup.sh
#
#          Created On: Tue 08 Dec 2020 01:17:23 PM CST
#
#########################################################################

#!/bin/bash

# Install
curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin

# Create a symbolic link to add kitty to PATH (assuming ~/.local/bin is in
# your PATH)
ln -s ~/.local/kitty.app/bin/kitty ~/.local/bin/

cp *.conf ~/.config/kitty/
