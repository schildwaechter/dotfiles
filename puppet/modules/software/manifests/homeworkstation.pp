class software::homeworkstation {

  apt::ppa { 'ppa:stebbins/handbrake-releases': }
  ->
  package { 'handbrake-gtk':
    ensure => installed
  }

  package {
    'easytag':               ensure => installed;
    'lame':                  ensure => installed;
    'libdvdcss2':            ensure => installed;
    'cdparanoia':            ensure => installed;
    'openssh-server':        ensure => installed;
    'gcdemu':                ensure => installed;
  }

  package { 'network-manager-gnome':
    ensure => absent,
  }

  file {'/etc/network/interfaces.d/eth0.cfg':
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => '# DHCP for eth0 set through puppet
auto eth0
iface eth0 inet dhcp
'
  }

  file_line {'interfaces_source_eth0':
    path => '/etc/network/interfaces',
    line => 'source /etc/network/interfaces.d/eth0.cfg',
  }

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

}

