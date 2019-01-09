# !/bin/sh
ps -ef | grep "roslaunch" | awk '{print $2}' | xargs kill -9
