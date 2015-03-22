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
    owner  => 'root',
    group  => 'root',
    mode   => '0644',
    ensure => present,
    source => "${::dotfilespath}/us_cat",
  }

}

