class software::aptconfig {

  class { 'apt':
    always_apt_update    => true,
  }

  apt::source { 'owncloud':
    location    => 'http://download.opensuse.org/repositories/isv:/ownCloud:/desktop/xUbuntu_14.04/',
    release     => '',
    repos       => '/',
    include_src => false,
    key         => 'BA684223',
    key_source  => 'http://download.opensuse.org/repositories/isv:ownCloud:desktop/xUbuntu_14.04/Release.key',
  }

  apt::source { 'google-earth':
    location    => 'http://dl.google.com/linux/earth/deb/',
    release     => 'stable',
    repos       => 'main',
    include_src => false,
    key         => '7FAC5991',
  }

  apt::source { 'dropbox':
    location    => 'http://linux.dropbox.com/ubuntu',
    release     => 'trusty',
    repos       => 'main',
    include_src => false,
    key         => '5044912E',
  }

  apt::ppa { 'ppa:stebbins/handbrake-snapshots': }
  apt::ppa { 'ppa:jfi/ptask': }
  apt::ppa { 'ppa:jd-team/jdownloader': }
  apt::ppa { 'ppa:cdemu/ppa': }
  apt::ppa { 'ppa:pidgin-gnome-keyring/ppa': }

  apt::source { 'videolan':
    location    => 'http://download.videolan.org/pub/debian/stable/',
    release     => '',
    repos       => '/',
    include_src => false,
    key         => 'B84288D9',
  }

}

