#!/bin/sh

# Check if given command can be executed
no_cmd() {
    if ! [ -x "$(command -v "$1")" ]; then
        return 0
    fi

    return 1
}

################################################################################################
#-------------------------------------- PACKAGES ----------------------------------------------#
################################################################################################

install_npm_packages() {
    npm i -g yarn -y                              # Node package manager
    npm i -g eslint_d -y                          # JS Linter/Formatter
    npm i -g prettier -y                          # JS Linter/Formatter
    npm i -g markdownlint -y                      # Markdown linter
    npm i -g markdownlint-cli -y                  # Markdown cli
    npm i -g write-good -y                        # Sentence structure checker
    npm i -g fixjson -y                           # JSON Formatter
    npm i -g bash-language-server -y              # Bash LS
    npm i -g diagnostic-languageserver -y         # Diagnostics LS
    npm i -g dockerfile-language-server-nodejs -y # Docker LS
    npm i -g graphql-language-service-cli -y      # Graphql LS
    npm i -g vscode-langservers-extracted -y      # CSS, HTML & JSON LS
    npm i -g typescript-language-server -y        # Typescript LS
    npm i -g @prisma/language-server -y           # Prisma LS
    npm i -g yaml-language-server -y              # YAML LS
    npm i -g npm                                  # Node package manager
}

install_brew_packages() {
    brew install jesseduffield/lazygit/lazygit       # Git terminal UI
    brew install jesseduffield/lazydocker/lazydocker # Docker terminal UI
    brew install tmuxp                               # Tmux sesion manager
    brew install hadolint                            # Dockerfile linter
    brew install fzf                                 # Terminal finder
    brew install bat                                 # Terminal preview
    brew install cocoapods                           # iOS Package manager
    brew install diff-so-fancy                       # Git diff view
}

install_snap_packages() {
    sudo snap install postman        # API Testing tool
    sudo snap install code --classic # VS Code
    sudo snap install discord        # Discord
    sudo snap install shfmt          # Bash formatter
}

install_rust_packages() {
    cargo install stylua # Lua formatter/linter
}

install_apt_packages() {
    # Required PPAs
    sudo add-apt-repository ppa:apandada1/brightness-controller
    sudo apt update

    # Random prereqs
    sudo apt install build-essential -y
    sudo apt install software-properties-common -y
    sudo apt install libssl-dev -y

    sudo apt install curl -y               # Fetcher
    sudo apt install wget -y               # Fetcher
    sudo apt install alacritty -y          # Terminal
    sudo apt install rofi -y               # App launcher
    sudo apt install pavucontrol -y        # Audio controller
    sudo apt install playerctl -y          # CLI audio controller
    sudo apt install vlc -y                # Video player
    sudo apt install i3lock -y             # Lock screen
    sudo apt install vim -y                # Text editor
    sudo apt install arandr -y             # XRandR GUI (Window Setup)
    sudo apt install taskwarrior -y        # Terminal task manager
    sudo apt install shellcheck -y         # Shell linter
    sudo apt install htop -y               # Resource usage viewer
    sudo apt install brightness-controller # Brightness controller
    sudo apt install peek -y               # GIF Recorder
    sudo apt install ripgrep -y            # Fuzzy Finder
    sudo apt install tmux -y               # Terminal multiplexer
    sudo apt install imagemagick -y        # Image manipulator
    sudo apt install scrot -y              # Terminal screenshot tool
}

install_luarocks_packages() {
    luarocks install vusted # Lua testing wrapper
}

install_python_packages() {
    pip install codespell # Spellchecker
}

install_packages() {
    install_npm_packages
    install_brew_packages
    install_snap_packages
    install_rust_packages
    install_apt_packages
    install_python_packages
    install_luarocks_packages

    echo '================= PACKAGES INSTALLED ================='
}

################################################################################################
#-------------------------------------- LANGUAGES ---------------------------------------------#
################################################################################################

install_golang() {
    if no_cmd 'go'; then
        sudo add-apt-repository ppa:longsleep/golang-backports -y

        sudo apt update -y

        sudo apt install golang-go -y
    fi
}

install_python() {
    if no_cmd 'python3'; then
        sudo add-apt-repository ppa:deadsnakes/ppa -y

        sudo apt update -y

        sudo apt install python3 -y
        sudo apt install python3-pip -y
    fi
}

install_node() {
    if no_cmd 'node'; then
        curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh | bash -y
        . ~/.nvm/nvm.sh

        nvm install 14.17.6 -y
        nvm use 14.17.6-y
        nvm alias default 14.17.6
    fi
}

install_rust() {
    if no_cmd 'rustup'; then
        curl https://sh.rustup.rs -sSf | sh -s
    fi
}

install_lua() {
    if no_cmd 'lua'; then
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
    fi
}

install_teal() {
    if no_cmd 'tl'; then
        luarocks install --dev teal-language-server
    fi
}

install_java() {
    if no_cmd 'java'; then
        sudo apt install default-jre
    fi
}

install_languages() {
    install_golang
    install_python
    install_node
    install_rust
    install_java
    install_lua
    install_teal

    echo '================= LANGUAGES INSTALLED ================='
}

################################################################################################
#-------------------------------------- TOOLS -------------------------------------------------#
################################################################################################

install_docker() {
    if no_cmd 'docker'; then
        sudo apt-get update -y
        sudo apt-get install apt-transport-https ca-certificates curl gnupg lsb-release
        curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg -y
        echo \
            "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
        $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list >/dev/null

        sudo apt-get update -y
        sudo apt-get install docker-ce docker-ce-cli containerd.io -y
    fi
}

install_nvim() {
    if no_cmd 'nvim'; then
        sudo apt install ninja-build gettext libtool libtool-bin autoconf automake cmake g++ pkg-config unzip -y

        cd ~/ || return
        git clone https://github.com/neovim/neovim
        cd neovim && make -j4
        sudo make install
    fi
}

install_awesome() {
    if no_cmd 'awesome'; then
        sudo apt install awesome -y
        touch ~/.config/awesome/env_vars.lua

        # Install awesome plugins
        git clone https://github.com/streetturtle/awesome-wm-widgets ~/.config/awesome

        # Install json parser
        wget -P ~/.config/awesome/ https://raw.githubusercontent.com/rxi/json.lua/master/json.lua

        # Remove duplicate json parser
        rm ~/.config/awesome/json.lua.1
    fi
}

install_homebrew() {
    if no_cmd 'brew'; then
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    fi
}

install_ranger() {
    if no_cmd 'ranger'; then
        sudo apt install ranger -y

        # Ranger image preview
        sudo apt install libjpeg8-dev zlib1g-dev python-dev python3-dev libxtst-dev -y
        pip install ueberzug
    fi
}

install_tools() {
    install_docker
    install_nvim
    install_awesome
    install_homebrew
    install_ranger

    echo '================= TOOLS INSTALLED ================='
}

################################################################################################
#-------------------------------------- INSTALL OPTIONS ---------------------------------------#
################################################################################################

# Install everything
if [ "$1" = 'a' ]; then
    install_packages
    install_tools
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
