#!/bin/bash

IMG="~/.setup/des/i3/assets/wallpaper/yosemite_color_block.png"

xautolock -time 1 -locker "i3lock -i $IMG" -notify 20 -notifier 'xset dpms force off' &
xautolock -time 10 -locker "systemctl suspend" &
