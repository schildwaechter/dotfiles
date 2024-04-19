define userspace::simpledotfilelink ($linkname=$title) {
  userspace::dotfilelink { $linkname:
    targetfile => "${facts['dotfiles']}/${linkname}",
    linkfile   => ".${linkname}",
  }
}


