# Last gist-paste 03/30/2021 at https://gist.github.com/a445dc99366573b044585ff7a5f7f43c

# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
# don't overwrite GNU Midnight Commander's setting of `ignorespace'.
HISTCONTROL=$HISTCONTROL${HISTCONTROL+:}ignoredups
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
#[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
orce_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

red='\[\e[0;31m\]'
RED='\[\e[1;31m\]'
blue='\[\e[0;34m\]'
BLUE='\[\e[1;34m\]'
cyan='\[\e[0;36m\]'
CYAN='\[\e[1;36m\]'
green='\[\e[0;32m\]'
GREEN='\[\e[1;32m\]'
yellow='\[\e[0;33m\]'
YELLOW='\[\e[1;33m\]'
PURPLE='\[\e[1;35m\]'
purple='\[\e[0;35m\]'
nc='\[\e[0m\]'

if [ "$UID" = 0 ]; then
    PS1="$red\u$nc@$red\H$nc:$CYAN\w$nc\\n$red#$nc "
else
    PS1="$PURPLE\u$nc@$CYAN\H$nc:$GREEN\w$nc\\n$GREEN\$$nc "
fi
# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    #alias grep='grep --color=auto'
    #alias fgrep='fgrep --color=auto'
    #alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -lh'
alias la='ls -lA'
alias l='ls -CF'
alias alsaeq='alsamixer -D equal'
alias androidio='nullout `cd ~/android-studio/bin; ./studio.sh`'
alias BG='bg %1'
alias bh='tail -n25 ~/.bash_history'
alias dbb='dub build'
alias deblur='cd /opt/Unshake; ./unlaunch.sh'
alias kf='pkill firefo*'
alias kg='pkill chrome'
alias lsx='ls -lA | grep "^[-,l]rwx"'				# list executable files only including softlinks
alias mix='alsamixer'
alias mydumpkey='dumpkeys -C /dev/console > my_keymap'
alias psaf='ps -Af | less'
alias nabrc='nano ~/.bashrc'					# edit this file!
alias netdefault='sudo virsh net-start default'			# when virt-manager complains
alias pmstats='sudo tlp-stat -b | less'				# for Lenovo laptops with tlp installed
alias redreset='redshift -oP -l 40.0023:-76.7712 -t 6100:3500'
alias safr='sudo aptitude --full-resolver'
alias sasu='sudo apt-get update; sudo apt-get upgrade'		# formerly (apt update, aptitude safe upgrade) do a dist-upgrade more often now
alias seiwr='sudo /etc/init.d/wicd restart'
alias sfdl='sudo fdisk -l'
alias sifa='hostname -I'					# formerly ( ip address show ) formerly ( sudo ifconfig -a )
alias systemservices='systemctl list-unit-files --state enabled'
alias texta='cd ~/opt/textadept; textadept-curses'
alias wos='head /etc/apt/sources.list -n3; uname -a'
#a lias waf=$HOME/waf/waf

# git
alias addup='git add -u'
alias addall='git add .'
alias branch='git branch'
alias checkout='git checkout'
alias clone='git clone'
alias commit='git commit -m'
alias fetch='git fetch'
alias pull='git pull origin'
alias push='git push origin'
alias stat='git status'
alias tag='git tag'
alias newtag='git tag -a'

# gconfig per "Git Bare Repository - A Better Way To Manage Dotfiles" @ https://www.youtube.com/watch?v=tBoLDpTWVOM 
# don't forget to gconfig  --local status.showUntrackedFiles no
#             and git remote add origin https://github.com/YOURUSERNAME/dotfiles.git
# Usage:
#        gconfig add /path/to/file
#        gconfig commit -m "A short message"
#        gconfig push
# if you cloned this from https://github.com/johnaman/dotfiles then you want to use this line instead
# alias gconfig='/usr/bin/git --git-dir=$HOME/dotfiles/ --work-tree=$HOME'

alias gconfig='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'

# don't forget to 

# Function definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_functions, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_funcs ]; then
    . ~/.bash_funcs
fi

# Default parameter to send to the "less" command
# -R: show ANSI colors correctly; -i: case insensitive search
LESS="-R -i"

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

# add user home bin
PATH=$PATH:/home/john/bin

# Add sbin directories to PATH.  This is useful on systems that have sudo
echo $PATH | grep -Eq "(^|:)/sbin(:|)"     || PATH=$PATH:/sbin
echo $PATH | grep -Eq "(^|:)/usr/sbin(:|)" || PATH=$PATH:/usr/sbin

openroot() { 
  if [[ "$1" = "-u" ]]; then
    sudo /usr/local/bin/xchroot "$@" --env XCHROOT_MYROOT="$XCHROOT_MYROOT" --env XAUTHORITY="$XAUTHORITY" --env DISPLAY="$DISPLAY";  
  else
    sudo /usr/local/bin/xchroot -u $(whoami) "$@" --env XCHROOT_MYROOT="$XCHROOT_MYROOT" --env XAUTHORITY="$XAUTHORITY" --env DISPLAY="$DISPLAY";  
  fi
}

# for further information on how to address issues with su and Xorg
# see at: www.elstel.org/xchroot, or /usr/share/doc[/packages]/xchroot
#


# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/home/john/.sdkman"
[[ -s "/home/john/.sdkman/bin/sdkman-init.sh" ]] && source "/home/john/.sdkman/bin/sdkman-init.sh"

export PATH=/usr/local/bin:/usr/bin:/bin:/home/john/projects/redo/bin:/home/john/.sdkman/candidates/java/current/bin:/opt/maven/bin:/home/john/.nvm/versions/node/v4.2.6/bin:/home/john/bin:/sbin:/usr/sbin
