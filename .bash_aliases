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
alias rmd='rm -rf'
alias nv='node -v'
alias l='ll'

# Apt
alias update='sudo apt update'
alias upgrade='sudo apt upgrade'
alias pad='sudo apt install'
alias par='sudo apt remove'

# Git
alias gs='git status'
alias gcl='git clone'
alias gpl='git pull'
alias gp='git push'
alias ga='git add -f'
alias gaa='git add .'

# Tools
alias lg='lazygit'
alias ld='lazydocker'
alias n='nvim'
alias r='ranger'
alias h='htop'

# Load TMUX Setups
alias pq='tmuxp load ~/.config/.tmuxp/qia-api.yaml -y ~/.config/.tmuxp/qia-dashboard.yaml -y ' # QIA
alias po='tmuxp load ~/.config/.tmuxp/oem-dashboard.yaml -y'                                   # OEM
alias pu='tmuxp load ~/.config/.tmuxp/oem-dashboard-ui-kit.yaml -y'                            # UI Kit

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
alias ggnt='nvim ~/personal/README.md'

# CD Navigation
alias cdaw='cd ~/.config/awesome/'
alias cdnv='cd ~/.config/nvim/'
alias cdpr='cd ~/Projects'
alias cdcl='cd ~/Projects/clones'

# Screen Layouts
alias screenpm='~/.screenlayout/personal-multiple.sh'
alias screenps='~/.screenlayout/personal-single.sh'
alias screenwm='~/.screenlayout/work-multiple.sh'
alias screenws='~/.screenlayout/work-single.sh'
