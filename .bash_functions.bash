# Clean system
clean() {
    sudo apt clean
    sudo apt autoclean
    sudo apt autoremove

    clear
    echo "== System Clean =="
}

## Git Commit
gc() {
  git commit -m "$*"
}

