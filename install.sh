#!/bin/sh

##############################################################
#------------------------ SETUP -----------------------------#
##############################################################

install_node() {
    # Instasll NVM
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh | bash
    . ~/.nvm/nvm.sh

    nvm install 14.17
    nvm use 14.17
}

install_npm_packages() {
    npm i -g yarn
}

instasll_dev_tools() {

    # Snaps
    sudo snap install postman

    # APTs
    sudo apt install alacritty
    sudo apt install lazygit
    sudo apt install code

    # Chrome
    wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
    sudo dpkg -i google-chrome-stable_current_amd64.deb
    
}

instasll_media_tools() {
    sudo apt install vlc
}

##############################################################
#------------------------ INSTALL ---------------------------#
##############################################################

sudo apt install curl
sudo apt install wget
sudo apt install awesome

install_node
install_npm_packages
instasll_dev_tools
instasll_media_tools

