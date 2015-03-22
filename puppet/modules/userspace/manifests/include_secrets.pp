class userspace::include_secrets {

  userspace::dotfilelink { 'pidgin-logs':
    targetfile => "${::dotsecrets}/pidgin-logs",
    linkfile   => '.purple/logs',
  }

  userspace::dotfilelink { 'fonts':
    targetfile => "${::dotsecrets}/fonts",
    linkfile   => '.fonts',
  }

  userspace::dotfilelink { 'TeX':
    targetfile => "${::dotsecrets}/TeX",
    linkfile   => '.TeX',
  }

}


