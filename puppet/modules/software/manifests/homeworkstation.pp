class software::homeworkstation {

  package { 'network-manager-gnome':
    ensure => absent,
  }

  file {'/etc/network/interfaces.d':
    ensure => directory,
    owner  => 'root',
    group  => 'root',
  }

  file {'/etc/network/interfaces.d/eth0.cfg':
    ensure  => file,
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

}

