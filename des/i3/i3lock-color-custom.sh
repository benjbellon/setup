#!/bin/sh

B='#00000000'  # blank
C='#ffffff22'  # clear ish
D='#617c8c'    # default
T='#bfd2d5'    # text
W='#3a5d5f'    # wrong
V='#617c8c'    # verifying

i3lock \
--insidever-color=$C   \
--ringver-color=$V     \
\
--insidewrong-color=$C \
--ringwrong-color=$W   \
\
--inside-color=$B      \
--ring-color=$D        \
--line-color=$B        \
--separator-color=$D   \
\
--verif-color=$T        \
--wrong-color=$T        \
--time-color=$T        \
--date-color=$T        \
--layout-color=$T      \
--keyhl-color=$W       \
--bshl-color=$W        \
\
--screen 1            \
-i "$HOME/.setup/des/i3/assets/wallpaper/dark_forest.png" \
--clock               \
--indicator           \
--time-str="%H:%M:%S"  \
--date-str="%A, %m %Y" \ && xset dpms force off
