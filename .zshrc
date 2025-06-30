####  Set Options and such
setopt NOTIFY			# Background jobs will notify when done
setopt NO_HUP			# Background jobs are detached from terminal
setopt FUNCTION_ARG_ZERO	# $0 returns the function
setopt NO_RM_STAR_SILENT	# 'rm *' calls always must be confirmed
setopt NO_BEEP			# duh
setopt AUTO_CD			# if command is a dir, cd to it
setopt MULTIOS			# cool stuff like multiple redirection
setopt MENU_COMPLETE		# vim-style completion
setopt EXTENDED_GLOB		# regex type stuff in globbing
setopt NO_CLOBBER		# no file clobbering unless >! used
setopt ALWAYS_LAST_PROMPT

bindkey -v			# vi keybindings

#### Export Variables
export LSCOLORS="gxfxcxdxbxegedadabagacad"
export CVSROOT=":pserver:anonymous@cvs-mirror.mozilla.org:/cvsroot"
export PAGER="less"
export EDITOR="vim"
export BLOCKSIZE="K"


#### Include Files
if [ -f ~/.zshmisc ]; then
		source ~/.zshmisc
else
		print "~/.zshmisc missing?"
fi

if [ -f ~/.zshaliases ]; then
		source ~/.zshaliases
else
		print "~/.zshaliases missing?"
fi

# Include bindkeys
if [ -f ~/.zshkeys ]; then
                source ~/.zshkeys
else
                print "~/.zshkeys missing?"
fi

# Directory stack stuff
DIRSTACKSIZE=15
setopt PUSHD_SILENT

# Prompt stuff
if (( EUID != 0 )); then
		PS1="[$(print '%{\e[1;32m%}%n%{\e[0m%}')@$(print '%{\e[1;33m%}%m%{\e[0m%}')%20<..<:$(print '%{\e[1;36m%}%~%{\e[0m%}')% #] "
else
    PS1="[$(print '%{\e[1;31m%}%n%{\e[0m%}')@$(print '%{\e[1;33m%}%m%{\e[0m%}')%20<..<:$(print '%{\e[1;36m%}%~%{\e[0m%}')% #] "
fi

### Completion styles
autoload -U compinit
compinit

# list of completers to use
zstyle ':completion:*::::' completer _expand _complete _ignored _approximate

#History Stuff
HISTFILE=~/.zshhist
HISTSIZE=1000
SAVEHIST=1000
#------------------------------
## Window title
##------------------------------
case $TERM in
    *xterm*|rxvt|rxvt-unicode|rxvt-256color|rxvt-unicode-256color|(dt|k|E)term)
	precmd () { print -Pn "\e]0;[%n@%M][%~]%#\a" } 
	preexec () { print -Pn "\e]0;[%n@%M][%~]%# ($1)\a" }
	;;
    screen)
       	precmd () { 
	print -Pn "\e]83;title \"$1\"\a" 
	print -Pn "\e]0;$TERM - (%L) [%n@%M]%# [%~]\a" 
	}
	preexec () { 
	print -Pn "\e]83;title \"$1\"\a" 
	print -Pn "\e]0;$TERM - (%L) [%n@%M]%# [%~] ($1)\a" 
	}
	;; 
	esac
