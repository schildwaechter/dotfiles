class software::puppetdev {

  case $::lsbdistcodename {
    'xenial', 'jessie': {
      $vbox_key_id     = 'B9F8D658297AF3EFC18D5CDFA2F683C52980AECF'
      $vbox_key_source = 'https://www.virtualbox.org/download/oracle_vbox_2016.asc'
     }
    default: {
      $vbox_key_id     = '7B0FAB3A13B907435925D9C954422A4B98AB5139'
      $vbox_key_source = 'https://www.virtualbox.org/download/oracle_vbox.asc'
    }
  }

  apt::source { 'virtualbox':
    location   => 'http://download.virtualbox.org/virtualbox/debian',
    release    => $::lsbdistcodename,
    repos      => 'contrib',
    key        => {
      'id'     => $vbox_key_id,
      'source' => $vbox_key_source,
    },
    include    => {
      'src'    => false,
    },
  }->
  package { 'virtualbox-5.0':
    ensure => installed,
  }

  package { 'librarian-puppet':
    ensure   => latest,
    provider => 'gem',
  }

  package { 'r10k':
    ensure   => latest,
    provider => 'gem',
  }

  package { 'puppet-lint':
    ensure   => latest,
    provider => 'gem',
  }

  package { 'rspec-puppet':
    ensure   => latest,
    provider => 'gem',
  }

  package { 'puppetlabs_spec_helper':
    ensure   => latest,
    provider => 'gem',
  }

  package { 'metadata-json-lint':
    ensure   => latest,
    provider => 'gem',
  }

  package { 'puppet-syntax':
    ensure   => latest,
    provider => 'gem',
  }

  class { 'vagrant': }

  vagrant::plugin { 'vagrant-cachier':
    user => 'cat'
  }

  vagrant::plugin { 'vagrant-vbox-snapshot':
    user => 'cat'
  }

  vagrant::plugin { 'vagrant-hostmanager':
    user => 'cat'
  }

  vagrant::plugin { 'vagrant-vbguest':
    user => 'cat'
  }
}

