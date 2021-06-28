#!/bin/sh

## Git Commit
gc() {
  git commit -m "$*"
}

# Upgrade everything
upgradea() {
    # APT
    sudo apt update
    sudo apt upgrade
    sudo apt clean
    sudo apt autoclean
    sudo apt autoremove

    # Brew
    brew update 
    brew upgrade 
    brew cleanup 
    brew doctor

    # Snap
    sudo snap refresh 

    # NPM
    # npm update -g

    # PIP
    # pip3 list --outdated --format=freeze | grep -v '^\-e' | cut -d = -f 1  | xargs -n1 pip3 install -U --user

    # Cargo
    # cargo install $(cargo install --list | egrep '^[a-z0-9_-]+ v[0-9.]+:$' | cut -f1 -d' ')

    clear
}
