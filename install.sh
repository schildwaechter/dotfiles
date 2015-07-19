#!/bin/bash
export FACTER_homedir=$HOME 
export FACTER_dotfiles=${DOTFILES:=".dotfiles"}
: ${DOTSECRETS:=".dotsecrets"}
if [ -e "${HOME}/${DOTSECRETS}" ] ; then
  export FACTER_dotsecrets=$DOTSECRETS
fi

puppet apply \
  --modulepath $HOME/$FACTER_dotfiles/puppet/modules \
  --hiera_config $HOME/$FACTER_dotfiles/puppet/hiera.yaml \
  --show_diff $HOME/$FACTER_dotfiles/puppet/manifest.pp

if [[ $# -eq 0 ]] ; then
  echo '---'
  echo 'Please log out and back in to apply all changes!'
  echo ''
fi
