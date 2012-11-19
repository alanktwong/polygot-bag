#!/bin/sh
if [ -f $HOME/.profile ]; then
	# echo "Executing .profile"
	source $HOME/.profile # get paths
fi
if [ -f $HOME/.bashrc ]; then
	# echo "Executing .bashrc"
	source $HOME/.bashrc # get aliases
fi



