source ~/.bash_functions.bash
source ~/.bash_aliases.bash

# Init git keys
eval $(gnome-keyring-daemon --start)
export SSH_AUTH_SOCK
export GNOME_KEYRING_PID
export GNOME_KEYRING_CONTROL
