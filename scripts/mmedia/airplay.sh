#!/bin/bash
#
# Description : Install rPlay, Airplay mirroring (Need license key)
# Author      : Jose Cerrejon Gonzalez (ulysess@gmail_dot._com)
# Version     : 1.1 (11/Jun/14)
#
# IMPROVEMENT : http://www.welzels.de/blog/projekte/raspberry-pi/raspberry-pi-als-airplay-client/ <-- AirPlay (sound)
#
clear

# trap CTRL+C in the rplay installation
int_trap() {
    echo "Ctrl-C pressed"
}
trap int_trap INT

rplay_install(){
    sudo apt-get install -y libao-dev avahi-utils libavahi-compat-libdnssd-dev libva-dev youtube-dl
    sudo youtube-dl --update
    wget -O /tmp/rplay.deb http://www.vmlite.com/rplay/rplay-1.0.1-armhf.deb
    sudo dpkg -i /tmp/rplay.deb
    rm /tmp/rplay.deb
    echo "Enter your license key:"
    read LICENSE_KEY
    echo 'license_key='$LICENSE_KEY | sudo tee -a /etc/rplay.conf
    sudo /etc/init.d/rplay restart
    echo -e  "\nDone!. To {stop,start,restart} service: sudo /etc/init.d/rplay {stop,start,restart}.\nTo uninstall: sudo dpkg -r rplay"
    read -p "Press [ENTER] to continue..."
}

  dialog --backtitle "piKiss" \
         --title     "[ Install rPlay, Airplay mirroring ]" \
         --yes-label "Yes" \
         --no-label  "No" \
         --yesno     "You need a license key. Do you want to continue?" 7 55

  retval=$?

  case $retval in
    0)   echo -e "Installing...\nRemember you have an admin panel visiting: http://localhost:7100/admin (user admin, psswd admin)" ; rplay_install ;;
    1)   echo "Get your license key from http://www.vmlite.com/index.php?option=com_kunena&Itemid=158&func=view&catid=23&id=12117" ; exit ;;
  esac

