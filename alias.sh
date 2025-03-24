# COMMON SHELL ALIASES FOR ZSH and BASH
# collected from all over the internet

# coloured manpages
export LESS_TERMCAP_mb=$'\e[1;31m'
export LESS_TERMCAP_md=$'\E[01;38;5;74m'
export LESS_TERMCAP_so=$'\e[01;44;37m'
export LESS_TERMCAP_us=$'\e[01;37m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_ue=$'\e[0m'
export GROFF_NO_SGR=1                  # for konsole and gnome-terminal
export MANPAGER='less -s -M +Gg'

# https://unix.stackexchange.com/a/302391
# Prefer nvim over vim over vi
export EDITOR="$(command -v nvim 2>/dev/null || command -v vim 2>/dev/null || command -v vi)"
# we have gvim, not in an SSH term, and the X11 display number is under 10
if command -v gvim >/dev/null 2>&1 \
&& [ "$SSH_TTY$DISPLAY" = "${DISPLAY#*:[1-9][0-9]}" ]; then
  export VISUAL="$(command -v gvim) -f"
  SUDO_EDITOR="$VISUAL"
else
  SUDO_EDITOR="$EDITOR"
fi

export BROWSER="firefox"

export XDG_CONFIG_HOME=${XDG_CONFIG_HOME:="${HOME}/.config"}

# confirm overwrite
#set -o noclobber
alias cp='cp -i'
alias mv='mv -i'

if [[ -n `which gdircolors &> /dev/null` ]]; then
    test -r ~/.dircolors && eval "$(gdircolors -b ~/.dircolors)" || eval "$(gdircolors -b)"

    alias grepc='grep -n --color=auto'
    alias fgrepc='fgrep -n --color=auto'
    alias egrepc='egrep -n --color=auto'
elif [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"

    alias grepc='grep -n --color=auto'
    alias fgrepc='fgrep -n --color=auto'
    alias egrepc='egrep -n --color=auto'
fi

if [[ `uname` == 'Darwin' ]]; then
    if [[ -n `which gls &> /dev/null` ]]; then
        alias ls='gls -CF    --color=auto'
        alias ks='gls -CF    --color=auto'
        alias l='gls  -lF    --color=auto --time-style=+\ %d.%m.%Y\ %R'
        alias la='gls -ACF   --color=auto'
        alias ll='gls -alF   --color=auto --time-style=+\ %d.%m.%Y\ %R'
        alias lt='gls -alrtF --color=auto --time-style=+\ %d.%m.%Y\ %R'
        alias l.='gls --color=auto -d .[[:alnum:]]* 2> /dev/null || echo "No hidden file here..."'		# list only hidden files
    else
        alias ls='ls -CF'
        alias ks='ls -CF'
        alias l='ls  -lF'
        alias la='ls -ACF'
        alias ll='ls -alF'
        alias lt='ls -alrtF'
        alias l.='ls -d .[[:alnum:]]* 2> /dev/null || echo "No hidden file here..."'		# list only hidden files
    fi
else
    alias ls='ls -CF    --color=auto'
    alias ks='ls -CF    --color=auto'
    alias l='ls  -lF    --color=auto --time-style=+\ %d.%m.%Y\ %R'
    alias la='ls -ACF   --color=auto'
    alias ll='ls -alF   --color=auto --time-style=+\ %d.%m.%Y\ %R'
    alias lt='ls -alrtF --color=auto --time-style=+\ %d.%m.%Y\ %R'
    alias l.='ls -d .[[:alnum:]]* 2> /dev/null || echo "No hidden file here..."'		# list only hidden files
fi

alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ..2='cd ../..'
alias ..3='cd ../../..'
alias ..4='cd ../../../..'

alias myinxi='inxi -CDGIMPRS'

if [[ `uname` == 'Darwin' ]]; then
    if [[ -n `which gdu &> /dev/null` ]]; then
        alias du='gdu'
        alias du0='gdu --max-depth=0'
        alias du1='gdu --max-depth=1'
        alias dug='gdu -h | grep ^[0-9.]*G | sort -rn | head -n 20 | cut -d: -f2'
        alias dum='gdu -h | grep ^[0-9.]*M | sort -rn | head -n 20 | cut -d: -f2'
    fi
else
    alias du0='du --max-depth=0'
    alias du1='du --max-depth=1'
    alias dug='du -h | grep ^[0-9.]*G | sort -rn | head -n 20 | cut -d: -f2'
    alias dum='du -h | grep ^[0-9.]*M | sort -rn | head -n 20 | cut -d: -f2'
fi

alias tcal='cal | sed "s/^/ /;s/$/ /;s/ $(date +%e) / $(date +%e | sed '\''s/./#/g'\'') /"'

alias alert_helper='history|tail -n1|sed -e "s/^\s*[0-9]\+\s*//" -e "s/;\s*alert$//"'
alias alert='notify-send -i /usr/share/icons/gnome/32x32/apps/gnome-terminal.png "[$?] $(alert_helper)"'

alias fontlist="fc-list '' family | sort -u"
alias fontupdate='fc-cache -v -f'
alias linecount='wc -l $1'
alias wordcount='wc -w $1'
alias epochtime='date +%s'
alias timestamp='date "+%Y%m%dT%H%M%S"'
alias heute='date +"%A, %-d. %B %Y"'
alias KW='date +%V'
alias kalenderwoche='date +%V'
alias timer='echo "Timer started at $(date) - stop with Ctrl-D." && /usr/bin/time --format "Time: %E" cat && date'

alias ccat='pygmentize -g'

alias k='kubectl'
alias tf='terraform'
alias kubcetl='kubectl'
alias terrafrom='terraform'

if [[ `uname` == 'Darwin' ]]; then
    alias code="open -a 'Visual Studio Code'"
fi

##############################################
#### lots of functions ...


### cat a file without comments
catnocomment ()
{
	if [ $# -lt 1 ] || [ $# -gt 2 ]; then
		echo "please specify file"
	else
		egrep -a -v '^[[:space:]]*#' $1 | egrep -a '[[:print:]]'
	fi
}

### colourful less
cless() {
    pygmentize -g "$1" | less -R
}

grepp() {
    [ $# -eq 1 ] && perl -00ne "print if /$1/i" || perl -00ne "print if /$1/i" < "$2";
}

hgg()
{
    if [ $# -lt 1 ] || [ $# -gt 1 ]; then
        echo "search shell history"
        echo "usage: hgg [search pattern]"
    else
        history | grep -i $1 | grep -v hg
    fi
}

# countfiles copyright 2007 - 2010 Christopher Bratusek
countfiles ()
{
	case $1 in
		*+h)
			echo $(($(ls --color=no -1 -la . | grep -v ^l | wc -l)-1))
		;;
		*-h)
			echo $(($(ls --color=no -1 -l . | grep -v ^l | wc -l)-1))
		;;
		*+d)
			echo $(($(ls --color=no -1 -la . | grep -v ^- | wc -l)-1))
		;;
		*-d)
			echo $(($(ls --color=no -1 -l . | grep -v ^- | wc -l)-1))
		;;
		*+f)
			echo $(($(ls --color=no -1 -la . | grep -v ^d | wc -l)-1))
		;;
		*-f)
			echo $(($(ls --color=no -1 -l . | grep -v ^d | wc -l)-1))
		;;
		*)
			echo -e "\n${ewhite}Usage:"
			echo -e "\n${eorange}count_files${ewhite} | ${egreen}+h ${eiceblue}[count files and folders - include hidden ones] \
			\n${eorange}count_files${ewhite} | ${egreen}-h ${eiceblue}[count files and folders - exclude hidden ones] \
			\n${eorange}count_files${ewhite} | ${egreen}+d ${eiceblue}[count folders - include hidden ones] \
			\n${eorange}count_files${ewhite} | ${egreen}-d ${eiceblue}[count folders - exclude hidden ones] \
			\n${eorange}count_files${ewhite} | ${egreen}+f ${eiceblue}[count files - include hidden ones] \
			\n${eorange}count_files${ewhite} | ${egreen}-f ${eiceblue}[count files - exclude hidden ones]\n"
			tput sgr0
		;;
	esac
}

