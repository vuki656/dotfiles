#!/bin/sh

source "$HOME/.bashrc"              # Necesary for tmux to load correctly

# Load cargo binaries
export PATH=$PATH:~/.cargo/bin/     
. "$HOME/.cargo/env"
