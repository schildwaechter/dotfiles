class software::aptconfig {

  class { 'apt':
    update => {
      frequency => 'always',
    },
  }

  #### NEED TO ADD crontrib & non-free to debian!!!!!!

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


archive { '/tmp/packages.microsoft.gpg':
  source          => 'https://packages.microsoft.com/keys/microsoft.asc',
  extract         => true,
  extract_path    => '/etc/apt/keyrings/',
  extract_command => 'gpg --dearmor < %s > /etc/apt/keyrings/packages.microsoft.gpg',
  creates         => '/etc/apt/keyrings/packages.microsoft.gpg',
}


  apt::source { 'vscode':
    location     => 'https://packages.microsoft.com/repos/code',
    release      => 'stable',
    repos        => 'main',
    architecture => 'amd64',
    keyring => '/etc/apt/keyrings/packages.microsoft.gpg',
    include      => {
      'src'    => false,
    },
  }


}

