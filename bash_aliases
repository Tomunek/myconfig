# Tomunek's .bashrc aliases

# Safety aliases
alias rm='rm -i'
alias mv='mv -i'
alias cp='cp -i'
alias ln='ln -i'

# Color aliases
alias ls='ls --color=auto -h'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# ls aliases
alias l='ls'
alias la='ls -a'
alias ll='ls -lah'

# cd aliases
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias bd='cd "$OLDPWD"'
alias home='cd ~/'

# Git aliases
alias gpl='git pull'
alias gps='git push'
alias gaa='git add --all'
alias gcm='git commit -S -m'
alias gst='git status'
alias gss='git status -s'
alias glg='git log'
alias gdf='git diff'

# Windows-like clear alias
alias cls='clear'

# Search in history
alias h='history | grep'

# Python3 aliases
alias python="python3"
alias py="python3"


# COMPLEX FUNCTIONS
# Extract any archive
extract(){
	for archive in $*; do
		if [ -f $archive ] ; then
			case $archive in
				*.tar.bz2)   tar xvjf $archive    ;;
				*.tar.gz)    tar xvzf $archive    ;;
				*.bz2)       bunzip2 $archive     ;;
				*.rar)       rar x $archive       ;;
				*.gz)        gunzip $archive      ;;
				*.tar)       tar xvf $archive     ;;
				*.tbz2)      tar xvjf $archive    ;;
				*.tgz)       tar xvzf $archive    ;;
				*.zip)       unzip $archive       ;;
				*.Z)         uncompress $archive  ;;
				*.7z)        7z x $archive        ;;
				*)           echo "Could not extract '$archive'" ;;
			esac
		else
			echo "'$archive' is not a valid file!"
		fi
	done
}

# +cd functions
lsd(){
	ls "$1"
	cd "$1"
}
cpd(){
	cp "$1" "$2" && cd "$2"
}
mvd(){
	mv "$1" "$2" && cd "$2"
}
mkdird(){
	mkdir -p "$1"
	cd "$1"
}

# Return given code
fail(){
	return "$1" 
}

# git add+commit+push
gitacp(){
	git add --all
	git commit -m -S "$1"
	git push
}
