class userspace::setupdirs (
  ) {

  file {"${facts['homedir']}/.bin":
    ensure => directory,
  }

  file {"${facts['homedir']}/.ssh":
    ensure => directory,
  }

  file { "${facts['homedir']}/.config":
    ensure  => directory,
  }

  if $facts['os']['name'] == 'Ubuntu' {
    file { "${facts['homedir']}/.config/fontconfig":
      ensure  => directory,
      require => File["${facts['homedir']}/.config"]
    }

    file { "${facts['homedir']}/.config/fontconfig/conf.d":
      ensure  => directory,
      require => File["${facts['homedir']}/.config/fontconfig"]
    }

    file { "${facts['homedir']}/.config/xfce4":
      ensure  => directory,
      require => File["${facts['homedir']}/.config"]
    }

    file { "${facts['homedir']}/.config/xfce4/terminal":
      ensure  => directory,
      require => File["${facts['homedir']}/.config/xfce4"]
    }

    file { "${facts['homedir']}/.local":
      ensure  => directory,
    }

    file { "${facts['homedir']}/.local/share":
      ensure  => directory,
      require => File["${facts['homedir']}/.local"],
    }

    file { "${facts['homedir']}/.local/share/applications":
      ensure  => directory,
      require => File["${facts['homedir']}/.local/share"],
    }
  }

  file { "${facts['homedir']}/.grip":
    ensure  => directory,
  }

  userspace::dotfilelink { 'nvim':
    targetfile => "${facts['dotfiles']}/nvim",
    linkfile   => '.config/nvim',
  }

}



