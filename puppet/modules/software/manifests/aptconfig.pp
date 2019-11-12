class software::aptconfig {

  class { 'apt':
    update => {
      frequency => 'always',
    },
  }


  apt::ppa { 'ppa:nextcloud-devs/client': }

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

  apt::source { 'virtualbox':
    location   => 'http://download.virtualbox.org/virtualbox/debian',
    release    => $::lsbdistcodename,
    repos      => 'contrib',
    key        => {
      'id'     => 'B9F8D658297AF3EFC18D5CDFA2F683C52980AECF',
      'source' => 'https://www.virtualbox.org/download/oracle_vbox_2016.asc',
    },
    include    => {
      'src'    => false,
    },
  }

}

