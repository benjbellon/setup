#!/bin/bash

IMG=/tmp/screen_locked.png
scrot $IMG
mogrify -scale 10% -scale 1000% $IMG
i3lock -i $IMG

xautolock -time 1 -locker "i3lock -i $IMG" -notify 20 -notifier 'xset dpms force off' &
