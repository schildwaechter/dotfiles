#!/bin/bash

if which puppet > /dev/null ; then
  export FACTER_puppetbin=`which puppet`
elif [[ -x "/opt/puppetlabs/bin/puppet" ]] ; then
  export FACTER_puppetbin=/opt/puppetlabs/bin/puppet
else
  echo "No puppet binary found!"
  exit 1
fi

export FACTER_homedir=$HOME
export FACTER_dotfiles=${DOTFILES:=".dotfiles"}
: ${DOTSECRETS:=".dotsecrets"}
if [ -e "${HOME}/${DOTSECRETS}" ] ; then
  export FACTER_dotsecrets=$DOTSECRETS
fi

$FACTER_puppetbin apply --show_diff \
  --modulepath $HOME/$FACTER_dotfiles/puppet/modules \
  --hiera_config $HOME/$FACTER_dotfiles/puppet/hiera.yaml \
  --show_diff $HOME/$FACTER_dotfiles/puppet/manifest.pp

if [[ $# -eq 0 ]] ; then
  echo '---'
  echo 'Please log out and back in to apply all changes!'
  echo ''
fi

