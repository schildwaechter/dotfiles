# ~/.profile EXTENSION
#
if [[ `uname` == 'Darwin' ]]; then
    # Mac is fuzzy on locales
    export LC_ALL=en_GB.UTF-8
    export LANG=en_GB.UTF-8
    export CLICOLOR=1
else
    source "$HOME/.locale"
fi

# add gopath to path
if command -v go &> /dev/null ; then
    PATH="$(go env GOPATH)/bin:$PATH"
fi

# add personal bin dirs to path
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

if [ -d "$HOME/.bin" ] ; then
    PATH="$HOME/.bin:$PATH"
fi

PATH=".:$PATH"
export PATH

# custom TeX files
if [ -d $HOME/.TeX ]; then
    TEXINPUTS=".:$HOME/.TeX//:$TEXINPUTS"
    BSTINPUTS=".:$HOME/.TeX//:$BSTINPUTS"
    TEXCONFIG=".:$HOME/.TeX//:$TEXCONFIG"
    TEXFONTS=".:$HOME/.TeX//:$TEXFONTS"
fi

export PAPERSIZE="a4"

export TEXINPUTS
export BSTINPUTS
export TEXCONFIG
export TEXFONTS

export DOTNET_CLI_TELEMETRY_OPTOUT="1"
export HOMEBREW_NO_ANALYTICS=1
