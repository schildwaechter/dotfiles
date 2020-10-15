class software::homeworkstation {

  package { 'handbrake':
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

}

