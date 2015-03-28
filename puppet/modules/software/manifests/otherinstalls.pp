class software::otherinstalls {

  exec { 'install_puppet-lint':
    path    => ['/usr/bin','/bin','/usr/sbin','/usr/local/bin'],
    command => 'gem install puppet-lint',
    unless  => 'which puppet-lint',
  }

  exec { 'install_grip':
    path    => ['/usr/bin','/bin','/usr/sbin','/usr/local/bin'],
    command => 'pip install grip',
    unless  => 'which grip',
  }

  file {'/usr/share/X11/xkb/symbols/us_cat':
    ensure => present,
    owner  => 'root',
    group  => 'root',
    mode   => '0644',
    source => "${::dotfilespath}/us_cat/us_cat",
  }

  file {'/usr/share/X11/xkb/symbols/de_cat':
    ensure => present,
    owner  => 'root',
    group  => 'root',
    mode   => '0644',
    source => "${::dotfilespath}/us_cat/de_cat",
  }

}

