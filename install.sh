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
    npm i -g eslint_d
}  

install_brew_packages() {
    brew install jesseduffield/lazygit/lazygit
    brew install jesseduffield/lazydocker/lazydocker
    brew install tmuxp
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
    sudo apt install playerctl       # CLI Audio controller

    sudo apt install ranger          # Terminal file manager

    # Ranger image preview
    sudo apt install libjpeg8-dev zlib1g-dev python-dev python3-dev libxtst-dev
    pip install ueberzug 
}

install_docker() {
    sudo apt-get update
    sudo apt-get install apt-transport-https ca-certificates curl gnupg lsb-release
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
    echo \
        "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
        $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

    sudo apt-get update
    sudo apt-get install docker-ce docker-ce-cli containerd.io
}

install_dev_tools() {

    # Snaps
    sudo snap install postman
    sudo snap install code
    sudo snap install discord

    # APTs
    sudo apt install alacritty

    install_docker
}

install_media_tools() {
    sudo apt install vlc
}

install_lock() {
    sudo apt install pkg-config
    sudo apt install libxcb
    sudo apt install libxcb-util
    sudo apt install libpam-dev
    sudo apt install libcairo-dev
    sudo apt install libxcb-xinerama
    sudo apt install libxcb-randr
    sudo apt install libev
    sudo apt install libx11-dev
    sudo apt install libx11-xcb-dev
    sudo apt install libxkbcommon 
    sudo apt install libxkbcommon-x11 
    sudo apt install libxcb-image
    sudo apt install libxcb-xrm

    sudo apt install i3lock
}

##############################################################
#------------------------ INSTALL ---------------------------#
##############################################################

install_prerequisites

install_awesome
install_lock
install_node
install_npm_packages
install_brew_packages
install_rust
install_python
install_golang
install_dev_tools
install_media_tools
install_other

