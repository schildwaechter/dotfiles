class software::aptconfig {

  class { 'apt':
    update => {
      frequency => 'always',
    },
  }

  apt::ppa { 'ppa:nextcloud-devs/client': }

  apt::ppa { 'ppa:cdemu/ppa': }

  apt::source { 'virtualbox':
    location     => 'http://download.virtualbox.org/virtualbox/debian',
    release      => $::lsbdistcodename,
    repos        => 'contrib',
    architecture => 'amd64',
    key          => {
      'id'     => 'B9F8D658297AF3EFC18D5CDFA2F683C52980AECF',
      'source' => 'https://www.virtualbox.org/download/oracle_vbox_2016.asc',
    },
    include      => {
      'src'    => false,
    },
  }

}

