# ~/.zshrc extension

# ###################### #
# # set in main zsh file #
# ###################### #
# if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
#   source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
# fi
# export ZSH="$HOME/.oh-my-zsh"
# ZSH_THEME="powerlevel10k/powerlevel10k"
# ######################## #

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

## LOAD COMMON ALIASES
source ${HOME}/${FACTER_dotfiles}/alias.sh
