#!/usr/bin/env bash

# author: Gessé Carneiro Silva (dev.gessecarneiro@gmail.com)
#
#How to use?
#   $ chmod +x pos_install.sh
#   $ ./pos_install.sh

# ---------- VARIABLES ---------- #
set -e


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
    neofetch
    guvcview
    whois
    gnome-tweaks
    vlc
    qbittorrent
    zsh
    vim
    ffmpeg
    tilix
    git
    wget
    gparted

)

install_debs(){


## installing .deb packages downloaded in the previous session ##
echo -e "${VERDE}[INFO] - Installing downloaded .deb packages${NO_COLOR}"
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
}


# ----------------------------- POST INSTALL ----------------------------- #
## Finishing, updating and cleaning##
system_clean(){
sudo apt update && sudo apt dist-upgrade -y
flatpak update -y
sudo apt autoclean
sudo apt autoremove -y
}

# ---------------------------------------------------------------------- #

# ---------------------- Execution ----------------------

print_ascii_art
internet_tests
just_apt_update
install_debs
apt_update
system_clean


#Finishing
echo -e "${GREEN}[INFO] - Script finished, install complete!! :)${NO_COLOR}"