### find dead links - copyright 2007 - 2010 Christopher Bratusek
deadlink() {
	find -L -type l
}

### generate a random password
#   $1 = number of characters; defaults to 14
#   $2 = include special characters; 1 = yes, 0 = no; defaults to 1
# copyright 2007 - 2010 Christopher Bratusek
randompw() {
	if [[ $2 == "!" ]]; then
		echo $(cat /dev/urandom | tr -cd '[:graph:]' | head -c ${1:-14})
	else	echo $(cat /dev/urandom | tr -cd '[:alnum:]' | head -c ${1:-14})
	fi
}

### Counts files, subdirectories and directory size and displays details
lls() {
	echo -n "<`find . -maxdepth 1 -mindepth 1 -type f | wc -l | tr -d '[:space:]'` files>"
	echo -n " <`find . -maxdepth 1 -mindepth 1 -type d | wc -l | tr -d '[:space:]'` dirs/>"
	echo -n " <`find . -maxdepth 1 -mindepth 1 -type l | wc -l | tr -d '[:space:]'` links@>"
	echo " <~`du -sh . 2> /dev/null | cut -f1`>"
	ROWS=`stty size | cut -d' ' -f1`
	FILES=`find . -maxdepth 1 -mindepth 1 |
	wc -l | tr -d '[:space:]'`
}

### remove latex remnants
unlatex() {
    if [ "$1" == "" ]; then
        return
    fi
    i=${1%%.*}
    rm -f $i.aux $i.toc $i.lof $i.lot $i.los $i.?*~ $i.loa $i.log $i.bbl $i.blg $i.glo
    rm -f $i.odt $i.tns $i.fax $i.bm $i.out $i.nav $i.snm
    rm -f $i.mtc* $i.bmt
    rm -f $i.dvi $i.ps
    unset i
}

### general network information
netinfo ()
{
	echo "Internal IPv4 address: " `ifconfig | grep 'inet addr:'| grep -v '127.0.0.1' | cut -d: -f4 | awk '{ print $1}'`
    IPV4=`myipv4`
	echo "External IPv4 address: " $IPV4
	echo "Internal IPv6 address: " `ifconfig | grep 'inet6 addr:'| grep -v '1/128'|grep -v 'Scope:Link' | cut -d: -f5- | awk '{ print $1}'`
    IPV6TEST=`myipv6`
	if [ $IPV6TEST != $IPV4 ]; then
        echo "External IPv6 address: " $IPV6TEST
	fi
	echo "MAC: " `ifconfig | awk '/HWaddr/ { print $NF }'`
}

sourcedotenv ()
{
    if [ -f .env ]; then
        set -o allexport && source .env && set +o allexport
    fi
}

activate-venv() {
    # https://seb.jambor.dev/posts/improving-shell-workflows-with-fzf/
    local selected_env
    selected_env=$(ls -1 ~/.venv/ | fzf)

    if [ -n "$selected_env" ]; then
        source "$HOME/.venv/$selected_env/bin/activate"
    fi
}
