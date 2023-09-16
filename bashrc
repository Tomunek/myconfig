# Toumnek's .bashrc ver. 03092023

#TODO: extract all option switches to top of this file
# CONFIG
RUN_NEOFETCH=1 # 0

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
COLOR_PROMPT="┏━[${BOLDGREEN}\u${NORMAL}@${BOLDGREEN}\h${NORMAL}]━[${BOLDBLUE}\w${NORMAL}]━[\t]━[\`${INDICATOR}\`]\n┗━\\$ "
# Short prompt
#COLOR_PROMPT="\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ "
#TODO: add sort prompt and mono prompt force switches
MONO_PROMPT="\u@\h:\w\$ "

# If color prompt can be used, use it
case "$TERM" in
	xterm-color|*-256color) PS1=${COLOR_PROMPT} ;;
	*) PS1=${MONO_PROMPT} ;;
esac

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
EXPORT_PATHS="yes"
if [ $EXPORT_PATHS = "yes" ]; then
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
