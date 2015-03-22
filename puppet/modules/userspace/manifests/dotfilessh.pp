define userspace::dotfilessh ($sshkeyname=$title) {
  userspace::dotfilelink { "sshkey_${sshkeyname}":
    targetfile => "${::dotsecrets}/ssh/${sshkeyname}",
    linkfile   => ".ssh/${sshkeyname}",
  }
  userspace::dotfilelink { "sshkey_${sshkeyname}.pub":
    targetfile => "${::dotsecrets}/ssh/${sshkeyname}.pub",
    linkfile   => ".ssh/${sshkeyname}.pub",
  }
  file { "${::homedir}/${::dotsecrets}/ssh/${sshkeyname}":
    mode => '0400',
  }
  file { "${::homedir}/${::dotsecrets}/ssh/${sshkeyname}.pub":
    mode => '0400',
  }
}


