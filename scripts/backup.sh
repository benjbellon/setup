#!/usr/bin/env bash

##
# Create full tree backups to specified media

GLOBAL_MEDIA_BLOCK=$1

echo "Beginning rsync full system backup / -> $GLOBAL_MEDIA_BLOCK"
rsync -SHaAX --delete --info=progress2 --exclude={"/dev/*", "/proc/*", "/sys/*", "/tmp/*", "/run/*", "/mnt/*", "/lost+found"} / $1
