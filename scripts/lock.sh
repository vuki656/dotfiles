#!/bin/bash

name="$(date)"

scrot /tmp/"$name".jpg
convert /tmp/"$name".jpg -blur 0x15 /tmp/"$name"-blur.png
i3lock -i /tmp/"$name"-blur.png
