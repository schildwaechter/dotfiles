class userspace::setupdirs (
  ) {

  file {"${::homedir}/.bin":
    ensure => directory,
  }

  file { "${::homedir}/.config":
    ensure  => directory,
  }
  
  file { "${::homedir}/.config/fontconfig":
    ensure  => directory,
    require => File["${::homedir}/.config"]
  }
  
  file { "${::homedir}/.config/fontconfig/conf.d":
    ensure  => directory,
    require => File["${::homedir}/.config/fontconfig"]
  }
  
  file { "${::homedir}/.config/xfce4":
    ensure  => directory,
    require => File["${::homedir}/.config"]
  }
  
  file { "${::homedir}/.config/xfce4/terminal":
    ensure  => directory,
    require => File["${::homedir}/.config/xfce4"]
  }
  
  file { "${::homedir}/.local":
    ensure  => directory,
  }
  
  file { "${::homedir}/.local/share":
    ensure  => directory,
    require => File["${::homedir}/.local"],
  }
  
  file { "${::homedir}/.local/share/applications":
    ensure  => directory,
    require => File["${::homedir}/.local/share"],
  }

  file { "${::homedir}/.grip":
    ensure  => directory,
  }

}



