#!/bin/sh

################################################################################################
#------------------------------------- GIT ----------------------------------------------------#
################################################################################################ 

# Git Commit
gc() {
  git commit -m "$*"
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
    brew cleanup -y
    brew doctor -y

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
    sudo apt update -y
    sudo apt upgrade -y

    clear
}

# Update everything
upgrades() {
    # APT
    cleana
    updatea

    # Brew
    cleanb
    updateb

    # Snap
    sudo snap refresh 

    # NPM
    # npm update -g

    # PIP
    # pip3 list --outdated --format=freeze | grep -v '^\-e' | cut -d = -f 1  | xargs -n1 pip3 install -U --user

    # Cargo
    # cargo install $(cargo install --list | egrep '^[a-z0-9_-]+ v[0-9.]+:$' | cut -f1 -d' ')

    cleans
}
