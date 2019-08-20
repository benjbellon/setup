#!/bin/bash

IMG="~/pictures/Yosemite-Color-Block.png"

xautolock -time 1 -locker "i3lock -i $IMG" -notify 20 -notifier 'xset dpms force off' &
xautolock -time 10 -locker "systemctl suspend" &
