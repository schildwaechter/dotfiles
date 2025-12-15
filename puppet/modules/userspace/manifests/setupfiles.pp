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
    'tmux.conf',
    'vim', 'vimrc', 'gvimrc',
  ]
  userspace::simpledotfilelink { $simpledotfilelinks : }

  if $facts['os']['name'] == 'Debian' {
    file { "${facts['homedir']}/.config/fontconfig":
      ensure => directory
    }
    file { "${facts['homedir']}/.config/fontconfig/conf.d":
      ensure => directory
    }
    userspace::dotfilelink { 'powerline-symbols':
      targetfile => "${facts['dotfiles']}/powerline-symbols.conf",
      linkfile   => '.config/fontconfig/conf.d/10-powerline-symbols.conf',
    }
    file { "${facts['homedir']}/.local":
      ensure => directory
    }
    file { "${facts['homedir']}/.local/share":
      ensure => directory
    }
    file { "${facts['homedir']}/.local/share/applications":
      ensure => directory
    }
    file { "${facts['homedir']}/.local/share/applications/mimeapps.list":
      ensure => present,
      source => "${facts['homedir']}/${facts['dotfiles']}/local-mimeapps.list",
      backup => true,
    }
    userspace::dotfilelink { 'conkyrc':
      targetfile => $userspace::conkyrc,
      linkfile   => '.conkyrc',
    }
  }

  file { "${facts['homedir']}/.bashrc_dotfiles":
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
<% if @os['family'] == 'Debian' -%>
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
<% if @os['family'] == 'Debian' -%>
      echo -e \"dotfiles software [install software via sudo puppet apply] \\n\"
<% end -%>
      tput sgr0
    ;;
  esac
}
_dotfiles()
{
    local cur=\${COMP_WORDS[COMP_CWORD]}
<% if @os['family'] == 'Debian' -%>
    COMPREPLY=( \$(compgen -W \"upgrade update status software\" -- \$cur) )
<% else -%>
    COMPREPLY=( \$(compgen -W \"upgrade update status\" -- \$cur) )
<% end -%>
}
complete -F _dotfiles dotfiles

<% if @os['family'] == 'Debian' -%>
alias mvim='gvim'
<% end -%>

export DEBFULLNAME='<%= scope['::userspace::displayname'] %>'
export DEBEMAIL='<%= scope['::userspace::mailaddress'] %>'

# ###############
# DO EDITS THERE:
. ~/<%= scope['::dotfiles'] %>/bashrc
    "),
  }

  file { "${facts['homedir']}/.zshrc_dotfiles":
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
<% if @os['family'] == 'Debian' -%>
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
<% if @os['family'] == 'Debian' -%>
      echo -e \"dotfiles software [install software via sudo puppet apply] \\n\"
<% end -%>
      tput sgr0
    ;;
  esac
}
_dotfiles()
{
    local cur=\${COMP_WORDS[COMP_CWORD]}
<% if @os['family'] == 'Debian' -%>
    COMPREPLY=( \$(compgen -W \"upgrade update status software\" -- \$cur) )
<% else -%>
    COMPREPLY=( \$(compgen -W \"upgrade update status\" -- \$cur) )
<% end -%>
}
complete -F _dotfiles dotfiles

<% if @os['family'] == 'Debian' -%>
alias mvim='gvim'
<% end -%>
source ~/.profile

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
   \" >> ${facts['homedir']}/.bashrc",
    unless  => "grep 'bashrc_dotfiles' ${facts['homedir']}/.bashrc",
  }

  exec { 'install_zshrc_dotfiles':
    path    => ['/usr/bin','/bin','/usr/sbin'],
    command => "echo \"
# THE FOLLOWING IS ADDED BY PUPPET !!!
# uncomment to disable (deleting is futile)
if [ -f ~/.zshrc_dotfiles ]; then
    . ~/.zshrc_dotfiles
fi
   \" >> ${facts['homedir']}/.zshrc",
    unless  => "grep 'zshrc_dotfiles' ${facts['homedir']}/.zshrc",
  }

  file { "${facts['homedir']}/.profile_dotfiles":
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
   \" >> ${facts['homedir']}/.profile",
    unless  => "grep 'profile_dotfiles' ${facts['homedir']}/.profile",
  }

  file { "${facts['homedir']}/.gitconfig":
    ensure  => present,
    content =>  inline_template("[user]
  name = <%= scope['::userspace::displayname'] %>
  email = <%= scope['::userspace::mailaddress']%>
  signingkey = <%= scope['::userspace::gitsigningkey']%>

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

[gpg]
  format = ssh

[gpg \"ssh\"]
  program = /Applications/1Password.app/Contents/MacOS/op-ssh-sign
  allowedSignersFile = <%= scope['::homedir']%>/<%= scope['::dotsecrets']%>/ssh/allowed_git_signers

[commit]
  gpgsign = true
    ")
  }

  file { "${facts['homedir']}/.ssh/config":
    ensure  => present,
    content =>  inline_template("# ssh config following mozilla guidelines - https://infosec.mozilla.org/guidelines/openssh.html
# Ensure KnownHosts are unreadable if leaked - it is otherwise easier to know which hosts your keys have access to.
HashKnownHosts yes
# Host keys the client accepts - order here is honored by OpenSSH
HostKeyAlgorithms ssh-ed25519-cert-v01@openssh.com,ssh-rsa-cert-v01@openssh.com,ssh-ed25519,ssh-rsa,ecdsa-sha2-nistp521-cert-v01@openssh.com,ecdsa-sha2-nistp384-cert-v01@openssh.com,ecdsa-sha2-nistp256-cert-v01@openssh.com,ecdsa-sha2-nistp521,ecdsa-sha2-nistp384,ecdsa-sha2-nistp256

KexAlgorithms curve25519-sha256@libssh.org,ecdh-sha2-nistp521,ecdh-sha2-nistp384,ecdh-sha2-nistp256,diffie-hellman-group-exchange-sha256
MACs hmac-sha2-512-etm@openssh.com,hmac-sha2-256-etm@openssh.com,umac-128-etm@openssh.com,hmac-sha2-512,hmac-sha2-256,umac-128@openssh.com
Ciphers chacha20-poly1305@openssh.com,aes256-gcm@openssh.com,aes128-gcm@openssh.com,aes256-ctr,aes192-ctr,aes128-ctr

<% if @os['family'] == 'Darwin' -%>
Host *
  AddKeysToAgent yes
  UseKeychain yes
  IdentityFile ~/.ssh/id_ed25519
  IdentityFile ~/.ssh/id_rsa
<% end -%>

Include <%= scope['::homedir']%>/<%= scope['::dotsecrets']%>/ssh/config_<%= @networking['hostname']%>

    ")
  }



  if $facts['os']['name'] == 'Debian' {
    $dotfileexecutables = [
      'gitdiff.py',
      'myipv4',
      'myipv6',
      'colog',
      'gtk_cleanup.py',
    ]
    userspace::dotfileexecutable { $dotfileexecutables: }

    file { "${facts['homedir']}/.config/xfce4/terminal/terminalrc":
      ensure => present,
      source => "${facts['homedir']}/${facts['dotfiles']}/xfce4-terminalrc",
    }
  } elsif $facts['os']['name'] == 'Darwin' {
    $dotfileexecutables = [
      'gitdiff.py',
    ]
    userspace::dotfileexecutable { $dotfileexecutables: }
  }

  file { "${facts['homedir']}/.zprofile":
    ensure  => present,
    content => "export SHELL_SESSIONS_DISABLE=1\n",
  }

  file { "${facts['homedir']}/.hushlogin":
    ensure  => present,
    content => '',
  }

  file { "${facts['homedir']}/.grip/settings.py":
    ensure  => present,
    content => "USERNAME = '${userspace::github_user}'\nPASSWORD = '${userspace::grip_github_token}'"
  }

  remote_file { "${facts['homedir']}/.git-prompt.sh":
    ensure => present,
    source => 'https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh',
  }

  vcsrepo { "${facts['homedir']}/.local/share/zinit/zinit.git":
    ensure   => present,
    provider => git,
    source   => 'https://github.com/zdharma-continuum/zinit.git',
    revision => 'v3.13.1',
  }

}
