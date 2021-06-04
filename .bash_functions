#!/bin/sh

# Clean System
clean() {
    sudo apt clean
    sudo apt autoclean
    sudo apt autoremove

    clear
}

## Git Commit
gc() {
  git commit -m "$*"
}

