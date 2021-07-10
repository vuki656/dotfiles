#!/bin/sh

# Necessary for tmux to load correctly
source "$HOME/.bashrc"

# Load cargo binaries
export PATH=$PATH:~/.cargo/bin/

# Load brew
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
