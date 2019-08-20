#!/usr/bin/env bash

# get the displays which are connected and setup an associative array
DISPLAYS=( $(xrandr | grep " connected" | awk '{print $1}') )
declare -A DISP_RES

BG_IMG="~/pictures/Yosemite-Color-Block.png"

VERBOSE=""
if_echo () {
    if [ -n "$VERBOSE" ]; then
        echo $1
    fi
}

while getopts ":h" opt; do
    case ${opt} in
        h ) VERBOSE="on"
            ;;
        \? ) echo "read the script for help; -v for verbose logging"
             ;;
    esac
done

for (( i=0; i <${#DISPLAYS[@]}; i++ )); do
    # store the assocated resolutions
    DISPLAY_NAME=${DISPLAYS[i]}
    DISP_RES["$DISPLAY_NAME"]=$(xrandr | grep "^$DISPLAY_NAME" -A 1 | tail -n 1 | awk '{print $1}')
done

# We setup a consistent monitor ordering as follows...
#  -----     -----      ------        ------
# | DP-1 |  | DP-2 |  | HDMI-1 |    | HDMI-2 |
#  -----     -----      ------        ------
#         \        \     /           /
#           \       |   |          /
#             \     -----        /
#               \ | eDP-1 |----/
#                   _____

EDP_1=${DISP_RES["eDP-1"]}
DP_1=${DISP_RES["DP-1"]}
DP_2=${DISP_RES["DP-2"]}
HDMI_1=${DISP_RES["HDMI-1"]}

if [ -n "$EDP_1" ]; then
    # if no other displays are set, then we bring all windows into eDP-1
    if [[ -z "$DP_1" && -z "$DP_2" && -z "$HDMI_1" ]]; then
        if_echo "No displays detected. Resetting primary display (eDP-1)"
        xrandr --auto
    else
    if_echo "Found other displays, and explicitly setting primary display (eDP-1)"
    xrandr --output eDP-1 --mode "$EDP_1"
    fi
fi

if [ -n "$DP_1" ]; then
    if_echo "Found DP-1. Setting DP-1 above primary display (eDP-1)"
    xrandr --output DP-1 --mode "$DP_1" --above eDP-1
fi

if [[ -n "$DP_2" && -n "$DP_1" ]]; then
    if_echo "Found DP-2. Setting DP-2 right of DP-1"
       xrandr --output DP-2 --mode "$DP_2" --right-of DP-1
elif [[ -n "$DP_2" ]]; then
    if_echo "Found DP-2 but not DP-1. Setting DP-2 above primary display (eDP-1)"
       xrandr --output DP-2 --mode "$DP_2" --above eDP-1
fi

if [[ -n "$HDMI_1" && -n "$DP_2" && "$DP_1" ]]; then
    if_echo "Found HDMI-1. Setting it right of DP-2"
    xrandr --output HDMI-1 --mode "$HDMI_1" --right-of DP-2
elif [[ -n "$HDMI_1" && ( "$DP_2" || "$DP_1" )  ]]; then
    if [ -n "$DP_2" ]; then
        if_echo "Found HDMI-1 and DP-2 but not DP-1. Setting HDMI-1 right of DP-2"
        xrandr --output HDMI-1 --mode "$HDMI_1" --right-of DP-2
    else
        if_echo "Found HDMI-1 and DP-1 but not DP-2. Setting HDMI-1 right of DP-1"
        xrandr --output HDMI-1 --mode "$HDMI_1" --right-of DP-1
    fi
fi

feh bg-fill "$IMG"
