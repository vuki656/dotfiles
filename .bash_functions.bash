## Add to .bashrc "source ~./.bash_functions.bash"

# Clean System
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

