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
alias t='touch'

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
alias gaa='git add . -f'

# Tools
alias lg='lazygit'
alias ld='lazydocker'
alias n='nvim'
alias r='ranger'
alias ht='htop'
alias h='cht.sh'

# TMUX Setups
alias pqa='tmuxp load ~/.config/.tmuxp/qia-api.yaml -y ~/.config/.tmuxp/qia-dashboard.yaml -y ' # QIA Full Stack
alias pqb='tmuxp load ~/.config/.tmuxp/qia-api.yaml -y '                                        # QIA API
alias po='tmuxp load ~/.config/.tmuxp/oem-dashboard.yaml -y'                                    # OEM
alias pu='tmuxp load ~/.config/.tmuxp/oem-dashboard-ui-kit.yaml -y'                             # UI Kit
alias pr='tmuxp load ~/.config/.tmuxp/ride-a-short-app.yaml -y'                                 # Ride A Short

# TMUX
alias tk='tmux kill-server'

# Config File Navigation
alias ggtm='nvim ~/.tmux.conf'
alias ggaw='cd ~/.config/awesome/ && nvim rc.lua'
alias ggnv='cd ~/.config/nvim/ && nvim init.lua'
alias ggal='cd ~/.config/alacritty/ && nvim alacritty.yml'
alias ggis='nvim ~/install.sh'
alias ggba='nvim ~/.bash_aliases'
alias ggbf='nvim ~/.bash_functions'

alias ggnt='cd ~/personal/ && nvim README.md'
alias ggpi='cd ~/Projects/package-info.nvim/ && nvim'

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

# Task Warrior
alias tls='task list'
