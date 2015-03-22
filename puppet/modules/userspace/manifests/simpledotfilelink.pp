define userspace::simpledotfilelink ($linkname=$title) {
  userspace::dotfilelink { $linkname:
    targetfile => "${::dotfiles}/${linkname}",
    linkfile   => ".${linkname}",
  }
}


