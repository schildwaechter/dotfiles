class software::homeworkstation {

  apt::ppa { 'ppa:stebbins/handbrake-snapshots': }

  package {
    'handbrake-gtk':         ensure => installed;
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


  apt::source { 'virtualbox':
    location   => 'http://download.virtualbox.org/virtualbox/debian',
    release    => $::lsbdistcodename,
    repos      => 'contrib',
    key        => {
      'id'     => '7B0FAB3A13B907435925D9C954422A4B98AB5139',
      'source' => 'https://www.virtualbox.org/download/oracle_vbox.asc',
    },
    include    => {
      'src'    => false,
    },
  }->
  package { 'virtualbox-5.0':
    ensure => installed,
  }


}

