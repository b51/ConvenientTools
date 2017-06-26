sudo apt install x11vnc
sudo x11vnc -storepasswd

#auto start
cp x11vnc.service to /lib/systemd/system/
sudo ufw allow 5900
sudo systemctl enable x11vnc.service
sudo systemctl daemon-reload

# set resolution
cp xorg.conf to /etc/X11/
