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

# Make a new named tmux session
tn() {
    tmux new -s "$*" -d
    tmux switch-client -t "$*" 
    tmux kill-session -t HOME
}

# Install and set provided node version
nodev() {
    nvm install "$*"
    nvm nvm use "$*"

    # Install yarn if not installed
    if ! [ -x "$(command -v "yarn")" ]; then
        npm i -g yarn -y
    fi

    clear

    node -v
}

# Pull dots and neovim config
pulla() {
    cd ~/ || return
    git pull

    cd ~/.config/nvim || return
    git pull

    cd ~/ || return
}

# Search for files in terminal
f() {
    result=$(fzf --preview 'bat --style=numbers --color=always --line-range :500 {}') || return

    nvim "$result"
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
    cd ~/neovim || return

    git pull

    sudo make

    cd ~/ || return
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
    cargo install "$(cargo install --list | grep -E '^[a-z0-9_-]+ v[0-9.]+:$' | cut -f1 -d' ')"

    # NPM
    # npm update -g

    # NVIM Deps
    ~/.config/nvim/install.sh l
    sudo ~/.config/nvim/install.sh l

    # PIP
    # pip3 list --outdated --format=freeze | grep -v '^\-e' | cut -d = -f 1  | xargs -n1 pip3 install -U --user

    cleans
}
