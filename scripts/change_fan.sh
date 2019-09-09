#!/usr/bin/env bash

## It would be nice to check the system and dynamically figure out which fan controller
## is being used...but I don't need that right now.

# echo "1" > /sys/devices/platform/applesmc.768/fan1_manual
# echo "9000" > /sys/devices/platform/applesmc.768/fan1_output
# cat /sys/devices/platform/applesmc.768/fan1_output

FAN_DIR=/sys/devices/platform/applesmc.768
FAN_OUT=$FAN_DIR/fan1_output
FAN_MANUAL=$FAN_DIR/fan1_manual
MAX_FAN=$(cat $FAN_DIR/fan1_max)
MIN_FAN=$(cat $FAN_DIR/fan1_min)

function toggle_mbpfan() {
    SHOULD_DEACTIVE=$1
    IS_ACTIVE=$(systemctl is-active mbpfan)
    if [[ "$SHOULD_DEACTIVE" == "false" ]]; then
        echo "force deactive!"
        echo "0" > "$FAN_MANUAL"
        sudo systemctl start mbpfan
        return
    elif [[ "$IS_ACTIVE" == "active" || "$SHOULD_DEACTIVE" == "true" ]]; then
        sudo systemctl stop mbpfan
        echo "force active!"
        echo "1" > "$FAN_MANUAL"
        return
    else
	echo "force deactive and start mbpfan"
        echo "there!"
        echo "0" > "$FAN_MANUAL"
        sudo systemctl start mbpfan
        return
    fi
}

function increase_fan() {
    CURR_SPEED=$(cat $FAN_DIR/fan1_output)
    NEXT_SPEED=$(echo - | awk -v curr="$CURR_SPEED" '{printf "%1.0f", (curr + 500)}')

    # deactivate mbpfan
    toggle_mbpfan "true"

    if [[ $NEXT_SPEED -lt $MAX_FAN ]]; then
        echo $NEXT_SPEED > "$FAN_OUT"
    else
        echo $MAX_FAN > "$FAN_OUT"
    fi
}

function decrease_fan() {
    CURR_SPEED=$(cat $FAN_DIR/fan1_output)
    NEXT_SPEED=$(echo - | awk -v curr="$CURR_SPEED" '{printf "%1.0f", (curr - 500)}')

    # deactivate mbpfan
    toggle_mbpfan "true"

    if [[ $NEXT_SPEED -gt $MIN_FAN ]]; then
        echo $NEXT_SPEED > "$FAN_OUT"
    else
        # no reason to ever this low.
        # let the system take back over, since the user probably forgot
        toggle_mbpfan "false"
    fi
}

while getopts ":idt" opt; do
    case ${opt} in
        t) toggle_mbpfan
        ;;
        i) increase_fan
        ;;
        d) decrease_fan
        ;;
        \? )
        ;;
    esac
done
