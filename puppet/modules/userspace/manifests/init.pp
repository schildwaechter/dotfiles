class userspace (
    $displayname       = $::id,
    $mailaddress       = "${::id}@${::fqdn}",
    $conkyrc           = "${::dotfiles}/conkyrc-default",
    $taskd_credentials = '',
    $taskd_server      = '',
    $grip_github_token = '',
    $sshkeys           = [],
  ) {

  class { 'userspace::setupdirs': }
  
  class { 'userspace::setupfiles':
    require => Class['userspace::setupdirs'],
  }

  unless empty($::dotsecrets) {
    class { 'userspace::include_secrets':
      require => Class['userspace::setupdirs'],
    }
  }


}



