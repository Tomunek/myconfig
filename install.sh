#!/bin/bash
INSTALL_BASH_COFIG=1

if [ $INSTALL_BASH_COFIG -eq 1 ]; then
	# Backup original .bashrc
	if [ -f ~/.bashrc ]; then
		mv ~/.bashrc ~/.bashrc.bak
	fi
	if [ -f ~/.bash_aliases ]; then
		mv ~/.bash_aliases ~/.bash_aliases.bak
	fi

	# Put new .bashrc in home
	cp ./bashrc ~/.bashrc
	cp ./bash_aliases ~/.bash_aliases
fi
unset INSTALL_BASH_COFIG

# Open new .bashrc for editing options
xdg-open ~/.bashrc &
