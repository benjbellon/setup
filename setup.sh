#!/bin/bash -e


###
# symlink .bashrc and .bash_profile, and create
# .bashrc.local and .bash_profile.local
###
bash_files=("$HOME/.bashrc" "$HOME/.bash_profile")
for i in ${bash_files[@]}; do
    # create symlinks if they don't exist
    if [ ! -L $i ]; then
    	echo "Beginning Process to Symlink $i"
    	echo "------------------------------------"
    	if [ -f $i ]; then
    	    echo "removing regular file $i"
    	    rm $i
    	fi

    	fmtd_i=`echo $i | rev | cut -d'/' -f1 | rev`
    	echo "symlinking $i -> $PWD/$fmtd_i"
    	ln -s $PWD/$fmtd_i $i

    	local_i=$PWD/$fmtd_i.local
    	if [ ! -e $local_i ]; then
    	    echo "creating $PWD/$fmtd_i.local"
    	    touch $local_i
    	    chmod 666 $local_i
    	fi
    	echo "------------------------------------"
    fi
done

if [ "$(uname)" = "Darwin" ]; then
    bash setup_brew.bash

    defaults write NSGlobalDomain KeyRepeat -int 0
    defaults write NSGlobalDomain InitialKeyRepeat -int 4
fi

echo "SETUP COMPLETE"
