# Tomunek's .bashrc

# CONFIG
# Run neofetch when opening a terminal
RUN_NEOFETCH=1 # 0
# Export paths
EXPORT_PATHS=1 # 0
# Force monochromatic prompt
FORCE_MONO=0 # 1
# Make text in prompt not bold (may look better on some machines)
ANEMIC_PROMPT=0 # 1
# Use shorter, more traditional prompt (only applies to color prompt)
TRADITIONAL_PROMPT=0 # 1
# Display current time in prompt
TIME_IN_PROMPT=0 # 1
# Display git branch in prompt (if in repo)
GIT_BRANCH_PROMPT=1 # 0

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
get_indicator() {
	code=$?
	if [ $code -eq 0 ]; then
		echo -e "━[${GREEN}0${NORMAL}]"
	else
		echo -e "━[${RED}${code}${NORMAL}]"
	fi
}
get_git_branch() {
	BRANCH_NAME=$(git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/')
	if [ ${#BRANCH_NAME} -ge 1 ] && [ $GIT_BRANCH_PROMPT -eq 1 ]; then 
		echo "━[${BRANCH_NAME}]"
	fi
}
get_time() {
	if [ $TIME_IN_PROMPT -eq 1 ]; then 
		echo "━[\t]"
	fi
}
if [ $ANEMIC_PROMPT -eq 1 ]; then
	USER_MACHINE="${GREEN}\u${NORMAL}@${GREEN}\h${NORMAL}"
	CURRENT_PATH="${BLUE}\w${NORMAL}"
else
	USER_MACHINE="${BOLDGREEN}\u${NORMAL}@${BOLDGREEN}\h${NORMAL}"
	CURRENT_PATH="${BOLDBLUE}\w${NORMAL}"
fi
TIME="\t"
if [ $TRADITIONAL_PROMPT -eq 1 ]; then
	COLOR_PROMPT="${USER_MACHINE}:${CURRENT_PATH}\$ "
else
	COLOR_PROMPT="┏━[${USER_MACHINE}]\$(get_indicator)$(get_time)\$(get_git_branch)━[${CURRENT_PATH}]\n┗━\\$ "
fi
MONO_PROMPT="\u@\h:\w\$ "
unset TRADITIONAL_PROMPT

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
	# TODO: add auto finding of latest versions
	export JAVA_HOME="/usr/lib/jvm/jdk-21-oracle-x64"
	export PATH=$JAVA_HOME/bin:$PATH
	export MVN_HOME="/usr/bin/apache-maven-3.9.5"
	export PATH=$MVN_HOME/bin:$PATH
fi
unset EXPORT_PATHS

# For GPG signing git commits
export GPG_TTY=$(tty)

# Run neofetch
if [ $RUN_NEOFETCH -eq 1 ]; then
	neofetch
fi
unset RUN_NEOFETCH
