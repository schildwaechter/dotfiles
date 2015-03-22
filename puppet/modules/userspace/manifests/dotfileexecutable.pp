define userspace::dotfileexecutable ($executablename=$title) {
  userspace::dotfilelink { "executable_${executablename}":
    targetfile => "${::dotfiles}/bin/${executablename}",
    linkfile   => ".bin/${executablename}",
  }
  file { "${::homedir}/${::dotfiles}/bin/${executablename}":
    mode => '0755',
  }
}


