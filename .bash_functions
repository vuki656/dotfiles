#!/bin/sh

################################################################################################
#------------------------------------- GIT ----------------------------------------------------#
################################################################################################

# Git Commit
gc() {
    git commit -m "$*"
}

################################################################################################
#------------------------------------- MISC ---------------------------------------------------#
################################################################################################

# Install and set provided node version
nodev() {
    nvm install "$*"
    nvm nvm use "$*"
    npm i -g yarn

    clear

    node -v
}

pulla() {
    cd ~/
    git pull

    cd ~/.config/nvim
    git pull

    cd ~/
}

################################################################################################
#------------------------------------- SYSTEM CLEAN -------------------------------------------#
################################################################################################

# Clean APT
cleana() {
    sudo apt clean -y
    sudo apt autoclean -y
    sudo apt autoremove -y

    clear
}

# Clean Brew
cleanb() {
    brew cleanup
    brew doctor

    clear
}

# Clean System
cleans() {
    cleana
    cleanb

    clear
}

################################################################################################
#------------------------------------- SYSTEM UPDATE-------------------------------------------#
################################################################################################

# Update APT
upgradea() {
    sudo apt update -y
    sudo apt upgrade -y

    clear
}

# Update Brew
upgradeb() {
    brew update 
    brew upgrade 

    clear
}

# Update Nvim
upgraden() {
    cd ~/neovim
    git pull
    sudo make
    cd ~/

    clear
}

# Update everything
upgrades() {
    # APT
    cleana
    upgradea

    # Brew
    cleanb
    upgradeb

    # Snap
    sudo snap refresh

    # Neovim
    upgraden

    # NPM
    # npm update -g

    # PIP
    # pip3 list --outdated --format=freeze | grep -v '^\-e' | cut -d = -f 1  | xargs -n1 pip3 install -U --user

    # Cargo
    # cargo install $(cargo install --list | egrep '^[a-z0-9_-]+ v[0-9.]+:$' | cut -f1 -d' ')

    cleans
}
