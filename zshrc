# ~/.zshrc extension

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Set the directory we want to store zinit and plugins
ZINIT_HOME="${HOME}/.local/share/zinit/zinit.git"

# Source/Load zinit
source "${ZINIT_HOME}/zinit.zsh"


# Add in Powerlevel10k
zinit ice depth=1; zinit light romkatv/powerlevel10k

# Add in zsh plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab

# Add in snippets
zinit snippet OMZP::git
zinit snippet OMZP::sudo
zinit snippet OMZP::kubectl
zinit snippet OMZP::kubectx
zinit snippet OMZP::command-not-found

# Load completions
autoload -Uz compinit && compinit


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

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
