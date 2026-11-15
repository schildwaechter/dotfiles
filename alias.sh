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
export GROFF_NO_SGR=1 # for konsole and gnome-terminal
export MANPAGER='less -s -M +Gg'

# https://unix.stackexchange.com/a/302391
# Prefer nvim over vim over vi
EDITOR="$(command -v nvim 2>/dev/null || command -v vim 2>/dev/null || command -v vi)"
export EDITOR
# we have gvim, not in an SSH term, and the X11 display number is under 10
if command -v gvim >/dev/null 2>&1 &&
  [ "$SSH_TTY$DISPLAY" = "${DISPLAY#*:[1-9][0-9]}" ]; then
  VISUAL="$(command -v gvim) -f"
  export VISUAL
  SUDO_EDITOR="$VISUAL"
else
  SUDO_EDITOR="$EDITOR"
fi
export SUDO_EDITOR

export BROWSER="firefox"

export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:="${HOME}/.config"}"

# confirm overwrite
#set -o noclobber
alias cp='cp -i'
alias mv='mv -i'

# identify operating system
is_debian_family() {
  local ID ID_LIKE
  [[ -r /etc/os-release ]] || return 1
  # shellcheck source=/dev/null
  source /etc/os-release
  [[ "$ID" == "debian" || "$ID_LIKE" == *"debian"* || "$ID_LIKE" == *"ubuntu"* ]]
}

is_arch_family() {
  local ID ID_LIKE
  [[ -r /etc/os-release ]] || return 1
  # shellcheck source=/dev/null
  source /etc/os-release
  [[ "$ID" == "arch" || "$ID" == "cachyos" || "$ID_LIKE" == *"arch"* ]]
}

is_macos() {
  [[ "$(uname -s)" == "Darwin" ]]
}


if command -v wl-copy >/dev/null 2>&1 && [[ -n "${WAYLAND_DISPLAY:-}" ]]; then
  alias pc="pwd | wl-copy"
elif command -v pbcopy >/dev/null 2>&1; then
  alias pc="pwd | pbcopy"
elif command -v xsel >/dev/null 2>&1; then
  alias ps="pwd | xsel --clipboard"
fi

if is_arch_family; then
  alias apt='man pacman'
  alias apt-get="man pacman"
fi

if is_debian_family; then
  alias pacman='man apt'
fi

if is_macos; then
  alias apt='man brew'
  alias pacman='man brew'
fi

if command -v gdircolors >/dev/null 2>&1; then
  if [ -r ~/.dircolors ]; then
    eval "$(gdircolors -b ~/.dircolors)"
  else
    eval "$(gdircolors -b)"
  fi

  alias grepc='grep -n --color=auto'
  alias fgrepc='grep -F -n --color=auto'
  alias egrepc='grep -E -n --color=auto'
elif command -v dircolors >/dev/null 2>&1; then
  if [ -r ~/.dircolors ]; then
    eval "$(dircolors -b ~/.dircolors)"
  else
    eval "$(dircolors -b)"
  fi

  alias grepc='grep -n --color=auto'
  alias fgrepc='grep -F -n --color=auto'
  alias egrepc='grep -E -n --color=auto'
fi

if [[ $(uname) == 'Darwin' ]]; then
  if command -v gls >/dev/null 2>&1; then
    alias ls='gls -CF    --color=auto'
    alias ks='gls -CF    --color=auto'
    alias l='gls  -lF    --color=auto --time-style=+\ %d.%m.%Y\ %R'
    alias la='gls -ACF   --color=auto'
    alias ll='gls -alF   --color=auto --time-style=+\ %d.%m.%Y\ %R'
    alias lt='gls -alrtF --color=auto --time-style=+\ %d.%m.%Y\ %R'
    alias l.='gls --color=auto -d .[[:alnum:]]* 2> /dev/null || echo "No hidden file here..."' # list only hidden files
  else
    alias ls='ls -CF'
    alias ks='ls -CF'
    alias l='ls  -lF'
    alias la='ls -ACF'
    alias ll='ls -alF'
    alias lt='ls -alrtF'
    alias l.='ls -d .[[:alnum:]]* 2> /dev/null || echo "No hidden file here..."' # list only hidden files
  fi
