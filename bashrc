# Toumnek's .bashrc ver. 03092023

#TODO: extract all option switches to top of this file
# CONFIG
# Run neofetch when opening a terminal
RUN_NEOFETCH=1 # 0
# Export paths
EXPORT_PATHS=1 # 0
# Force monochromatic prompt
FORCE_MONO=0 # 0
# Use shorter, more traditional prompt (only applies to color prompt)
TRADITIONAL_PROMPT=0 # 0

# If not running interactively, return
case $- in
	*i*) ;;
	  *) return;;
esac

# Do not put duplicate lines or lines starting with space in the history.
HISTCONTROL=ignoreboth
# Append to the history file, don't overwrite it
shopt -s histappend
HISTSIZE=1000
HISTFILESIZE=2000

# Check the window size after each command
shopt -s checkwinsize

# Do not allow overwriting of files
set -o noclobber

# Colors
RED="\e[31m"
BOLDRED="\e[1;31m"
GREEN="\e[32m"
BOLDGREEN="\e[1;32m"
BLUE="\e[34m"
BOLDBLUE="\e[1;34m"
NORMAL="\e[0m"

# Prompt
INDICATOR="code=\$?; if [ \${code} = 0 ]; then echo \"${GREEN}0${NORMAL}\"; else echo \"${RED}\${code}\a${NORMAL}\"; fi"
USER_MACHINE="${BOLDGREEN}\u${NORMAL}@${BOLDGREEN}\h${NORMAL}"
CURRENT_PATH="${BOLDBLUE}\w${NORMAL}"
TIME="\t"
if [ $TRADITIONAL_PROMPT -eq 1 ]; then
	COLOR_PROMPT="${USER_MACHINE}:${CURRENT_PATH}\$ "
else
	COLOR_PROMPT="┏━[${USER_MACHINE}]━[${CURRENT_PATH}]━[${TIME}]━[\`${INDICATOR}\`]\n┗━\\$ "
fi
unset TRADITIONAL_PROMPT

MONO_PROMPT="\u@\h:\w\$ "

# If color prompt can be used, use it
case "$TERM" in
	xterm-color|*-256color) PS1=${COLOR_PROMPT} ;;
	*) PS1=${MONO_PROMPT} ;;
esac

if [ $FORCE_MONO -eq 1 ]; then
	PS1=${MONO_PROMPT}
fi
unset FORCE_MONO

# If this is xterm, set window title
case "$TERM" in
	xterm*|rxvt*) PS1="\[\e]0;\u@\h: \w\a\]$PS1" ;;
	*) ;;
esac

# Color GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# Enable autocomplete
if ! shopt -oq posix; then
	if [ -f /usr/share/bash-completion/bash_completion ]; then
		. /usr/share/bash-completion/bash_completion
	elif [ -f /etc/bash_completion ]; then
		. /etc/bash_completion
	fi
fi

# Include aliases
if [ -f ~/.bash_aliases ]; then
	. ~/.bash_aliases
else
	echo -e "${BOLDRED}Could not load aliases!${NORMAL}"
fi

# Paths
if [ $EXPORT_PATHS -eq 1 ]; then
	# Java and Maven
	export JAVA_HOME="/usr/lib/jvm/jdk-17"
	export PATH=$JAVA_HOME/bin:$PATH
	export MVN_HOME="/usr/bin/apache-maven-3.9.0"
	export PATH=$MVN_HOME/bin:$PATH
fi
unset EXPORT_PATHS

# Run neofetch
if [ $RUN_NEOFETCH -eq 1 ]; then
	neofetch
fi
unset RUN_NEOFETCH
