class userspace::setupfiles {

  $simpledotfilelinks = [
    'ctags',
    'dircolors',
    'locale',
    'screenrc',
    'toprc',
    'vim', 'vimrc', 'gvimrc',
  ]
  userspace::simpledotfilelink { $simpledotfilelinks : }

  if $::operatingsystem == 'Ubuntu' {
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
  }

  if $::operatingsystem == 'Ubuntu' {
    $gmvimalias = "alias mvim='gvim'"
  } elsif $::operatingsystem == 'Darwin' {
    $gmvimalias = "alias gvim='mvim'"
  }

  file { "${::homedir}/.bashrc_dotfiles":
    ensure  => present,
    content => inline_template("# ~/.bashrc EXTENSION
# ###################
# INSTALLED BY PUPPET
# ###################
dotfiles ()
{
  case \$1 in
    *upgrade)
      echo \"Running 'puppet apply'\"
      /bin/bash <%= scope['::homedir'] %>/<%= scope['::dotfiles'] %>/install.sh autorun
    ;;
    *update)
      cd <%= scope['::homedir'] %>/<%= scope['::dotfiles'] %> && git pull && git submodule init && git submodule sync && git submodule update && cd -
    ;;
    *status)
      cd <%= scope['::homedir'] %>/<%= scope['::dotfiles'] %> && git status && cd -
    ;;
<% if scope['::operatingsystem'] == 'Ubuntu' -%>
    *software)
      echo \"Running 'sudo puppet apply'\"
      env FACTER_dotfilespath=<%= scope['::homedir'] %>/<%= scope['::dotfiles'] %> sudo -E <%= scope['::puppetbin'] %> apply \\
        --modulepath <%= scope['::homedir'] %>/<%= scope['::dotfiles'] %>/puppet/modules --show_diff \\
        --hiera_config <%= scope['::homedir'] %>/<%= scope['::dotfiles'] %>/puppet/hiera.yaml \\
        <%= scope['::homedir'] %>/<%= scope['::dotfiles'] %>/puppet/manifest.pp
    ;;
<% end -%>
    *)
      echo -e \"Usage:\"
      echo -e \"dotfiles upgrade  [install dotfiles via puppet apply] \"
      echo -e \"dotfiles update   [update dotfile repository] \"
      echo -e \"dotfiles status   [check dotfiles repository status] \"
<% if scope['::operatingsystem'] == 'Ubuntu' -%>
      echo -e \"dotfiles software [install software via sudo puppet apply] \\n\"
<% else -%>
      echo -e \"\nSoftware is managed through boxen!\"
<% end -%>
      tput sgr0
    ;;
  esac
}
_dotfiles()
{
    local cur=\${COMP_WORDS[COMP_CWORD]}
<% if scope['::operatingsystem'] == 'Ubuntu' -%>
    COMPREPLY=( \$(compgen -W \"upgrade update status software\" -- \$cur) )
<% else -%>
    COMPREPLY=( \$(compgen -W \"upgrade update status\" -- \$cur) )
<% end -%>
}
complete -F _dotfiles dotfiles

<%= scope['::userspace::setupfiles::gmvimalias'] %>

export DEBFULLNAME='<%= scope['::userspace::displayname'] %>'
export DEBEMAIL='<%= scope['::userspace::mailaddress'] %>'

# ###############
# DO EDITS THERE:
. ~/<%= scope['::dotfiles'] %>/bashrc
    "),
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
export FACTER_puppetbin=<%= scope['::puppetbin'] %>
<% if scope['::dotsecrets'] -%>
export FACTER_dotsecrets=<%= scope['::dotsecrets'] %>
<% end -%>

# ###############
# DO EDITS THERE:
source \$HOME/<%= scope['::dotfiles'] %>/profile
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
    content =>  inline_template("[user]
    name = <%= scope['::userspace::displayname'] %>
    email = <%= scope['::userspace::mailaddress']%>

[diff]
    external = <%= scope['::homedir']%>/.bin/gitdiff.py

[include]
    path = <%= scope['::homedir']%>/<%= scope['::dotfiles']%>/gitconfig

<% if scope['::operatingsystem'] == 'Darwin' -%>
[core]
    editor = /usr/bin/vim
<% if scope['::boxen'] == 'true' -%>
    excludesfile = /opt/boxen/config/git/gitignore

[credential]
    helper = /opt/boxen/bin/boxen-git-credential
<% end -%>
<% end -%>
    ")
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

  if $::operatingsystem == 'Ubuntu' {
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
  } elsif $::operatingsystem == 'Darwin' {
    $dotfileexecutables = [
      'gitdiff.py',
    ]
    userspace::dotfileexecutable { $dotfileexecutables: }
  }

  file { "${::homedir}/.grip/settings.py":
    ensure  => present,
    content => "PASSWORD = '${userspace::grip_github_token}'"
  }

  remote_file { "${::homedir}/.git-prompt.sh":
    ensure => present,
    source => 'https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh',
  }

}


