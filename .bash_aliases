#!/bin/sh

# Terminal
alias c='clear'
alias ..='cd ..'
alias e='exit'

# Apt
alias update='sudo apt update'
alias upgrade='sudo apt upgrade'
alias padd='sudo apt install'
alias premove='sudo apt remove'

# System
alias poweroff='systemctl poweroff'
alias reboot='systemctl reboot'

# Git
alias gs='git status'
alias gpl='git pull'
alias gp='git push'
alias ga='git add'
alias gaa='git add .'
alias lg='lazygit'

# Other
alias ld='lazydocker'
alias n='nvim'
alias r='ranger'

# Setups
alias pq='tmuxp load ~/.config/.tmuxp/qia-api.yaml -y ~/.config/.tmuxp/qia-dashboard.yaml -y '

# TMUX
alias tk='tmux kill-session'
