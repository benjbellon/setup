export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS=@im=fcitx

xset r rate 200 60
xrandr --output eDP-1 --scale 1.25x1.25
systemctl --user import-environment DISPLAY
/usr/bin/libinput-gestures &
[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources
[[ -f ~/.Xmodmap ]] && xmodmap ~/.Xmodmap
exec i3 --shmlog-size=2621440
