#!/bin/bash
INSTALL_BASH_COFIG=1 # 0
INSTALL_NEMO_COFIG=0 # 0

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

if [ $INSTALL_NEMO_COFIG -eq 1 ]; then
	if ! [ -d ~/.local/share/nemo/actions/scripts ]; then
		mkdir -p ~/.local/share/nemo/actions/scripts
	fi

	cp ./nemo/actions/checksums.nemo_action ~/.local/share/nemo/actions/checksums.nemo_action
	cp ./nemo/actions/scripts/checksums.sh ~/.local/share/nemo/actions/scripts/checksums.sh
fi
unset INSTALL_NEMO_COFIG

# Open new .bashrc for editing options
xdg-open ~/.bashrc &
