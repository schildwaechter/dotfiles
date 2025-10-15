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

## LOAD COMMON ALIASES
source ${HOME}/${FACTER_dotfiles}/alias.sh

# History settings
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

# no magic
unsetopt autocd extendedglob

# error when globs don't match anything
setopt nomatch

# non-vim motions in prompt
bindkey -e

alias loadhistory='fc -RI'
export POWERLEVEL9K_INSTANT_PROMPT=quiet

# completion fall-back to case insensitive
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'

# FZF solarized dark
export FZF_DEFAULT_OPTS="
    --color=bg+:#073642,bg:#002b36,spinner:#2aa198,hl:#268bd2
    --color=fg:#839496,header:#268bd2,info:#b58900,pointer:#2aa198
    --color=marker:#2aa198,fg+:#eee8d5,prompt:#b58900,hl+:#268bd2"

# FZF rose-pine
# export FZF_DEFAULT_OPTS="
#     --color=fg:$subtle,bg:$base,hl:$rose
#     --color=fg+:$text,bg+:$overlay,hl+:$rose
#     --color=border:$highlightMed,header:$pine,gutter:$base
#     --color=spinner:$gold,info:$foam
#     --color=pointer:$iris,marker:$love,prompt:$subtle"

export KUBECTL_KYAML=true
