#!/bin/sh

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

# TMUX
alias tk='tmux kill-session'

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
alias screenmp='~/.screenlayout/multiple-personal.sh'
alias screenmw='~/.screenlayout/multiple-work.sh'
alias screensp='~/.screenlayout/single-personal.sh'
alias screensw='~/.screenlayout/single-work.sh'
