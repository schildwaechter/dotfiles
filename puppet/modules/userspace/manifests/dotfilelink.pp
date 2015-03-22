define userspace::dotfilelink ($targetfile,$linkfile) {

  file {"${::homedir}/${linkfile}":
    ensure => link,
    target => "${::homedir}/${targetfile}",
  }

}


