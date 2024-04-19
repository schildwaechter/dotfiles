define userspace::dotfileexecutable ($executablename=$title) {
  userspace::dotfilelink { "executable_${executablename}":
    targetfile => "${facts['dotfiles']}/bin/${executablename}",
    linkfile   => ".bin/${executablename}",
  }
  file { "${facts['homedir']}/${facts['dotfiles']}/bin/${executablename}":
    mode => '0755',
  }
}


