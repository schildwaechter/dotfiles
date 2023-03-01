# ~/.profile EXTENSION
#
if [[ `uname` == 'Darwin' ]]; then
  # Mac is fuzzy on locales
  export LC_ALL=en_GB.UTF-8
  export LANG=en_GB.UTF-8

  # iterm2 color settings
  export CLICOLOR=1
  export TERM=xterm-256color
else
  source "$HOME/.locale"
fi

# private ruby 1.9.1 gems
if [ -d "$HOME/.gem/ruby/1.9.1/bin" ] ; then
    PATH="$HOME/.gem/ruby/1.9.1/bin:$PATH"
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

export TEXINPUTS
export BSTINPUTS
export TEXCONFIG
export TEXFONTS

export DOTNET_CLI_TELEMETRY_OPTOUT="1"
