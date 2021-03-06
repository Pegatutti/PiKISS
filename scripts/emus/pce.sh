#!/bin/bash
#
# Description : PCE-CD emulation by Vanfanel
# Author      : Jose Cerrejon Gonzalez (ulysess@gmail_dot._com)
# Version     : 1.0 (26/Jun/14)
#
# HELP        · http://www.raspberrypi.org/forums/viewtopic.php?f=78&t=80357
#
clear

INSTALL_DIR="/home/$USER/games"
URL_FILE="https://www.dropbox.com/s/vzn3932ugh0q4rx/pce_rpi.zip"

validate_url(){
    if [[ `wget -S --spider $1 2>&1 | grep 'HTTP/1.1 200 OK'` ]]; then echo "true"; fi
}

changeInstallDir(){
    echo "Enter new full path:"
    read INSTALL_DIR
    echo "New path: $INSTALL_DIR"
}

install(){
    if [[ $(validate_url $URL_FILE) != "true" ]] ; then
        echo "Sorry, the emulator is not available here: $URL_FILE. Visit the website to download it manually."
        exit
    else
        #sudo apt-get install -y libsdl1.2debian libsdl-mixer1.2 libsdl-ttf2.0-0
        mkdir -p $INSTALL_DIR && cd $_
        wget -qO- -O tmp.zip $URL_FILE && unzip tmp.zip && rm tmp.zip
        cd pce/
        wget 'http://aetherbyte.com/files/Aetherbyte_Reflectron.zip'
        echo "Done!. To play, go to install path and type: ./pce Aetherbyte_Reflectron.zip"
    fi
    read -p "Press [Enter] to continue..."
    exit
}

echo -e "PCE-CD emulation by Vanfanel\n============================\n\n· More Info: http://www.raspberrypi.org/forums/viewtopic.php?f=78&t=80357\n· + Game Reflectron by Aetherbyte\n· Works with compressed roms (.zip)\n\nInstall path: $INSTALL_DIR/pce"
while true; do
    echo " "
    read -p "Is it right? [y/n] " yn
    case $yn in
    [Yy]* ) echo "Installing, please wait..." && install;;
    [Nn]* ) changeInstallDir;;
    [Ee]* ) exit;;
    * ) echo "Please answer (y)es, (n)o or (e)xit.";;
    esac
done
