#!/usr/bin/env bash

# author: Gessé Carneiro Silva (dev.gessecarneiro@gmail.com)
#
#How to use?
#   $ chmod +x pos_install.sh
#   $ ./pos_install.sh

# ---------- VARIABLES ---------- #
set -e


##URLS

URL_GOOGLE_CHROME="https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb"
URL_VS_CODE="https://code.visualstudio.com/sha/download?build=stable&os=linux-deb-x64"
URL_DISCORD="https://discord.com/api/download?platform=linux&format=deb"

DOWNLOAD_DIRECTORY="$HOME/Downloads/apps"

#Colors
RED='\e[1;91m'
GREEN='\e[1;92m'
NO_COLOR='\e[0m'

#Functions

# -------------------------------TESTS AND REQUIREMENTS----------------------------------------- #

#Updating repository and updating the system
apt_update(){
  sudo apt update && sudo apt dist-upgrade -y
}

# Internet working?
internet_tests(){
if ! ping -c 1 8.8.8.8 -q &> /dev/null; then
  echo -e "${RED}[ERROR] - Your computer does not have an Internet connection. check the network.${NO_COLOR}"
  exit 1
else
  echo -e "${GREEN}[INFO] - Internet connection working normally.${NO_COLOR}"
fi
}

# Presentation function
print_ascii_art(){
    echo '
        _       __          __                                    __
    | |     / /  ___    / /  _____  ____    ____ ___   ___    / /
    | | /| / /  / _ \  / /  / ___/ / __ \  / __ `__ \ / _ \  / / 
    | |/ |/ /  /  __/ / /  / /__  / /_/ / / / / / / //  __/ /_/  
    |__/|__/   \___/ /_/   \___/  \____/ /_/ /_/ /_/ \___/ (_)   
                                                             
    '
}

## Updating the repository
just_apt_update(){
    sudo apt update -y
}

##DEB SOFTWARES TO INSTALL

APPS_TO_INSTALL=(
    build-essential
    audacity
    piper
    neofetch
    guvcview
    vlc
    qbittorrent
    spotify-client
    zsh
    vim
    ffmpeg
    tilix
    git
    wget
    gparted

)

install_debs(){
    echo -e "${GREEN}[INFO] - Downloading packages .deb${NO_COLOR}"

mkdir "$DOWNLOAD_DIRECTORY"
wget -c "$URL_VS_CODE"       -P "$DOWNLOAD_DIRECTORY"
wget -c "$URL_VS_CODE"       -P "$DOWNLOAD_DIRECTORY"

## Installing the .dev packages downloaded in the previous session
sudo dpkg -i $DOWNLOAD_DIRECTORY/*.deb

# Installing programs in the apt
echo -e "${GREEN}[INFO] - Installing apt packages from the repository${NO_COLOR}"

# Installing app in the apt 
for program_name in ${APPS_TO_INSTALL[@]}; do
  if ! dpkg -l | grep -q $program_name; then # Only install if not already installed
    apt install "$program_name" -y
  else
    echo "[INSTALLED] - $program_name"
  fi
done

}

## Installing flatpak packages ##
install_flatpaks(){

  echo -e "${GREEN}[INFO] - Installing flatpak packages${NO_COLOR}"

flatpak install flathub com.obsproject.Studio -y
flatpak install flathub com.spotify.Client -y
flatpak install flathub org.telegram.desktop -y
flatpak install flathub org.freedesktop.Piper -y
flatpak install flathub org.gnome.Boxes -y
flatpak install flathub org.qbittorrent.qBittorrent -y
}


# ----------------------------- POST INSTALL ----------------------------- #
## Finishing, updating and cleaning##
system_clean(){
sudo apt update && sudo apt dist-upgrade -y
flatpak update
sudo apt autoclean
sudo apt autoremove -y
}

# ---------------------------------------------------------------------- #

# ---------------------- Execution ----------------------

print_ascii_art
internet_tests
just_apt_update
install_debs
install_flatpaks
apt_update
system_clean


#Finishing
echo -e "${GREEN}[INFO] - Script finished, install complete!! :)${NO_COLOR}"