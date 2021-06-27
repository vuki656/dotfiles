#!/bin/sh

##############################################################
#------------------------ SETUP -----------------------------#
##############################################################

install_prerequisites() {
    # PPA Management
    sudo apt install software-properties-common

    sudo apt install curl
    sudo apt install wget
    sudo apt install awesome
}

install_golang() {
    sudo add-apt-repository ppa:longsleep/golang-backports

    sudo apt update

    sudo apt install golang-go
}

install_python() {
    sudo add-apt-repository ppa:deadsnakes/ppa

    sudo apt update

    sudo apt install python3
    sudo apt install python3-pip
}

install_node() {
    # Instasll NVM
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh | bash
    . ~/.nvm/nvm.sh

    nvm install 14.17
    nvm use 14.17
}

install_rust() {
    curl https://sh.rustup.rs -sSf | sh -y
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

install_prerequisites

install_node
install_npm_packages
install_rust
install_python
install_golang
instasll_dev_tools
instasll_media_tools

