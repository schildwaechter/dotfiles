class userspace::setupfiles {

  $simpledotfilelinks = [
    'ctags',
    'editorconfig',
    'dircolors',
    'inputrc',
    'locale',
    'p10k.zsh',
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

<% if scope['::operatingsystem'] == 'Ubuntu' -%>
alias mvim='gvim'
<% end -%>

export DEBFULLNAME='<%= scope['::userspace::displayname'] %>'
export DEBEMAIL='<%= scope['::userspace::mailaddress'] %>'

# ###############
# DO EDITS THERE:
. ~/<%= scope['::dotfiles'] %>/bashrc
    "),
  }

  file { "${::homedir}/.zshrc_dotfiles":
    ensure  => present,
    content => inline_template("# ~/.zshrc EXTENSION
# ###################
# INSTALLED BY PUPPET
# ###################
autoload -U +X compinit && compinit
autoload -U +X bashcompinit && bashcompinit

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

<% if scope['::operatingsystem'] == 'Ubuntu' -%>
alias mvim='gvim'
<% end -%>
<% if scope['::operatingsystem'] == 'Darwin' -%>
source ~/.profile
if [ -d \"/Applications/MacVim.app/Contents/bin\" ] ; then
  PATH=\"/Applications/MacVim.app/Contents/bin:\$PATH\"
fi
<% end -%>

export DEBFULLNAME='<%= scope['::userspace::displayname'] %>'
export DEBEMAIL='<%= scope['::userspace::mailaddress'] %>'

# ###############
# DO EDITS THERE:
. ~/<%= scope['::dotfiles'] %>/zshrc
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

  exec { 'install_zshrc_dotfiles':
    path    => ['/usr/bin','/bin','/usr/sbin'],
    command => "echo \"
# THE FOLLOWING IS ADDED BY PUPPET !!!
# uncomment to disable (deleting is futile)
if [ -f ~/.zshrc_dotfiles ]; then
    . ~/.zshrc_dotfiles
fi
   \" >> ${::homedir}/.zshrc",
    unless  => "grep 'zshrc_dotfiles' ${::homedir}/.zshrc",
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
  tool = meld

[difftool]
  prompt = false

[include]
  path = <%= scope['::homedir']%>/<%= scope['::dotfiles']%>/gitconfig

[init]
  templatedir = <%= scope['::homedir']%>/<%= scope['::dotfiles']%>/bin/git-templates/

[core]
  excludesfile = <%= scope['::homedir']%>/<%= scope['::dotfiles']%>/gitignore_global
<% if scope['::operatingsystem'] == 'Darwin' -%>
  editor = vim
<% end -%>
    ")
  }

  file { "${::homedir}/.ssh/config":
    ensure  => present,
    content =>  inline_template("# ssh config following mozilla guidelines - https://infosec.mozilla.org/guidelines/openssh.html
# Ensure KnownHosts are unreadable if leaked - it is otherwise easier to know which hosts your keys have access to.
HashKnownHosts yes
# Host keys the client accepts - order here is honored by OpenSSH
HostKeyAlgorithms ssh-ed25519-cert-v01@openssh.com,ssh-rsa-cert-v01@openssh.com,ssh-ed25519,ssh-rsa,ecdsa-sha2-nistp521-cert-v01@openssh.com,ecdsa-sha2-nistp384-cert-v01@openssh.com,ecdsa-sha2-nistp256-cert-v01@openssh.com,ecdsa-sha2-nistp521,ecdsa-sha2-nistp384,ecdsa-sha2-nistp256

KexAlgorithms curve25519-sha256@libssh.org,ecdh-sha2-nistp521,ecdh-sha2-nistp384,ecdh-sha2-nistp256,diffie-hellman-group-exchange-sha256
MACs hmac-sha2-512-etm@openssh.com,hmac-sha2-256-etm@openssh.com,umac-128-etm@openssh.com,hmac-sha2-512,hmac-sha2-256,umac-128@openssh.com
Ciphers chacha20-poly1305@openssh.com,aes256-gcm@openssh.com,aes128-gcm@openssh.com,aes256-ctr,aes192-ctr,aes128-ctr

<% if scope['::operatingsystem'] == 'Darwin' -%>
Host *
  AddKeysToAgent yes
  UseKeychain yes
  IdentityFile ~/.ssh/id_ed25519
  IdentityFile ~/.ssh/id_rsa
<% end -%>

Include <%= scope['::homedir']%>/<%= scope['::dotsecrets']%>/ssh/config_<%= scope['::hostname']%>
    ")
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
    content => "USERNAME = '${userspace::github_user}'\nPASSWORD = '${userspace::grip_github_token}'"
  }

  remote_file { "${::homedir}/.git-prompt.sh":
    ensure => present,
    source => 'https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh',
  }

}


