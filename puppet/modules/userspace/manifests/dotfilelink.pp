define userspace::dotfilelink ($targetfile,$linkfile) {

  file {"${facts['homedir']}/${linkfile}":
    ensure => link,
    target => "${facts['homedir']}/${targetfile}",
  }

}


