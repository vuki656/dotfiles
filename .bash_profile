#!/bin/sh

source "$HOME/.bashrc"              # Necesary for tmux to load correctly

# Load cargo binaries
export PATH=$PATH:~/.cargo/bin/     

# Load brew
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
