#!/bin/sh
if [ -f $HOME/.profile ]; then
	# echo "Executing .profile"
	source $HOME/.profile # get paths
fi
if [ -f $HOME/.bashrc ]; then
	# echo "Executing .bashrc"
	source $HOME/.bashrc # get aliases
fi

[ -s "$HOME/.nvm/nvm.sh" ] && . "$HOME/.nvm/nvm.sh" # This loads nvm
