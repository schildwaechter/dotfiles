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
HISTSIZE=50000
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
export BAT_THEME="Solarized (dark)"

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

export LESSCHARSET=utf-8

export KUBECTL_KYAML=true

k8sdebugshell() {
    if ! kubectl get pod --namespace carsten-debug k8sdebugger > /dev/null 2>&1; then
      if ! kubectl get namespace carsten-debug > /dev/null 2>&1; then
        kubectl create namespace carsten-debug
      fi
      kubectl run --namespace carsten-debug k8sdebugger --image=schildwaechter/k8sdebugger \
        --overrides='{
            "apiVersion": "v1",
            "spec": {
              "containers": [
                {
                  "name": "k8sdebugger",
                  "image": "docker.io/schildwaechter/k8sdebugger:latest",
                  "resources": {
                    "limits": {
                      "memory": "100Mi"
                    },
                    "requests": {
                      "cpu": "5m",
                      "memory": "10Mi"
                    }
                  },
                  "command": [
                    "/bin/bash"
                  ],
                  "args": [
                    "-c",
                    "--",
                    "while true; do sleep 30; done;"
                  ]
                }
              ],
              "terminationGracePeriodSeconds": 0
            }
          }'
      kubectl wait --namespace carsten-debug --for=condition=Ready pod/k8sdebugger
    fi
    #POD=$(kubectl get pods --namespace carsten-debug -l "app=k8sdebugger" -o jsonpath="{.items[0].metadata.name}")
    kubectl --namespace carsten-debug exec --stdin --tty k8sdebugger -- /bin/bash
}

bindkey "\e[3~"  delete-char

bindkey  "^[[1;3A"  beginning-of-line
bindkey  "^[[1;3B"  end-of-line

bindkey  "^[[H"  beginning-of-line
bindkey  "^[[F"  end-of-line
bindkey "^[^[[C" forward-word  ## mac with option/alt
bindkey "^[^[[D" backward-word ## mac with option/alt
export WORDCHARS='*?_[]~=&;!#$%^(){}<>'

# bindkey -v # vi key bindings
# export KEYTIMEOUT=1
#
# # v in normal node launches vim
# export EDITOR='nvim'
# autoload edit-command-line
# zle -N edit-command-line
# bindkey -M vicmd v edit-command-line
#
# export VI_MODE_SET_CURSOR=true
#
# function zle-keymap-select {
#   if [[ ${KEYMAP} = vicmd ]]; then
#     echo -ne '\e[2 q' # block
#   else
#     echo -ne '\e[6 q' # beam
#   fi
# }
# zle -N zle-keymap-select
#
# function zle-line-init() {
#   zle -K viins
#   echo -ne '\e[6 g'
# }
# zle -N zle-line-init
#
# # yank to system
# function vi-yank-clipboard {
#   zle vi-yank
#   echo "${CUTBUFFER}" | pbcopy -i
# }
# zle -N vi-yank-clipboard
# bindkey -M vicmd 'y' vi-yank-clipboard

