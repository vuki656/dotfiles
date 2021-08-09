#!/bin/sh

################################################################################################
#-------------------------------------- PACKAGES ----------------------------------------------#
################################################################################################

install_npm_packages() {
    npm i -g yarn -y && yarn --emoji true # Node package manager
    npm i -g eslint_d -y                  # JS Linter/Formatter
    npm i -g prettier -y                  # JS Linter/Formatter
    npm i -g markdownlint                 # Markdown linter
    npm i -g markdownlint-cli             # Markdown cli
}

install_brew_packages() {
    brew install jesseduffield/lazygit/lazygit       # Git terminal UI
    brew install jesseduffield/lazydocker/lazydocker # Docker terminal UI
    brew install tmuxp                               # Tmux sesion manager
    brew install hadolint                            # Dockerfile linter
}

install_snap_packages() {
    sudo snap install postman        # API Testing tool
    sudo snap install code --classic # VS Code
    sudo snap install discord        # Discord
    sudo snap install shfmt          # Bash formatter
}

install_rust_packages() {
    cargo install stylua # Lua formatter/linter
    cargo install selene # Lua linter
}

install_apt_packages() {
    # Random prereqs
    sudo apt install build-essential -y
    sudo apt install software-properties-common -y
    sudo apt install libssl-dev -y

    sudo apt install curl -y        # Fetcher
    sudo apt install wget -y        # Fetcher
    sudo apt install alacritty -y   # Terminal
    sudo apt install rofi -y        # App launcher
    sudo apt install pavucontrol -y # Audio controller
    sudo apt install playerctl -y   # CLI Audio controller
    sudo apt install vlc -y         # Video player
    sudo apt install i3lock -y      # Lock screen
    sudo apt install vim            # Text editor
    sudo apt install arandr         # XRandR GUI (Window Setup)
    sudo apt install taskwarrior    # Terminal task manager
    sudo apt install shellcheck     # Shell linter
    sudo apt install htop           # Resource usage viewer
}

install_packages() {
    install_npm_packages
    install_brew_packages
    install_snap_packages
    install_rust_packages
    install_apt_packages

    clear
    echo '================= PACKAGES INSTALLED ================='
}

################################################################################################
#-------------------------------------- LANGUAGES ---------------------------------------------#
################################################################################################

install_golang() {
    sudo add-apt-repository ppa:longsleep/golang-backports -y

    sudo apt update -y

    sudo apt install golang-go -y
}

install_python() {
    sudo add-apt-repository ppa:deadsnakes/ppa -y

    sudo apt update -y

    sudo apt install python3 -y
    sudo apt install python3-pip -y
}

install_node() {
    # Install NVM
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh | bash -y
    . ~/.nvm/nvm.sh

    nvm install 14.17 -y
    nvm use 14.17 -y
}

install_rust() {
    curl https://sh.rustup.rs -sSf | sh -s
}

install_lua() {
    sudo apt install ninja-build -y

    # Clone lua
    git clone https://github.com/sumneko/lua-language-server
    cd lua-language-server || return
    git submodule update --init --recursive

    # Install lua
    cd 3rd/luamake || return
    compile/install.sh
    cd ../..
    ./3rd/luamake/luamake rebuild
    cd ~ || return

    # Install luarocks
    sudo apt install liblua5.3-dev
    sudo apt install lua5.3
    wget https://luarocks.org/releases/luarocks-3.7.0.tar.gz
    tar zxpf luarocks-3.7.0.tar.gz
    cd luarocks-3.7.0 || return
    ./configure && make && sudo make install
    sudo luarocks install luasocket
    cd ~ || return
    rm ~/luarocks-3.7.0.tar.gz
}

install_java() {
    sudo apt install default-jre
}

install_languages() {
    install_golang
    install_python
    install_node
    install_rust
    install_java
    install_lua

    clear
    echo '================= LANGUAGES INSTALLED ================='
}

################################################################################################
#-------------------------------------- TOOLS -------------------------------------------------#
################################################################################################

install_docker() {
    sudo apt-get update -y
    sudo apt-get install apt-transport-https ca-certificates curl gnupg lsb-release
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg -y
    echo \
        "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
        $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list >/dev/null

    sudo apt-get update -y
    sudo apt-get install docker-ce docker-ce-cli containerd.io -y
}

install_awesome() {
    sudo apt install awesome -y
    touch ~/.config/awesome/env_vars.lua

    # Install awesome plugins
    git clone https://github.com/streetturtle/awesome-wm-widgets ~/.config/awesome

    # Install json parser
    wget -P ~/.config/awesome/ https://raw.githubusercontent.com/rxi/json.lua/master/json.lua

    # Remove duplicate json parser
    rm ~/.config/awesome/json.lua.1
}

install_homebrew() {
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
}

install_ranger() {
    sudo apt install ranger -y

    # Ranger image preview
    sudo apt install libjpeg8-dev zlib1g-dev python-dev python3-dev libxtst-dev -y
    pip install ueberzug
}

install_tools() {
    install_docker
    install_awesome
    install_homebrew
    install_ranger

    clear
    echo '================= TOOLS INSTALLED ================='
}

################################################################################################
#-------------------------------------- INSTALL OPTIONS ---------------------------------------#
################################################################################################

# Install everything
if [ "$1" = 'a' ]; then
    install_tools
    install_packages
    install_languages
fi

# Install only tools
if [ "$1" = 't' ]; then
    install_tools
fi

# Install only packages
if [ "$1" = 'p' ]; then
    install_packages
fi

# Install only languages
if [ "$1" = 'l' ]; then
    install_languages
fi
