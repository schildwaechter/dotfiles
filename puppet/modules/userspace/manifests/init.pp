class userspace (
    $displayname       = $facts['identity']['user'],
    $mailaddress       = "${facts['identity']['user']}@${facts['networking']['fqdn']}",
    $conkyrc           = "${facts['dotfiles']}/conkyrc-default",
    $github_user       = '',
    $grip_github_token = '',
    $sshkeys           = [],
  ) {

  class { 'userspace::setupdirs': }

  class { 'userspace::setupfiles':
    require => Class['userspace::setupdirs'],
  }

  unless empty($facts['dotsecrets']) {
    class { 'userspace::include_secrets':
      require => Class['userspace::setupdirs'],
    }
  }


}



