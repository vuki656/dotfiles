#!/bin/sh

##############################################################
#------------------------ SETUP -----------------------------#
##############################################################

install_prerequisites() {
    # PPA Management
    sudo apt install software-properties-common

    # Homebrew
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

    sudo apt install curl
    sudo apt install wget
    sudo apt install build-essential
}

install_awesome() {
    sudo apt install awesome

    git clone https://github.com/streetturtle/awesome-wm-widgets ~/.config/awesome
    wget -P ~/.config/awesome/ https://raw.githubusercontent.com/rxi/json.lua/master/json.lua
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

install_brew_packages() {
    brew install jesseduffield/lazygit/lazygit
    brew install jesseduffield/lazydocker/lazydocker
}

install_lua() {
    sudo apt install ninja-build

    # Clone lua
    git clone https://github.com/sumneko/lua-language-server
    cd lua-language-server
    git submodule update --init --recursive

    # Install lua
    cd 3rd/luamake
    compile/install.sh
    cd ../..
    ./3rd/luamake/luamake rebuild

    cd ~

    # Install luarocks
    wget https://luarocks.org/releases/luarocks-3.7.0.tar.gz
    tar zxpf luarocks-3.7.0.tar.gz
    cd luarocks-3.7.0
    ./configure && make && sudo make install
    sudo luarocks install luasocket

    cd ~
}

install_other() {
    sudo apt install rofi            # App launcher
    sudo apt install pavucontrol     # Audio controller
}

install_dev_tools() {

    # Snaps
    sudo snap install postman
    sudo snap install code

    # APTs
    sudo apt install alacritty

    # Chrome
    wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
    sudo dpkg -i google-chrome-stable_current_amd64.deb

    rm -rf ~/google-chrome-stable_current_amd64.deb
    
}

install_media_tools() {
    sudo apt install vlc
}

##############################################################
#------------------------ INSTALL ---------------------------#
##############################################################

install_prerequisites

install_awesome
install_node
install_npm_packages
install_brew_packages
install_rust
install_python
install_golang
install_dev_tools
install_media_tools
install_other

