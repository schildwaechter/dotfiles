class userspace (
    $displayname       = $::id,
    $mailaddress       = "${::id}@${::fqdn}",
    $conkyrc           = "conkyrc-${::hostname}",
    $taskd_credentials = '',
    $taskd_server      = '',
    $grip_github_token = '',
    $sshkeys           = [],
  ) {

  class { 'userspace::setupdirs': }
  
  class { 'userspace::setupfiles':
    require => Class['userspace::setupdirs'],
  }

  if empty($::dotsecrets) {
    $include_dotsecrets = false
  } else {
    $include_dotsecrets = true
  }
  if $include_dotsecrets {
    class { 'userspace::include_secrets':
      require => Class['userspace::setupdirs'],
    }
  }


}



