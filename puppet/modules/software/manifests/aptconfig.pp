class software::aptconfig {

  case $::lsbdistcodename {
    'trusty': {
      $owncloud_location   = 'http://download.opensuse.org/repositories/isv:/ownCloud:/desktop/Ubuntu_14.04/'
      $owncloud_key_source = 'http://download.opensuse.org/repositories/isv:ownCloud:desktop/Ubuntu_14.04/Release.key'
    }
    'wily':   {
      $owncloud_location   = 'http://download.opensuse.org/repositories/isv:/ownCloud:/desktop/Ubuntu_15.10/'
      $owncloud_key_source = 'http://download.opensuse.org/repositories/isv:ownCloud:desktop/Ubuntu_15.10/Release.key'
    }
    default:  {}
  }

  class { 'apt':
    update => {
      frequency => 'always',
    },
  }

  apt::source { 'owncloud':
    location => $owncloud_location,
    release  => '',
    repos    => '/',
    key      => {
      'id'     =>  'F9EA4996747310AE79474F44977C43A8BA684223',
      'source' => $owncloud_key_source,
    },
    include  => {
      'src' => false,
    },
  }

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

