#########################################################################
#
#              Author: b51
#                Mail: b51live@gmail.com
#            FileName: get_frame.sh
#
#          Created On: Thu Jun 20 21:21:38 2019
#
#########################################################################

#!/bin/bash

#for i in *.mp4; do
#  count=${i%%.*} # get filename before dot
#  new=$(printf "%06d.mp4" "$count") # expand count with zero
#  mv -i -- "$i" "$new"
#done
for i in *.mp4; do
  count=${i%%.*} # get filename before dot
  mkdir image_${count}
  ffmpeg -i ${count}.mp4 -vf fps=1 image_${count}/%06d.png
done
