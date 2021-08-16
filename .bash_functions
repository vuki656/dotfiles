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
}

# Clean Brew
cleanb() {
    brew cleanup
    brew doctor
}

# Clean System
cleans() {
    cleana
    cleanb
}

################################################################################################
#------------------------------------- SYSTEM UPDATE-------------------------------------------#
################################################################################################

# Update APT
upgradea() {
    sudo apt update -y
    sudo apt upgrade -y
}

# Update Brew
upgradeb() {
    brew update
    brew upgrade
}

# Update Nvim
upgraden() {
    cd ~/neovim
    git pull
    sudo make
    cd ~/
}

# Update everything
upgrades() {
    # APT
    upgradea

    # Brew
    upgradeb

    # Snap
    sudo snap refresh

    # Neovim
    upgraden

    # Cargo
    cargo install $(cargo install --list | egrep '^[a-z0-9_-]+ v[0-9.]+:$' | cut -f1 -d' ')

    # NPM
    # npm update -g

    # PIP
    # pip3 list --outdated --format=freeze | grep -v '^\-e' | cut -d = -f 1  | xargs -n1 pip3 install -U --user

    cleans
}
