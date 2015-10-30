class software::aptconfig {

  class { 'apt':
    update      => {
      frequency => 'always',
    },
  }

  apt::source { 'owncloud':
    location    => 'http://download.opensuse.org/repositories/isv:/ownCloud:/desktop/xUbuntu_14.04/',
    release     => '',
    repos       => '/',
    key         => {
      'id'      =>  'F9EA4996747310AE79474F44977C43A8BA684223',
      'source'  => 'http://download.opensuse.org/repositories/isv:ownCloud:desktop/xUbuntu_14.04/Release.key',
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
      'id'   => '4CCA1EAF950CEE4AB83976DCA040830F7FAC5991',
    },
    include  => {
      'src'  => false,
    },
  }

  apt::source { 'dropbox':
    location    => 'http://linux.dropbox.com/ubuntu',
    release     => 'trusty',
    repos       => 'main',
    key         => {
      'id'      =>  '1C61A2656FB57B7E4DE0F4C1FC918B335044912E',
    },
    include  => {
      'src' => false,
    },
  }

  apt::ppa { 'ppa:stebbins/handbrake-snapshots': }
  apt::ppa { 'ppa:cdemu/ppa': }
  apt::ppa { 'ppa:pidgin-gnome-keyring/ppa': }

  apt::source { 'videolan':
    location => 'http://download.videolan.org/pub/debian/stable/',
    release  => '',
    repos    => '/',
    key      => {
      'id'   => '8F0845FE77B16294429A79346BCA5E4DB84288D9',
    },
    include  => {
      'src'  => false,
    },
  }

}

