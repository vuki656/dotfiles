source ~/.bash_functions.bash
source ~/.bash_aliases.bash

# Init git keys
eval $(gnome-keyring-daemon --start)
export SSH_AUTH_SOCK
export GNOME_KEYRING_PID
export GNOME_KEYRING_CONTROL

################################################################################################
################################ Create PS1 (Terminal prefix) ##################################
################################################################################################ 

function color_my_prompt {
    local __time="[\[\033[00;34m\]\t\[$(tput sgr0)\]]"
    local __user="\[\033[01;32m\]\u"
    local __cur_location="\[\033[01;34m\]\w"
    local __git_branch_color="\[\033[31m\]"
    local __git_branch='`git branch 2> /dev/null | grep -e ^* | sed -E  s/^\\\\\*\ \(.+\)$/\(\\\\\1\)\ /`'
    local __prompt_tail="\[\033[35m\]$"
    local __last_color="\[\033[00m\]"

    export PS1="$__time $__user $__cur_location $__git_branch_color$__git_branch$__prompt_tail$__last_color
╚═══$ "
}

color_my_prompt
