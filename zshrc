# ~/.zshrc extension

# ###################### #
# # set in main zsh file #
# ###################### #
# ZSH_THEME="powerlevel9k/powerlevel9k"
# POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(virtualenv context dir vcs)
# POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(root_indicator dir_writable background_jobs)
# POWERLEVEL9K_SHORTEN_DIR_LENGTH=1
# POWERLEVEL9K_SHORTEN_DELIMITER=""
# POWERLEVEL9K_SHORTEN_STRATEGY="truncate_from_right"
# HIST_STAMPS="yyyy-mm-dd"
# plugins=(git shrink-path)
# ######################## #

# confirm overwrite
#set -o noclobber
alias cp='cp -i'
alias mv='mv -i'

alias dug='du -h | grep ^[0-9.]*G | sort -rn | head -n 20 | cut -d: -f2'
alias dum='du -h | grep ^[0-9.]*M | sort -rn | head -n 20 | cut -d: -f2'

alias myinxi='inxi -CGiISs'

if [[ `uname` == 'Darwin' ]]; then
  if [[ -n `which gdu` ]]; then
    alias du='gdu'
    alias du0='gdu --max-depth=0'
    alias du1='gdu --max-depth=1'
  fi
else
  alias du0='du --max-depth=0'
  alias du1='du --max-depth=1'
fi

alias updatefonts='fc-cache -v -f'
alias linecount='wc -l $1'
alias wordcount='wc -w $1'
alias epochtime='date +%s'
alias timestamp='date "+%Y%m%dT%H%M%S"'
alias heute='date +"%A, %-d. %B %Y"'
alias KW='date +%V'
alias kalenderwoche='date +%V'
alias timer='echo "Timer started at $(date) - stop with Ctrl-D." && /usr/bin/time --format "Time: %E" cat && date'

### cat a file without comments
catnocomment ()
{
        if [ $# -lt 1 ] || [ $# -gt 2 ]; then
                echo "please specify file"
        else
                egrep -a -v '^[[:space:]]*#' $1 | egrep -a '[[:print:]]'
        fi
}


