# ~/.bashrc EXTENSION

source ~/.git-prompt.sh
export GIT_PS1_SHOWDIRTYSTATE=1
export GIT_PS1_SHOWUPSTREAM="auto"
export PS1="\[\033[00;33m\]\u\[\033[37m\]@\[\033[00;32m\]\h\[\033[00m\]:\[\033[36m\]\w\[\033[00m\]\[\033[01;33m\]\$(__git_ps1)\[\033[00m\]\$ "

if [ "$TERM" = screen ]; then
    stty erase '^H'
fi

PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}\007"'

export HISTCONTROL=ignoreboth
export HISTTIMEFORMAT="%F %T "
export HISTSIZE='32768'
shopt -s histappend

PROMPT_COMMAND=${PROMPT_COMMAND:=default_value}

if [ "$PROMPT_COMMAND" != "default_value" ]; then
 PROMPT_COMMAND="$PROMPT_COMMAND;history -a"
else
 PROMPT_COMMAND="history -a"
fi

# load come completion if commands are installed
if command -v minikube &> /dev/null
then
  source <(minikube completion bash)
fi
if command -v kubectl &> /dev/null
then
  source <(kubectl completion bash)
fi
if command -v helm &> /dev/null
then
  source <(helm completion bash)
fi

## LOAD COMMON ALIASES
source alias.sh