else
  alias ls='ls -CF    --color=auto'
  alias ks='ls -CF    --color=auto'
  alias l='ls  -lF    --color=auto --time-style=+\ %d.%m.%Y\ %R'
  alias la='ls -ACF   --color=auto'
  alias ll='ls -alF   --color=auto --time-style=+\ %d.%m.%Y\ %R'
  alias lt='ls -alrtF --color=auto --time-style=+\ %d.%m.%Y\ %R'
  alias l.='ls -d .[[:alnum:]]* 2> /dev/null || echo "No hidden file here..."' # list only hidden files
fi

alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ..2='cd ../..'
alias ..3='cd ../../..'
alias ..4='cd ../../../..'

alias myinxi='inxi -CDGIMPRS'

if [[ $(uname) == 'Darwin' ]]; then
  if command -v gdu >/dev/null 2>&1; then
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
alias epochtime='date +%s'
alias timestamp='date "+%Y%m%dT%H%M%S"'
alias heute='date +"%A, %-d. %B %Y"'
alias KW='date +%V'
alias kalenderwoche='date +%V'
alias timer='echo "Timer started at $(date) - stop with Ctrl-D." && /usr/bin/time --format "Time: %E" cat && date'

alias ccat='pygmentize -g'

alias v='nvim'
alias k='kubectl'
alias wk='watch kubectl'
alias tf='terraform'
alias kubcetl='kubectl'
alias terrafrom='terraform'
alias yless="jless --yaml"

if [[ $(uname) == 'Darwin' ]]; then
  alias code="open -a 'Visual Studio Code'"
fi

##############################################
#### lots of functions ...

### cat a file without comments
catnocomment() {
  if [ $# -lt 1 ] || [ $# -gt 2 ]; then
    echo "please specify file"
  else
    grep -E -a -v '^[[:space:]]*#' "$1" | grep -E -a '[[:print:]]'
  fi
}

### colourful less
cless() {
  pygmentize -g "$1" | less -R
}

grepp() {
  if [ $# -eq 1 ]; then
    perl -00ne "print if /$1/i"
  else
    perl -00ne "print if /$1/i" <"$2"
  fi
}

hgg() {
  if [ $# -lt 1 ] || [ $# -gt 1 ]; then
    echo "search shell history"
    echo "usage: hgg [search pattern]"
  else
    history | grep -i "$1" | grep -v hg
  fi
}

# countfiles copyright 2007 - 2010 Christopher Bratusek
countfiles() {
  local ewhite eorange egreen eiceblue reset
  ewhite=$'\e[1;37m'
  eorange=$'\e[38;5;208m'
  egreen=$'\e[32m'
  eiceblue=$'\e[38;5;81m'
  reset=$'\e[0m'

  case $1 in
  *+h)
    printf '%s\n' "$(find . -maxdepth 1 -mindepth 1 \( -type f -o -type d \) | wc -l | tr -d '[:space:]')"
    ;;
  *-h)
    printf '%s\n' "$(find . -maxdepth 1 -mindepth 1 \( -type f -o -type d \) ! -name '.*' | wc -l | tr -d '[:space:]')"
    ;;
  *+d)
    printf '%s\n' "$(find . -maxdepth 1 -mindepth 1 -type d | wc -l | tr -d '[:space:]')"
    ;;
  *-d)
    printf '%s\n' "$(find . -maxdepth 1 -mindepth 1 -type d ! -name '.*' | wc -l | tr -d '[:space:]')"
    ;;
  *+f)
    printf '%s\n' "$(find . -maxdepth 1 -mindepth 1 -type f | wc -l | tr -d '[:space:]')"
    ;;
  *-f)
    printf '%s\n' "$(find . -maxdepth 1 -mindepth 1 -type f ! -name '.*' | wc -l | tr -d '[:space:]')"
    ;;
  *)
    printf '\n%sUsage:\n' "$ewhite"
    printf '\n%scount_files%s | %s+h %s[count files and folders - include hidden ones]\n' "$eorange" "$ewhite" "$egreen" "$eiceblue"
    printf '%scount_files%s | %s-h %s[count files and folders - exclude hidden ones]\n' "$eorange" "$ewhite" "$egreen" "$eiceblue"
    printf '%scount_files%s | %s+d %s[count folders - include hidden ones]\n' "$eorange" "$ewhite" "$egreen" "$eiceblue"
    printf '%scount_files%s | %s-d %s[count folders - exclude hidden ones]\n' "$eorange" "$ewhite" "$egreen" "$eiceblue"
    printf '%scount_files%s | %s+f %s[count files - include hidden ones]\n' "$eorange" "$ewhite" "$egreen" "$eiceblue"
    printf '%scount_files%s | %s-f %s[count files - exclude hidden ones]\n%s' "$eorange" "$ewhite" "$egreen" "$eiceblue" "$reset"
    ;;
  esac
}

