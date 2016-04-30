class software::aptconfig {

  class { 'apt':
    update => {
      frequency => 'always',
    },
  }

  apt::source { 'owncloud':
    location => "http://download.opensuse.org/repositories/isv:/ownCloud:/desktop/Ubuntu_${::lsbdistrelease}/",
    release  => '',
    repos    => '/',
    key      => {
      'id'     => 'F9EA4996747310AE79474F44977C43A8BA684223',
      'source' => "http://download.opensuse.org/repositories/isv:ownCloud:desktop/Ubuntu_${::lsbdistrelease}/Release.key",
    },
    include  => {
      'src' => false,
    },
  }

  if $::lsbdistcodename != 'xenial' {
  # not yet compatible with xenial
    apt::source { 'google-earth':
      location => 'http://dl.google.com/linux/earth/deb/',
      release  => 'stable',
      repos    => 'main',
      key      => {
        'id' => '4CCA1EAF950CEE4AB83976DCA040830F7FAC5991',
      },
      include  => {
        'src' => false,
      },
    }
  }

  apt::ppa { 'ppa:cdemu/ppa': }

  apt::source { 'videolan':
    location => 'http://download.videolan.org/pub/debian/stable/',
    release  => '',
    repos    => '/',
    key      => {
      'id' => '8F0845FE77B16294429A79346BCA5E4DB84288D9',
    },
    include  => {
      'src' => false,
    },
  }

}

