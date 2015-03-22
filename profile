# ~/.profile EXTENSION
#
if [ -d "$HOME/.gem/ruby/1.9.1/bin" ] ; then
    PATH="$HOME/.gem/ruby/1.9.1/bin:$PATH"
fi

if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

if [ -d "$HOME/.bin" ] ; then
    PATH="$HOME/.bin:$PATH"
fi

PATH=".:$PATH"
export PATH

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

. "$HOME/.locale"