### find dead links - copyright 2007 - 2010 Christopher Bratusek
deadlink() {
  find -L . -type l
}

### generate a random password
#   $1 = number of characters; defaults to 14
#   $2 = include special characters; 1 = yes, 0 = no; defaults to 1
# copyright 2007 - 2010 Christopher Bratusek
randompw() {
  if [[ $2 == "!" ]]; then
    tr -cd '[:graph:]' < /dev/urandom | head -c "${1:-14}"
  else
    tr -cd '[:alnum:]' < /dev/urandom | head -c "${1:-14}"
  fi
}

### Counts files, subdirectories and directory size and displays details
lls() {
  printf '<%s files>' "$(find . -maxdepth 1 -mindepth 1 -type f | wc -l | tr -d '[:space:]')"
  printf ' <%s dirs/>' "$(find . -maxdepth 1 -mindepth 1 -type d | wc -l | tr -d '[:space:]')"
  printf ' <%s links@>' "$(find . -maxdepth 1 -mindepth 1 -type l | wc -l | tr -d '[:space:]')"
  printf ' <~%s>\n' "$(du -sh . 2>/dev/null | cut -f1)"
}

### remove latex remnants
unlatex() {
  if [ -z "$1" ]; then
    return
  fi
  local i
  i=${1%%.*}
  rm -f "$i".aux "$i".toc "$i".lof "$i".lot "$i".los "$i".?*~ "$i".loa "$i".log "$i".bbl "$i".blg "$i".glo
  rm -f "$i".odt "$i".tns "$i".fax "$i".bm "$i".out "$i".nav "$i".snm
  rm -f "$i".mtc* "$i".bmt
  rm -f "$i".dvi "$i".ps
}

### general network information
netinfo() {
  local IPV4 IPV6TEST
  printf 'Internal IPv4 address:  %s\n' "$(ifconfig | grep 'inet addr:' | grep -v '127.0.0.1' | cut -d: -f4 | awk '{ print $1}')"
  IPV4=$(myipv4)
  printf 'External IPv4 address:  %s\n' "$IPV4"
  printf 'Internal IPv6 address:  %s\n' "$(ifconfig | grep 'inet6 addr:' | grep -v '1/128' | grep -v 'Scope:Link' | cut -d: -f5- | awk '{ print $1}')"
  IPV6TEST=$(myipv6)
  if [ "$IPV6TEST" != "$IPV4" ]; then
    printf 'External IPv6 address:  %s\n' "$IPV6TEST"
  fi
  printf 'MAC:  %s\n' "$(ifconfig | awk '/HWaddr/ { print $NF }')"
}

sourcedotenv() {
  if [ -f .env ]; then
    set -o allexport
    # shellcheck source=/dev/null
    source .env
    local rc=$?
    set +o allexport
    return $rc
  fi
}

activate-venv() {
  # https://seb.jambor.dev/posts/improving-shell-workflows-with-fzf/
  local selected_env
  selected_env=$(find ~/.venv -maxdepth 1 -mindepth 1 -type d | sed 's|.*/||' | fzf)

  if [ -n "$selected_env" ]; then
    # shellcheck source=/dev/null
    source "$HOME/.venv/$selected_env/bin/activate"
  fi
}
