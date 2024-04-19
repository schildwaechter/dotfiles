class userspace::include_secrets {

  file {"${facts['homedir']}/.purple":
    ensure => directory,
  }
  -> userspace::dotfilelink { 'pidgin-logs':
    targetfile => "${facts['dotsecrets']}/pidgin-logs",
    linkfile   => '.purple/logs',
  }

  userspace::dotfilelink { 'fonts':
    targetfile => "${facts['dotsecrets']}/fonts",
    linkfile   => '.fonts',
  }

  userspace::dotfilelink { 'TeX':
    targetfile => "${facts['dotsecrets']}/TeX",
    linkfile   => '.TeX',
  }

  userspace::dotfilelink { 'face':
    targetfile => "${facts['dotsecrets']}/face",
    linkfile   => '.face',
  }

}


