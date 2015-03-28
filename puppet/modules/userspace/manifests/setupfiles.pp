class userspace::setupfiles {

  $simpledotfilelinks = [
    'dircolors',
    'locale',
    'screenrc',
    'toprc',
    'vim', 'vimrc', 'gvimrc',
  ]
  userspace::simpledotfilelink { $simpledotfilelinks : }

  userspace::dotfilelink { 'powerline-symbols':
    targetfile => "${::dotfiles}/powerline-symbols.conf",
    linkfile   => '.config/fontconfig/conf.d/10-powerline-symbols.conf',
  }
  file { "${::homedir}/.local/share/applications/mimeapps.list":
    ensure => present,
    source => "${::homedir}/${::dotfiles}/local-mimeapps.list",
    backup => true,
  }
  userspace::dotfilelink { 'conkyrc':
    targetfile => $userspace::conkyrc,
    linkfile   => '.conkyrc',
  }
  file { "${::homedir}/.bashrc_dotfiles":
    ensure  => present,
    content => "# ~/.bashrc EXTENSION
# ###################
# INSTALLED BY PUPPET
# ###################
dotfiles ()
{
  case \$1 in
    *upgrade)
      echo \"Running 'puppet apply'\" 
      /bin/bash ${::homedir}/${::dotfiles}/install.sh autorun
    ;;
    *update)
      cd ${::homedir}/${::dotfiles} && git pull && git submodule init && git submodule sync && git submodule update && cd -
    ;;
    *status)
      cd ${::homedir}/${::dotfiles} && git status && cd -
    ;;
    *software)
      echo \"Running 'sudo puppet apply'\" 
      env FACTER_dotfilespath=${::homedir}/${::dotfiles} sudo -E puppet apply \\
        --modulepath ${::homedir}/${::dotfiles}/puppet/modules \\
        --hiera_config ${::homedir}/${::dotfiles}/puppet/hiera.yaml \\
        ${::homedir}/${::dotfiles}/puppet/manifest.pp
    ;;
    *)
      echo -e \"Usage:\"
      echo -e \"dotfiles upgrade  [install dotfiles via puppet apply] \"
      echo -e \"dotfiles update   [update dotfile repository] \"
      echo -e \"dotfiles status   [check dotfiles repository status] \"
      echo -e \"dotfiles software [install software via sudo puppet apply] \\n\"
      tput sgr0
    ;;
  esac
}
_dotfiles()
{
    local cur=\${COMP_WORDS[COMP_CWORD]}
    COMPREPLY=( \$(compgen -W \"upgrade update status software\" -- \$cur) )
}
complete -F _dotfiles dotfiles


export DEBFULLNAME='${userspace::displayname}'
export DEBEMAIL='${userspace::mailaddress}'

# ###############
# DO EDITS THERE:
. ~/${::dotfiles}/bashrc
    "
  }

  exec { 'install_bashrc_dotfiles':
    path    => ['/usr/bin','/bin','/usr/sbin'],
    command => "echo \"
# THE FOLLOWING IS ADDED BY PUPPET !!!
# uncomment to disable (deleting is futile)
if [ -f ~/.bashrc_dotfiles ]; then
    . ~/.bashrc_dotfiles
fi
   \" >> ${::homedir}/.bashrc",
    unless  => "grep 'bashrc_dotfiles' ${::homedir}/.bashrc",
  }

  file { "${::homedir}/.profile_dotfiles":
    ensure  => present,
    content => inline_template("# ~/.profile EXTENSION
# ###################
# INSTALLED BY PUPPET
# ###################
export FACTER_homedir=\$HOME
export FACTER_dotfiles=<%= scope['::dotfiles'] %>
<% if scope['::userspace::include_dotsecrets'] == true -%>
export FACTER_dotsecrets=<%= scope['::dotsecrets'] %>
<% end -%>

# ###############
# DO EDITS THERE:
. \$HOME/<%= scope['::dotfiles'] %>/profile
    "),
  }

  exec { 'install_profile_dotfiles':
    path    => ['/usr/bin','/bin','/usr/sbin'],
    command => "echo \"
# THE FOLLOWING IS ADDED BY PUPPET !!!
# uncomment to disable (deleting is futile)
if [ -f \\\$HOME/.profile_dotfiles ]; then
    . \\\$HOME/.profile_dotfiles
fi
   \" >> ${::homedir}/.profile",
    unless  => "grep 'profile_dotfiles' ${::homedir}/.profile",
  }

  file { "${::homedir}/.gitconfig":
    ensure  => present,
    content => "[user]
    name = ${userspace::displayname}
    email = ${userspace::mailaddress}

[diff]
    external = ${::homedir}/.bin/gitdiff.py

[include]
    path = ${::homedir}/${::dotfiles}/gitconfig
    "
  }

  userspace::dotfilessh { $userspace::sshkeys :
    require => File["${::homedir}/.ssh"],
  }

  file {"${::homedir}/.ssh":
    ensure => directory,
    mode   => '0700',
  }
  userspace::dotfilelink { 'ssh_config':
    targetfile => "${::dotsecrets}/ssh/config",
    linkfile   => '.ssh/config',
    require => File["${::homedir}/.ssh"],
  }
  
  $dotfileexecutables = [
    'gitdiff.py',
    'myipv4',
    'myipv6',
    'colog',
    'gtk_cleanup.py',
  ]
  userspace::dotfileexecutable { $dotfileexecutables: }

  file { "${::homedir}/.config/xfce4/terminal/terminalrc":
    ensure  => present,
    source => "${::homedir}/${::dotfiles}/xfce4-terminalrc",
  }

  file { "${::homedir}/.grip/settings.py":
    ensure  => present,
    content => "PASSWORD = '${userspace::grip_github_token}'"
  }

}


