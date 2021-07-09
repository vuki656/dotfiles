#!/bin/sh

# Development
alias ya='yarn'
alias yd='yarn dev'

# Install Script
alias installa='bash ~/install.sh a'
alias installp='bash ~/install.sh p'
alias installl='bash ~/install.sh l'
alias installt='bash ~/install.sh t'

# Terminal
alias c='clear'
alias ..='cd ..'
alias e='exit'
alias gh='cd ~/'

# Apt
alias update='sudo apt update'
alias upgrade='sudo apt upgrade'
alias pad='sudo apt install'
alias pre='sudo apt remove'

# Git
alias gs='git status'
alias gpl='git pull'
alias gp='git push'
alias ga='git add'
alias gaa='git add .'
alias lg='lazygit'

# Tools
alias ld='lazydocker'
alias n='nvim'
alias r='ranger'

# Load Setups
alias pq='tmuxp load ~/.config/.tmuxp/qia-api.yaml -y ~/.config/.tmuxp/qia-dashboard.yaml -y '           # QIA
alias pu='tmuxp load ~/.config/.tmuxp/oem-dashboard.yaml'                                                # OEM
alias po='tmuxp load ~/.config/.tmuxp/oem-dashboard-ui-kit.yaml'                                         # UI Kit

# TMUX
alias tk='tmux kill-server'

# Navigation
alias ggtm='nvim ~/.tmux.conf'
alias ggaw='nvim ~/.config/awesome/rc.lua'
alias ggnv='nvim ~/.config/nvim/init.lua'
alias ggal='nvim ~/.config/alacritty/alacritty.yml'
alias ggis='nvim ~/install.sh'
alias ggba='nvim ~/.bash_aliases'
alias ggbf='nvim ~/.bash_functions'
alias ggrn='nvim ~/.config/ranger/rc.conf'

# CD Navigation
alias cdaw='cd ~/.config/awesome/'
alias cdnv='cd ~/.config/nvim/'

# Screen Layouts
alias screenpm='~/.screenlayout/multiple-personal.sh'
alias screenps='~/.screenlayout/single-personal.sh'
alias screenwm='~/.screenlayout/multiple-work.sh'
alias screenws='~/.screenlayout/single-work.sh'
