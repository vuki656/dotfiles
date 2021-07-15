#!/bin/sh

# Development
alias ya='yarn'
alias yd='yarn dev'
alias yc='yarn codegen'

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
alias rmd='rm -rf'

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

# Tools
alias lg='lazygit'
alias ld='lazydocker'
alias n='nvim'
alias r='ranger'

# Load TMUX Setups
alias pq='tmuxp load ~/.config/.tmuxp/qia-api.yaml -y ~/.config/.tmuxp/qia-dashboard.yaml -y '           # QIA
alias po='tmuxp load ~/.config/.tmuxp/oem-dashboard.yaml'                                                # OEM
alias pu='tmuxp load ~/.config/.tmuxp/oem-dashboard-ui-kit.yaml'                                         # UI Kit

# TMUX
alias tk='tmux kill-server'

# Config File Navigation
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
alias screenpm='~/.screenlayout/personal-multiple.sh'
alias screenps='~/.screenlayout/personal-single.sh'
alias screenwm='~/.screenlayout/work-multiple.sh'
alias screenws='~/.screenlayout/work-single.sh'
