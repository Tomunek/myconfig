#!/bin/bash

# Backup original .bashrc
#TODO: handle situation when .bak files already exist
if [ -f ~/.bashrc ]; then
    mv ~/.bashrc ~/.bashrc.bak
fi
if [ -f ~/.bash_aliases ]; then
    mv ~/.bash_aliases ~/.bash_aliases.bak
fi

# Put new .bashrc in home
cp ./bashrc ~/.bashrc
cp ./bash_aliases ~/.bash_aliases
