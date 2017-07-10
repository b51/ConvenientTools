# X11 VNC Configuration
	sudo apt install x11vnc
	sudo x11vnc -storepasswd

## Auto start
	cp x11vnc.service /lib/systemd/system/
	sudo ufw allow 5900
	sudo systemctl enable x11vnc.service
	sudo systemctl daemon-reload

## Set resolution
	cp xorg.conf to /etc/X11/
