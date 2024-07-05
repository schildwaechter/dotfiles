# ~/.zshrc extension

# load come completion if commands are installed
if command -v minikube &> /dev/null
then
  source <(minikube completion zsh)
fi
if command -v kubectl &> /dev/null
then
  source <(kubectl completion zsh)
fi
if command -v helm &> /dev/null
then
  source <(helm completion zsh)
fi
if command -v direnv &> /dev/null
then
  eval "$(direnv hook zsh)"
fi
if command -v fzf &> /dev/null
then
  eval "$(fzf --zsh)"
fi
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

if [ -d /opt/homebrew/share/zsh/site-functions ]; then
  fpath=(/opt/homebrew/share/zsh/site-functions $fpath)
fi

if [ -d /usr/local/share/zsh/site-functions ]; then
  fpath=(/usr/local/share/zsh/site-functions $fpath)
fi

## LOAD COMMON ALIASES
source ${HOME}/${FACTER_dotfiles}/alias.sh

# History
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups
unsetopt share_history
setopt inc_append_history

alias loadhistory='fc -RI'
export POWERLEVEL9K_INSTANT_PROMPT=quiet
