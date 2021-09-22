#!/bin/bash

# Necessary for tmux to load correctly
source "$HOME/.bashrc"

# Load cargo binaries
export PATH=$PATH:~/.cargo/bin/
. "$HOME/.cargo/env"

# Load brew
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

# Ignore shellcheck errors
export SHELLCHECK_OPTS="-e SC1090"
