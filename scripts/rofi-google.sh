#!/bin/bash

query=$( (echo) | rofi -dmenu )

if [[ -n "$query" ]]; then
    google-chrome --profile-directory=Default --password-store=gnome -url https://www.google.com/search?q="${query}"
else
    exit
fi

exit
